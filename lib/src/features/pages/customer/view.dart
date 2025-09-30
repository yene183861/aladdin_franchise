import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/app.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/windows_method.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_method_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/customer/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';

import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_windows/webview_windows.dart';

import 'components/barrel_component.dart';

enum PaymentStatus {
  loading,
  success,
  fail,
  cancel,
  close,
}

extension PaymentStatusEx on PaymentStatus {
  int get type {
    switch (this) {
      case PaymentStatus.loading:
        return 1;
      case PaymentStatus.success:
        return 2;
      case PaymentStatus.fail:
        return 3;
      case PaymentStatus.cancel:
        return 4;
      case PaymentStatus.close:
        return 5;
    }
  }
}

PaymentStatus convertPaymentStatus(int type) {
  switch (type) {
    case 1:
      return PaymentStatus.loading;
    case 2:
      return PaymentStatus.success;
    case 3:
      return PaymentStatus.fail;
    case 4:
      return PaymentStatus.cancel;
    case 5:
      return PaymentStatus.close;
    default:
      return PaymentStatus.close;
  }
}

class CustomerPage extends ConsumerStatefulWidget {
  CustomerPage({
    super.key,
    this.windowController,
    this.args = const {},
  }) : assert(!Platform.isWindows || windowController != null);
  final WindowController? windowController;

  final Map<String, dynamic> args;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerPageState();
}

class _CustomerPageState extends ConsumerState<CustomerPage> {
  late ValueNotifier<List<ProductCheckoutModel>> productsNotifier;
  late ValueNotifier<CustomerModel?> customerNotifier;
  late ValueNotifier<PriceDataBill> dataBillNotifier;
  late ValueNotifier<PaymentMethod?> paymentMethodNotifier;
  late ValueNotifier<Map<String, dynamic>> detailPaymentNotifier;
  late ValueNotifier<OrderModel?> orderNotifier;
  late ValueNotifier<List<ProductModel>> allProductsNotifier;
  late ValueNotifier<String> linkOANotifier;
  late ValueNotifier<PaymentStatus?> paymentStatusNotifier;
  late ValueNotifier<String> noteNotifier;

  late ValueNotifier<bool> gatewayNotifier;
  late ValueNotifier<String> languageNotifier;

  BuildContext? rootContext;

  late TextEditingController _noteTextController;

