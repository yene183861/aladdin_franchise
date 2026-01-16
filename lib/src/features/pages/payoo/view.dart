import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redis/redis.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';

/// (bool true, dynamic amount) => Nếu nhận được trạng thái thanh toán thành công
///
/// (bool false, dynamic amount) => Nếu đóng và xác nhận chưa thanh toán

class PaymentGatewayPage extends ConsumerStatefulWidget {
  const PaymentGatewayPage({
    super.key,
    required this.paymentMethod,
    required this.gatewayUrl,
    required this.qr,
    required this.order,
  });
  final PaymentMethod paymentMethod;
  final String gatewayUrl;
  final String qr;
  final OrderModel order;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentGatewayPageState();
}

class _PaymentGatewayPageState extends ConsumerState<PaymentGatewayPage> {
  WebviewController? _windowsController;

  WebViewController? _androidController;
  int loadingPercent = 0;
  StreamSubscription<dynamic>? streamSubscription;
  bool realtimeStatus = false;
  String redisErrorMessage = "";
  bool redisConnecting = false;
  bool confirmPaymentSuccess = false;

  @override
  void initState() {
    super.initState();

    initWebviewController();

    // redis
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _connectToRedis();
    });
  }

  void initWebviewController() async {
    try {
      if (Platform.isWindows) {
        _windowsController = WebviewController();
        await _windowsController!.initialize();
        await _windowsController!.setBackgroundColor(Colors.transparent);
        await _windowsController!.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
        await _windowsController!.loadUrl(widget.gatewayUrl);

        setState(() {});
        // var state = ref.read(homeProvider);

        // List<ProductCheckoutModel> sortProductCheckout = [];
        // state.currentOrderItems.forEach((element) {
        //   var p =
        //       state.productCheckout.firstWhereOrNull((e) => e.id == element.id);
        //   if (p != null) {
        //     var exist =
        //         sortProductCheckout.firstWhereOrNull((e) => e.id == element.id);
        //     if (exist == null) {
        //       sortProductCheckout.add(p);
        //     }
        //   }
        // });
      } else if (Platform.isAndroid) {
        _androidController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                setState(() {
                  loadingPercent = progress;
                });
                showLog(loadingPercent);
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {
                showLog(url, flags: 'onPageFinished');
                setState(() {
                  loadingPercent = 100;
                });
              },
              onWebResourceError: (WebResourceError error) {
                //
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.gatewayUrl));
      }
    } on PlatformException catch (e) {
      showLogs(e.toString(), flags: 'initWebviewController PlatformExcep');
    } catch (ex) {
      showLogs(ex.toString(), flags: 'initWebviewController ex');
    }
  }

  Future<void> _connectToRedis() async {
    try {
      setState(() {
        redisConnecting = true;
      });
      final restaurant = LocalStorage.getDataLogin()?.restaurant;
      final redisGateway = restaurant?.redisGatewayPayment;
      if (redisGateway?.isEmpty() ?? false) {
        throw S.current.error_payment_recognition_server_not_configure;
      }
      showLog(redisGateway, flags: 'redisGateway');
      final channelPayment = "payment_result_${restaurant?.id}_${widget.order.id}";
      showLog(channelPayment, flags: 'channelPayment');
      final ip = redisGateway?.host;
      final port = redisGateway?.port;
      final redisConnection = RedisConnection();
      showLog("$ip:$port", flags: "Connecting to");
      final command = await redisConnection.connect(ip, port);
      if (redisGateway?.password != null) {
        await command.send_object(["AUTH", redisGateway?.password]);
      }
      showLog(command, flags: 'command');
      final pubSub = PubSub(command);
      pubSub.subscribe([channelPayment]);
      final stream = pubSub.getStream();
      streamSubscription = stream.listen(
        (event) {
          showLog(event, flags: "New event check");
          //[message, item-channel, {"event":"App\\Events\\ItemCreated","data":{"data":"created item","socket":null},"socket":null}]
          try {
            if (event[0] == "message") {
              if (event[1] == channelPayment) {
                final dataDecode = jsonDecode(event[2])['data'];
                showLog(dataDecode, flags: 'data event');
                if (dataDecode['data']['payment_status'] == 1) {
                  final amount = dataDecode['data']['amount'];
                  pop(context, (status: true, amount: amount));
                }
              }
            }
          } catch (ex) {
            showLog(ex, flags: "Error listen redis");
          }
        },
        onError: (_, __) async {
          showLog("onError listing $_ $__");
          await redisConnection.close();
          await streamSubscription?.cancel();
        },
        onDone: () async {
          showLog("end listing");
          await redisConnection.close();
          await streamSubscription?.cancel();
        },
      );
      showLog("$ip:$port", flags: "Listen");
      setState(() {
        realtimeStatus = true;
      });
      // _openUrlOnDesktop();
    } catch (ex) {
      showLog(ex, flags: 'RedisConnection error');
      redisErrorMessage = ex.toString();
      await streamSubscription?.cancel();
    } finally {
      setState(() {
        redisConnecting = false;
      });
    }
  }

  @override
  void dispose() {
    _windowsController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${S.current.payment_gateway} (${widget.paymentMethod.getNameView()})'),
        leading: CloseButton(
          onPressed: () {
            showConfirmActionWithChild(
              context,
              child: _ConfirmCloseGatewayWidget(
                onChanged: (value) {
                  setState(() {
                    confirmPaymentSuccess = value;
                  });
                },
              ),
              action: () {
                if (Platform.isAndroid) {
                  _androidController?.loadRequest(Uri.parse('about:blank'));
                }
                pop(context, (status: confirmPaymentSuccess, amount: null));
              },
              actionCancel: () {
                setState(() {
                  confirmPaymentSuccess = false;
                });
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showConfirmAction(context, message: S.current.confirm_reload_payment_gateway,
                  action: () {
                if (Platform.isWindows) {
                  _windowsController?.reload();
                }
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Platform.isAndroid
              ? _androidController == null
                  ? Text(S.current.driver_not_initialized)
                  : WebViewWidget(
                      controller: _androidController!,
                    )
              : !(_windowsController?.value.isInitialized ?? false)
                  ? Center(
                      child: Text(
                        S.current.driver_not_initialized,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  : Webview(
                      _windowsController!,
                      permissionRequested: _onPermissionRequested,
                    ),
          //   StreamBuilder<LoadingState>(
          //       stream: _windowsController!.loadingState,
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData &&
          //             snapshot.data == LoadingState.loading) {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         } else {
          //           return const SizedBox.shrink();
          //         }
          //       }),
          // ],
          // );
//  ,
          if (Platform.isAndroid && loadingPercent < 100)
            Container(
              width: 100.w,
              height: 100.h,
              color: Colors.grey.withOpacity(0.5),
              alignment: Alignment.center,
              child: Container(
                width: 33.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade300,
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinearProgressIndicator(
                      value: loadingPercent.toDouble() / 100,
                      backgroundColor: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    const GapH(8),
                    Text(
                      S.current.opening_payment_gateway,
                    ),
                  ],
                ),
              ),
            ),
          if (redisConnecting == false && realtimeStatus == false)
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade300,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.current.failed_connect_payment_verification_server,
                    style: AppTextStyle.regular(
                      color: AppColors.redColor,
                    ),
                  ),
                  if (redisErrorMessage.isNotEmpty)
                    Text(
                      redisErrorMessage,
                      style: AppTextStyle.regular(
                        color: AppColors.redColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  Text(
                    S.current.using_other_payment_method_if_failed,
                    style: AppTextStyle.regular(),
                  ),
                  const GapH(20),
                  ButtonWithIconWidget(
                    icon: Icons.link,
                    textAction: S.current.reconnect,
                    onPressed: () async {
                      await _connectToRedis();
                    },
                  ),
                ],
              ),
            ),
          if (redisConnecting)
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade300,
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const GapW(8),
                    Text(
                      S.current.connecting_payment_verification_server,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: AppConfig.navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: Text(S.current.webview_permission_request),
        content: Text('${S.current.webview_permission_request_1} \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, WebviewPermissionDecision.deny),
            child: Text(S.current.deny),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, WebviewPermissionDecision.allow),
            child: Text(S.current.allow),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }
}

class _ConfirmCloseGatewayWidget extends StatefulWidget {
  const _ConfirmCloseGatewayWidget({
    super.key,
    required this.onChanged,
  });
  final Function(bool) onChanged;
  @override
  State<_ConfirmCloseGatewayWidget> createState() => _ConfirmCloseGatewayWidgetState();
}

class _ConfirmCloseGatewayWidgetState extends State<_ConfirmCloseGatewayWidget> {
  bool confirmPaymentSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.msg_auto_close_payment_gateway,
          style: AppTextStyle.bold(),
        ),
        Text(
          S.current.msg_close_payment_gateway_manually,
          style: AppTextStyle.bold(
            color: AppColors.redColor,
          ),
        ),
        const GapH(8),
        RadioListTile<bool>(
          value: false,
          groupValue: confirmPaymentSuccess,
          title: Text(
            S.current.customer_not_paid,
            style: !confirmPaymentSuccess ? AppTextStyle.bold() : null,
          ),
          onChanged: (value) {
            widget.onChanged.call(value ?? false);
            setState(() {
              confirmPaymentSuccess = false;
            });
          },
        ),
        RadioListTile<bool>(
          value: true,
          groupValue: confirmPaymentSuccess,
          title: Text(
            S.current.customer_paid,
            style: confirmPaymentSuccess ? AppTextStyle.bold() : null,
          ),
          onChanged: (value) {
            widget.onChanged.call(value ?? true);
            setState(() {
              confirmPaymentSuccess = true;
            });
          },
        ),
        const GapH(8),
        Text(
          S.current.cancel_payment_method_if_customer_not_paid,
          style: AppTextStyle.bold(
            fontStyle: FontStyle.italic,
            rawFontSize: 13,
            color: Colors.orangeAccent,
          ),
        ),
      ],
    );
  }
}