  @override
  void initState() {
    super.initState();
    _noteTextController = TextEditingController();
    allProductsNotifier = ValueNotifier<List<ProductModel>>([]);
    orderNotifier = ValueNotifier<OrderModel?>(null);
    productsNotifier = ValueNotifier<List<ProductCheckoutModel>>([]);
    customerNotifier = ValueNotifier<CustomerModel?>(null);
    dataBillNotifier = ValueNotifier<PriceDataBill>(const PriceDataBill());
    paymentMethodNotifier = ValueNotifier<PaymentMethod?>(null);
    detailPaymentNotifier = ValueNotifier<Map<String, dynamic>>({});
    linkOANotifier = ValueNotifier<String>('');
    paymentStatusNotifier = ValueNotifier<PaymentStatus?>(null);
    noteNotifier = ValueNotifier<String>('');
    gatewayNotifier = ValueNotifier<bool>(false);
    languageNotifier =
        ValueNotifier<String>(LocalStorage.getCustomerLanguageLocal());
    if (Platform.isWindows) {
      DesktopMultiWindow.setMethodHandler(_handleMethodCallback);
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        _convertData(widget.args);
        ref.read(customerPageProvider.notifier).init();
        setState(() {
          rootContext = context;
        });
      },
    );
  }

  void _convertData(Map<String, dynamic> data) {
    try {
      allProductsNotifier.value = (data['all_products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } catch (ex) {
      //
    }
    try {
      var orderId = orderNotifier.value?.id;
      orderNotifier.value =
          data['order'] == null ? null : OrderModel.fromJson(data['order']);
      if (orderNotifier.value?.id != null &&
          orderId != orderNotifier.value?.id) {
        _paymentTimer?.cancel();
        paymentStatusNotifier.value = PaymentStatus.close;
      }
    } catch (ex) {
      //
    }
    try {
      productsNotifier.value = (data['products'] as List)
          .map((item) => ProductCheckoutModel.fromJson(item))
          .toList();
    } catch (ex) {
      //
    }

    try {
      customerNotifier.value = data['customer'] == null
          ? null
          : CustomerModel.fromJson(data['customer']);
    } catch (ex) {
      //
    }

    try {
      var value = data['note'] as String;
      _noteTextController.text =
          value.trim().isNotEmpty ? '${S.current.note}: $value' : '';
      noteNotifier.value =
          value.trim().isNotEmpty ? '${S.current.note}: $value' : '';
    } catch (ex) {
      //
    }
    try {
      paymentMethodNotifier.value = data['payment_method'] == null
          ? null
          : PaymentMethod.fromJson(data['payment_method']);
    } catch (ex) {
      //
    }

    try {
      dataBillNotifier.value = PriceDataBill.fromJson(data['data_bill']);
    } catch (ex) {
      //
    }

    try {
      detailPaymentNotifier.value =
          data['detail_payment'] ?? <String, dynamic>{};
      _startPayooTimer(Duration(seconds: data['detail_payment']['expiry_min']));
    } catch (ex) {
      //
    }
    try {
      var orderProduct = data['order_product'];
      if (orderProduct != null) {
        ref.read(customerPageProvider.notifier).onChangeChangedProductId(
            orderProduct['changed_product_id'] is int?
                ? orderProduct['changed_product_id']
                : null);
      }
    } catch (ex) {
      //
    }
  }

  bool isShowLinkZaloOA = false;
  bool isShowPaymentInfo = false;

  Timer? _paymentTimer;

  int paymentSuccessDuration = 15;

  void _startTimer() {
    _paymentTimer = Timer.periodic(
      Duration(seconds: paymentSuccessDuration),
      (timer) {
        _paymentTimer?.cancel();
        paymentStatusNotifier.value = PaymentStatus.close;
      },
    );
  }

  void _startPayooTimer(Duration duration) {
    var seconds = duration.inSeconds;
    gatewayNotifier.value = true;
    // showLogs(seconds, flags: 'seconds check 1233');
    // if (seconds == 0) {
    //   gatewayNotifier.value = false;
    //   _payooTimer?.cancel();
    //   return;
    // }
    // gatewayNotifier.value = true;
    // _payooTimer = Timer.periodic(
    //   Duration(seconds: max(0, seconds)),
    //   (timer) {
    //     _payooTimer?.cancel();
    //     gatewayNotifier.value = false;
    //   },
    // );
  }

  void showPaymentInfo({
    bool isGateway = false,
    String gatewayUrl = '',
    PaymentStatus paymentStatus = PaymentStatus.loading,
  }) async {
    // if (rootContext != null && rootContext!.mounted) {
    switch (paymentStatus) {
      case PaymentStatus.loading:
        if (isGateway && gatewayUrl.trim().isNotEmpty) {
          // setState(() {
          //   _gatewayUrl = gatewayUrl;
          // });
          return;
        }
        showLogs(context, flags: 'context');
        if (!isShowPaymentInfo) {
          isShowPaymentInfo = true;
          showMessageDialog(context,
              message: S.current.completing_payment_verification,
              showAction: false);
        }

        break;
      case PaymentStatus.success:
        // đóng cửa sổ loading
        showLogs(isShowPaymentInfo, flags: 'isShowPaymentInfo 1');
        if (isShowPaymentInfo) {
          pop(context);
        }
        _startTimer();
        await showDialog(
          context: context,
          barrierDismissible: false,
          useSafeArea: true,
          builder: (context) {
            showLogs(context, flags: 'context 1');
            return PopScope(
              canPop: false,
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: paymentStatusNotifier,
                        builder: (ctx, value, child) {
                          if (value == PaymentStatus.close) {
                            Navigator.of(context).pop();
                            isShowPaymentInfo = false;
                          }
                          var restaurant =
                              LocalStorage.getDataLogin()?.restaurant;
                          return Text(
                            '${S.current.payment_successful}\n${(restaurant?.name ?? '').isNotEmpty ? S.current.msg_thanks_customer(restaurant?.name ?? '') : ''}',
                            style: AppTextStyle.bold(),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                      const GapH(8),
                      Text(
                        '${S.current.dialog_auto_close_after} ${paymentSuccessDuration}s',
                        style:
                            AppTextStyle.regular(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );

        break;
      case PaymentStatus.fail:
        // faild
        break;
      case PaymentStatus.cancel:
        // đóng cửa sổ loading

        showLogs(isShowPaymentInfo, flags: 'isShowPaymentInfo 1');
        if (!isShowPaymentInfo) {
          pop(context);
          isShowPaymentInfo = false;
        }
        paymentStatusNotifier.value = null;
        break;
      default:
    }
    // }
  }

  void showLinkZaloOA() async {
    if (rootContext != null && rootContext!.mounted) {
      isShowLinkZaloOA = true;

      await showDialog(
        context: rootContext!,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              title: Text(
                S.current.register_customers_via_zalo_oa,
                style: AppTextStyle.bold(),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder(
                    valueListenable: linkOANotifier,
                    builder: (context, value, child) {
                      if (value.isEmpty) {
                        Navigator.of(context).pop();
                        isShowLinkZaloOA = false;
                        return Container();
                      }
                      return SizedBox(
                        width: 256,
                        height: 256,
                        child: QrImageView(
                          data: value,
                          eyeStyle: const QrEyeStyle(
                            color: AppColors.mainColor,
                            eyeShape: QrEyeShape.square,
                          ),
                        ),
                      );
                    },
                  ),
                  const GapH(8),
                  Text(S.current.use_camera_zalo_to_scan_the_code),
                ],
              ),
            ),
          );
        },
      );
    } else {
      isShowLinkZaloOA = false;
    }
  }

  Future<dynamic> _handleMethodCallback(
      MethodCall call, int fromWindowId) async {
    var data = jsonDecode(call.arguments);
    if (call.method == WindowsMethod.closeApp.value) {
      widget.windowController?.close();
      return;
    } else if (call.method == WindowsMethod.language.value) {
      if (rootContext?.mounted ?? false) {
        setCustomerLocale(data);
      }
      return;
    }
    if (call.method == WindowsMethod.payment.value) {
      var isGateway = data['is_gateway'] ?? false;
      var gatewayUrl = data['gateway_url'] ?? '';
      var paymentStatus = convertPaymentStatus(data['status']);
      var qrCode = data['qr_code'] ?? '';

      showLogs(isGateway, flags: 'isGateway');
      showLogs(gatewayUrl, flags: 'gatewayUrl');
      if (paymentStatus == paymentStatusNotifier.value) {
        return;
      }
      paymentStatusNotifier.value = paymentStatus;

      showPaymentInfo(
        isGateway: isGateway,
        gatewayUrl: gatewayUrl,
        paymentStatus: paymentStatus,
      );
      return;
    }

    if (call.method == WindowsMethod.linkZaloOA.value) {
      linkOANotifier.value = data;
      if (!isShowLinkZaloOA) {
        showLinkZaloOA();
      }
      return;
    }
    if (call.method == WindowsMethod.changeOrderProduct.value) {
      var autoScroll = data['auto_scroll_order_product'] ?? true;
      var changedProductId = data['changed_product_id'];

      ref
          .read(customerPageProvider.notifier)
          .onChangeAutoScrollProducts(autoScroll);
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          ref
              .read(customerPageProvider.notifier)
              .onChangeChangedProductId(changedProductId);
        },
      );
      return;
    }
    _convertData(data);
  }

  @override
  void dispose() {
    if (Platform.isWindows) {
      DesktopMultiWindow.setMethodHandler(null);
    }
    allProductsNotifier.dispose();
    orderNotifier.dispose();
    productsNotifier.dispose();
    customerNotifier.dispose();
    dataBillNotifier.dispose();
    paymentMethodNotifier.dispose();
    detailPaymentNotifier.dispose();
    linkOANotifier.dispose();
    _paymentTimer?.cancel();
    paymentStatusNotifier.dispose();
    noteNotifier.dispose();
    gatewayNotifier.dispose();

    _noteTextController.dispose();
    languageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double defaultPaddingHorizontalPage = 12;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ValueListenableBuilder(
        valueListenable: orderNotifier,
        builder: (context, value, child) {
          if (value == null) {
            return AppImageCacheNetworkWidget(
              imageUrl: "https://haisu.vn/Upload/Banner/310525104657.jpg",
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite,
              errorWidget: Image.asset(
                Assets.imagesLogoH,
                height: 100,
                fit: BoxFit.cover,
              ),
            );
          }
          return Row(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  ref.watch(customerPageProvider);
                  return const SizedBox.shrink();
                },
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPaddingHorizontalPage,
                        vertical: 4,
                      ),
                      color: Color(0xff292929),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: orderNotifier,
                                    builder: (context, value, child) {
                                      if (value == null) {
                                        return const SizedBox.shrink();
                                      }
                                      return Text(
                                        '${S.current.table_served}: ${S.current.table} ${value.getNameView()}',
                                        style: AppTextStyle.bold(
                                            color: AppColors.white),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FittedBox(
                            child: Chip(
                              label: Text(
                                S.current.infoVAT,
                                style: AppTextStyle.regular(
                                  // fontSize: 12.sp,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                              child: ValueListenableBuilder(
                            valueListenable: allProductsNotifier,
                            builder: (context, allProducts, child) {
                              return ValueListenableBuilder(
                                valueListenable: noteNotifier,
                                builder: (context, note, child) =>
                                    ValueListenableBuilder(
                                  valueListenable: productsNotifier,
                                  builder: (context, value, child) {
                                    return ListOrderProduct(
                                      data: [
                                        ...value,
                                        if (note.trim().isNotEmpty) note.trim(),
                                      ],
                                      allProducts: allProducts,
                                      horizontalPadding:
                                          defaultPaddingHorizontalPage,
                                      noteTextEditingController:
                                          _noteTextController,
                                    );
                                  },
                                ),
                              );
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(left: 2),
                  color: AppColors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: ValueListenableBuilder(
                          valueListenable: customerNotifier,
                          builder: (context, value, child) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _TitleSection(
                                  defaultPaddingHorizontalPage: 12,
                                  title: S.current.customer_information,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPaddingHorizontalPage,
                                    vertical: 4,
                                  ),
                                  child: value == null
                                      ? Container(height: 100)
                                      : Center(
                                          child: CustomerInfoWidget(
                                            canAction: false,
                                            customer: value,
                                          ),
                                        ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _TitleSection(
                              defaultPaddingHorizontalPage:
                                  defaultPaddingHorizontalPage,
                              title: S.current.payment_info,
                            ),
                            ValueListenableBuilder(
                              valueListenable: dataBillNotifier,
                              builder: (context, value, child) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(
                                          AppConfig.sizeBorderRadiusMain)),
                                  child: Builder(builder: (context) {
                                    return PriceDataBillPreviewWidget(
                                      dataBill: value,
                                      showCashReceivedAmount: true,
                                      isCustomerPage: true,
                                    );
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _TitleSection(
                                defaultPaddingHorizontalPage:
                                    defaultPaddingHorizontalPage,
                                title: S.current.payment_method,
                              ),
                              Expanded(
                                child: _PaymentSection(
                                    paymentMethodNotifier:
                                        paymentMethodNotifier,
                                    defaultHorizontalPadding:
                                        defaultPaddingHorizontalPage,
                                    detailPaymentNotifier:
                                        detailPaymentNotifier,
                                    gatewayNotifier: gatewayNotifier),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url,
      WebviewPermissionKind kind,
      bool isUserInitiated,
      BuildContext context) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(S.current.webview_permission_request),
        content: Text('${S.current.webview_permission_request_1} \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: Text(S.current.deny),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: Text(S.current.allow),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }
}

class _PaymentSection extends StatelessWidget {
  const _PaymentSection({
    super.key,
    required this.paymentMethodNotifier,
    required this.defaultHorizontalPadding,
    required this.detailPaymentNotifier,
    required this.gatewayNotifier,
  });

  final ValueNotifier<PaymentMethod?> paymentMethodNotifier;
  final double defaultHorizontalPadding;
  final ValueNotifier<Map<String, dynamic>> detailPaymentNotifier;
  final ValueNotifier<bool> gatewayNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: paymentMethodNotifier,
      builder: (context, paymentMethod, child) {
        if (paymentMethod == null) {
          return const SizedBox.shrink();
        }
        return Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: defaultHorizontalPadding,
            vertical: 8,
          ),
          child: Column(
            children: [
              Text(
                paymentMethod.getNameView(),
                style: AppTextStyle.medium(),
              ),
              const Gap(4),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: detailPaymentNotifier,
                  builder: (context, detail, child) {
                    if (detail.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    if (paymentMethod.isBank) {
                      var bankSelect = detail['bank_select'] == null
                          ? null
                          : UserBankModel.fromJson(detail['bank_select']);
                      if ((bankSelect?.qrCode ?? '').isNotEmpty) {
                        return FittedBox(
                          child: Column(
                            children: [
                              Text(
                                bankSelect?.bankNumber ?? '',
                                style: AppTextStyle.bold(),
                              ),
                              Text(
                                bankSelect?.bankName ?? '',
                                style: AppTextStyle.bold(),
                              ),
                              ImageQRWidget(imgUrl: bankSelect?.qrCode ?? ''),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    } else if (paymentMethod.isGateway) {
                      if ((detail['gateway_qr'] ?? '').trim().isNotEmpty) {
                        return FutureBuilder<Uint8List?>(
                          future: loadImageBypassingSSL(
                              (detail['gateway_qr'] ?? '')),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CircularProgressIndicator(),
                                  const Gap(4),
                                  Text(
                                    S.current.loading_qr_code,
                                    style: AppTextStyle.regular(
                                      // fontSize: 12.sp,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ));
                            } else if (snapshot.hasError ||
                                snapshot.data == null) {
                              return Center(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.error,
                                    color: AppColors.redColor,
                                  ),
                                  const Gap(4),
                                  Text(
                                    S.current.error_loading_qr_code,
                                    style: AppTextStyle.regular(
                                      // fontSize: 12.sp,
                                      fontSize: 12,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                ],
                              ));
                            } else {
                              return ValueListenableBuilder(
                                valueListenable: gatewayNotifier,
                                builder: (context, value, child) {
                                  return FittedBox(
                                    child: Column(
                                      children: [
                                        if (gatewayNotifier.value)
                                          CountDownPayooTimer(
                                            initDuration: Duration(
                                                seconds:
                                                    detail['expiry_min'] ?? 0),
                                            onDone: () {
                                              var value =
                                                  Map<String, dynamic>.from(
                                                      detail);
                                              value['expiry_min'] = 0;

                                              detailPaymentNotifier.value =
                                                  value;
                                              gatewayNotifier.value = false;
                                            },
                                          ),
                                        const Gap(4),
                                        SizedBox(
                                          child: Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<Uint8List?> loadImageBypassingSSL(String url) async {
  final client = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  try {
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();

    if (response.statusCode == 200) {
      return await consolidateHttpClientResponseBytes(response);
    } else {
      print("Failed to load image. Status: ${response.statusCode}");
    }
  } catch (e) {
    print("Image load error: $e");
  } finally {
    client.close();
  }

  return null;
}

class CustomerInfoWidget extends ConsumerWidget {
  final CustomerModel customer;
  final bool canAction;

  final bool showRank;
  const CustomerInfoWidget({
    Key? key,
    required this.customer,
    this.canAction = true,
    this.showRank = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
                borderRadius: AppConfig.borderRadiusMain),
            child: ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              leading: _AvatarCustomerWidget(
                gender: customer.gender,
              ),
              title: Text(
                customer.name,
                style: AppTextStyle.bold(color: AppColors.mainColor),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const ResponsiveIconWidget(
                          iconData: CupertinoIcons.sunrise),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                            customer.dob == null || customer.dob!.trim().isEmpty
                                ? S.current.noBOD
                                : appConfig.dateFormatDDMMYYYY
                                    .format(DateTime.parse(customer.dob!))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const ResponsiveIconWidget(
                          iconData: CupertinoIcons.phone),
                      const SizedBox(width: 8),
                      Text(customer.phoneNumber),
                    ],
                  ),
                  if (showRank) ...[
                    const SizedBox(height: 4),
                    FittedBox(
                      child: Row(
                        children: [
                          const ResponsiveIconWidget(
                              iconData: CupertinoIcons.star),
                          const SizedBox(width: 8),
                          Text(
                            "${S.current.rank}: ${customer.level ?? S.current.notAvailableYet} "
                            "${customer.levelApprove == null ? '' : "(${appConfig.dateFormatDDMMYYYYHhMmSs.format(customer.levelApprove!)})"}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              trailing: canAction
                  ? IconButton(
                      onPressed: () {
                        showConfirmAction(
                          context,
                          action: () async {
                            final result = await ref
                                .read(homeProvider.notifier)
                                .resetCustomer();
                            if (result != null) {
                              await showErrorDialog(
                                context,
                                message: result.toString(),
                                isNotifier: true,
                              );
                              // showMessageDialog(
                              //   context,
                              //   message: result.toString(),
                              // );
                            } else {
                              ref
                                  .read(homeProvider.notifier)
                                  .syncInfoForCustomer();
                              // xoá khách xong thì áp dụng lại giảm giá
                              await ref
                                  .read(homeProvider.notifier)
                                  .applyCustomerPolicy();
                            }
                          },
                          message: S.current.removeCustomer,
                        );
                      },
                      color: AppColors.redColor,
                      icon: const Icon(CupertinoIcons.clear),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarCustomerWidget extends StatelessWidget {
  final String? gender;
  const _AvatarCustomerWidget({
    Key? key,
    this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var genderCheck = gender?.toLowerCase();
    String assetsIcon = Assets.iconsGenderUnknow;
    if (genderCheck == appConfig.gender[0]) {
      assetsIcon = Assets.iconsMan;
    } else if (genderCheck == appConfig.gender[1]) {
      assetsIcon = Assets.iconsWoman;
    } else {
      assetsIcon = Assets.iconsGenderUnknow;
    }
    return Image.asset(
      assetsIcon,
      width: 24,
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({
    super.key,
    required this.defaultPaddingHorizontalPage,
    required this.title,
    this.height = 50,
  });

  final double defaultPaddingHorizontalPage;
  final String title;

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: defaultPaddingHorizontalPage,
        vertical: 4,
      ),
      alignment: Alignment.centerLeft,
      width: double.maxFinite,
      color: Color(0xff292929),
      child: Text(title, style: AppTextStyle.bold(color: AppColors.white)),
    );
  }
}

class CountDownPayooTimer extends StatefulWidget {
  const CountDownPayooTimer({
    super.key,
    this.initDuration = const Duration(seconds: 1),
    this.onDone,
  });
  final Duration initDuration;
  final Function? onDone;

  @override
  State<CountDownPayooTimer> createState() => _CountDownPayooTimerState();
}

class _CountDownPayooTimerState extends State<CountDownPayooTimer> {
  late Timer _countDownTimer;

  late Duration duration;

  @override
  void initState() {
    super.initState();
    duration = widget.initDuration;
    _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        duration -= const Duration(seconds: 1);
      });
      if (duration.inSeconds == -5) {
        _countDownTimer.cancel();
        widget.onDone?.call();
      }
    });
  }

  @override
  void didUpdateWidget(covariant CountDownPayooTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.initDuration != oldWidget.initDuration) {
    //   _countDownTimer.cancel();

    //   setState(() {
    //     duration = widget.initDuration;
    //     _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //       setState(() {
    //         duration -= const Duration(seconds: 1);
    //       });
    //     });
    //   });
    // }
  }

  @override
  void dispose() {
    _countDownTimer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    if (duration.inSeconds < 1) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Text(
          S.current.remaining_time,
          style: AppTextStyle.regular(),
        ),
        const Gap(4),
        Text(
          formatDuration(duration),
          style: AppTextStyle.bold(color: AppColors.mainColor),
        ),
      ],
    );
  }
}
