import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/payment_status.dart';
import 'package:aladdin_franchise/src/data/enum/windows_method.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/detail_product.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_method_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/customer/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/barrel_component.dart';

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
  late ValueNotifier<PaymentStatusEnum?> paymentStatusNotifier;
  late ValueNotifier<ProductModel?> detailProductNotifier;

  BuildContext? rootContext;

  bool showPaymentStatus = false;

  bool showProductDetail = false;

  Timer? _paymentTimer;

  int paymentSuccessDuration = 15;

  @override
  void initState() {
    super.initState();
    paymentStatusNotifier = ValueNotifier<PaymentStatusEnum?>(null);
    detailProductNotifier = ValueNotifier<ProductModel?>(null);
    ValueNotifier<String>(LocalStorage.getCustomerLanguageLocal());
    if (Platform.isWindows) {
      DesktopMultiWindow.setMethodHandler(_handleMethodCallback);
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        ref.read(customerPageProvider.notifier).init(widget.args);
        setState(() {
          rootContext = context;
        });
      },
    );
  }

  void _startTimer() {
    _paymentTimer = Timer.periodic(
      Duration(seconds: paymentSuccessDuration),
      (timer) {
        _paymentTimer?.cancel();
        paymentStatusNotifier.value = PaymentStatusEnum.close;
      },
    );
  }

  void handlePaymentStatus({PaymentStatusEnum paymentStatus = PaymentStatusEnum.loading}) async {
    // if (rootContext != null && rootContext!.mounted) {
    switch (paymentStatus) {
      case PaymentStatusEnum.loading:
        if (!showPaymentStatus) {
          showPaymentStatus = true;
          showMessageDialog(
            context,
            message: S.current.completing_payment_verification,
            showAction: false,
          );
        }
        break;
      case PaymentStatusEnum.success:
        // đóng cửa sổ loading
        showLogs(showPaymentStatus, flags: 'isShowPaymentInfo 1');
        if (showPaymentStatus) {
          ref.read(customerPageProvider.notifier).resetState();
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
                          if (value == PaymentStatusEnum.close) {
                            Navigator.of(context).pop();
                            showPaymentStatus = false;
                          }
                          var restaurant = LocalStorage.getDataLogin()?.restaurant;
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
                        style: AppTextStyle.regular(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );

        break;
      case PaymentStatusEnum.fail:
        // faild
        break;
      case PaymentStatusEnum.cancel:
        // đóng cửa sổ loading

        showLogs(showPaymentStatus, flags: 'isShowPaymentInfo 1');
        if (!showPaymentStatus) {
          pop(context);
          showPaymentStatus = false;
        }
        paymentStatusNotifier.value = null;
        break;
      default:
    }
    // }
  }

  void _showDetailProduct() async {
    if (rootContext != null && rootContext!.mounted) {
      showProductDetail = true;
      await showDialog(
        context: rootContext!,
        barrierDismissible: false,
        builder: (context) {
          return ValueListenableBuilder(
              valueListenable: detailProductNotifier,
              builder: (context, value, child) {
                showLogs(value, flags: 'value');
                if (value == null) {
                  Navigator.of(context).pop();
                  showProductDetail = false;
                  return Container();
                }
                return PopScope(
                  canPop: false,
                  child: DetailProductDialog(product: value, notClose: true),
                );
              });
        },
      );
    } else {
      showProductDetail = false;
    }
  }

  Future<dynamic> _handleMethodCallback(MethodCall call, int fromWindowId) async {
    var data = jsonDecode(call.arguments);

    try {
      switch (WindowsMethodEnum.values.byName(call.method)) {
        case WindowsMethodEnum.closeApp:
          widget.windowController?.close();
          return;
        case WindowsMethodEnum.order:
          var value = data == null ? null : OrderModel.fromJson(data);
          var oldOrder = ref.read(customerPageProvider).order;
          if (oldOrder?.id != value?.id && showPaymentStatus) {
            pop(context);
          }
          ref.read(customerPageProvider.notifier).onChangeOrder(value);

          break;
        case WindowsMethodEnum.customer:
          var value = data == null ? null : CustomerModel.fromJson(data);
          ref.read(customerPageProvider.notifier).onChangeCustomer(value);
          break;
        case WindowsMethodEnum.price:
          var value = data == null ? null : PriceDataBill.fromJson(data);
          ref.read(customerPageProvider.notifier).onChangePrice(value);
          break;
        case WindowsMethodEnum.paymentMethod:
          var value = data == null ? null : PaymentMethod.fromJson(data);
          ref.read(customerPageProvider.notifier).onChangePaymentMethod(value);
          break;
        case WindowsMethodEnum.bank:
          var value = data == null ? null : UserBankModel.fromJson(data);
          ref.read(customerPageProvider.notifier).onChangeBankSelect(value);
          break;
        case WindowsMethodEnum.productCheckout:
          List<ProductModel> value = [];
          try {
            if (data != null && data is List) {
              value = data.map((e) => ProductModel.fromJson(e)).toList();
            }
          } catch (ex) {
            showLogs(ex, flags: 'productCheckout method call ex');
          }
          ref.read(customerPageProvider.notifier).onChangeProducts(value);
          break;

        case WindowsMethodEnum.payoo:
          int seconds = 0;
          String url = '';
          try {
            seconds = (data['expire_time'] ?? 0) as int;
          } catch (ex) {
            //
          }
          try {
            url = (data['url'] ?? '') as String;
          } catch (ex) {
            //
          }
          ref.read(customerPageProvider.notifier).onChangePayooExpirationSeconds(seconds);
          ref.read(customerPageProvider.notifier).onChangePayooGatewayUrl(url);
          break;
        case WindowsMethodEnum.changeOrderProduct:
          ref.read(customerPageProvider.notifier).onChangeScrollProduct(data);
        case WindowsMethodEnum.payment:
          var paymentStatus = PaymentStatusEnum.values.byName(data);

          if (paymentStatus == paymentStatusNotifier.value) {
            return;
          }
          paymentStatusNotifier.value = paymentStatus;

          handlePaymentStatus(paymentStatus: paymentStatus);
          break;
        case WindowsMethodEnum.detailProduct:
          ProductModel? product = data == null ? null : ProductModel.fromJson(data);
          showLogs(product, flags: 'detailProduct');
          detailProductNotifier.value = product;

          if (!showProductDetail && product != null) {
            _showDetailProduct();
          }
          break;
        default:
      }
    } catch (ex) {
      showLogs(ex, flags: 'data _handleMethodCallback ex');
    }
    return;
  }

  @override
  void dispose() {
    if (Platform.isWindows) {
      DesktopMultiWindow.setMethodHandler(null);
    }
    _paymentTimer?.cancel();
    paymentStatusNotifier.dispose();
    detailProductNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var order = ref.watch(customerPageProvider.select((value) => value.order));
    double paddingHorizontal = 12;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: order == null
          ? AppImageCacheNetworkWidget(
              imageUrl: "https://haisu.vn/Upload/Banner/310525104657.jpg",
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite,
              errorWidget: Image.asset(
                Assets.imagesLogoH,
                height: 100,
                fit: BoxFit.cover,
              ),
            )
          : Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        color: Color(0xff292929),
                        padding: EdgeInsets.symmetric(
                          horizontal: paddingHorizontal,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${S.current.table_served}: ${S.current.table} ${order.getNameView()}',
                                style: AppTextStyle.bold(color: AppColors.white),
                              ),
                            ),
                            FittedBox(
                              child: Chip(
                                label: Text(
                                  S.current.infoVAT,
                                  style: AppTextStyle.regular(
                                    rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: CustomerOrderedItemsList(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.white,
                    child: Column(
                      children: [
                        TitleSection(
                          paddingHorizontal: 12,
                          title: S.current.customer_information,
                        ),
                        Consumer(builder: (context, ref, child) {
                          var value =
                              ref.watch(customerPageProvider.select((value) => value.customer));
                          if (value == null) return Container(height: 100);
                          return Center(
                            child: CustomerInfoWidget(
                              canAction: false,
                              customer: value,
                            ),
                          );
                        }),
                        TitleSection(
                          paddingHorizontal: 12,
                          title: S.current.payment_info,
                        ),
                        Consumer(builder: (context, ref, child) {
                          var price =
                              ref.watch(customerPageProvider.select((value) => value.price));
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.circular(AppConfig.sizeBorderRadiusMain)),
                            child: PriceDataBillPreviewWidget(
                              dataBill: price ?? const PriceDataBill(),
                              showCashReceivedAmount: true,
                              isCustomerPage: true,
                            ),
                          );
                        }),
                        TitleSection(
                          paddingHorizontal: paddingHorizontal,
                          title: S.current.payment_method,
                        ),
                        Expanded(child: Consumer(
                          builder: (context, ref, child) {
                            var paymentMethod = ref
                                .watch(customerPageProvider.select((value) => value.paymentMethod));
                            var bankSelect =
                                ref.watch(customerPageProvider.select((value) => value.bankSelect));
                            if (paymentMethod == null) {
                              return const SizedBox.shrink();
                            }
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    paymentMethod.getNameView(),
                                    style: AppTextStyle.medium(),
                                  ),
                                  const Gap(4),
                                  if (paymentMethod.isBank &&
                                      (bankSelect?.qrCode ?? '').isNotEmpty) ...[
                                    FittedBox(
                                      child: Column(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: bankSelect?.title ?? '',
                                                ),
                                                const TextSpan(
                                                  text: ' - ',
                                                ),
                                                TextSpan(
                                                  text: bankSelect?.bankName ?? '',
                                                ),
                                              ],
                                              style: AppTextStyle.bold(),
                                            ),
                                          ),
                                          Text(
                                            bankSelect?.bankNumber ?? '',
                                            style: AppTextStyle.bold(),
                                          ),
                                          ImageQRWidget(imgUrl: bankSelect?.qrCode ?? ''),
                                        ],
                                      ),
                                    ),
                                  ],
                                  if (paymentMethod.isGateway) ...[
                                    Consumer(
                                      builder: (context, ref, child) {
                                        var payooGatewayUrl = ref.watch(customerPageProvider
                                            .select((value) => value.payooGatewayUrl));
                                        if (payooGatewayUrl.trim().isEmpty) {
                                          return const SizedBox.shrink();
                                        }
                                        return FutureBuilder<Uint8List?>(
                                          future: loadImageBypassingSSL(payooGatewayUrl),
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
                                                      rawFontSize:
                                                          AppConfig.defaultRawTextSize - 1.5,
                                                    ),
                                                  ),
                                                ],
                                              ));
                                            } else if (snapshot.hasError || snapshot.data == null) {
                                              return Center(
                                                  child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const ResponsiveIconWidget(
                                                    iconData: Icons.error,
                                                    color: AppColors.redColor,
                                                  ),
                                                  const Gap(4),
                                                  Text(
                                                    S.current.error_loading_qr_code,
                                                    style: AppTextStyle.regular(
                                                      rawFontSize:
                                                          AppConfig.defaultRawTextSize - 1.5,
                                                      color: AppColors.redColor,
                                                    ),
                                                  ),
                                                ],
                                              ));
                                            } else {
                                              return FittedBox(
                                                child: Column(
                                                  children: [
                                                    Consumer(
                                                      builder: (context, ref, child) {
                                                        var seconds = ref.watch(
                                                            customerPageProvider.select((value) =>
                                                                value.payooExpirationSeconds));
                                                        return seconds < 1
                                                            ? const SizedBox.shrink()
                                                            : CountDownPayooTimer(
                                                                initDuration:
                                                                    Duration(seconds: seconds),
                                                                onDone: () {
                                                                  ref
                                                                      .read(customerPageProvider
                                                                          .notifier)
                                                                      .onChangePayooExpirationSeconds(
                                                                          0);
                                                                },
                                                              );
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
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ],
                              ),
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Future<Uint8List?> loadImageBypassingSSL(String url) async {
  final client = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

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
            shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
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
                      const ResponsiveIconWidget(iconData: CupertinoIcons.sunrise),
                      const Gap(4),
                      Expanded(
                        child: Text(customer.dob == null || customer.dob!.trim().isEmpty
                            ? S.current.noBOD
                            : appConfig.dateFormatDDMMYYYY.format(DateTime.parse(customer.dob!))),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      const ResponsiveIconWidget(iconData: CupertinoIcons.phone),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(customer.phoneNumber),
                      ),
                    ],
                  ),
                  if (showRank) ...[
                    const SizedBox(height: 4),
                    FittedBox(
                      child: Row(
                        children: [
                          const ResponsiveIconWidget(iconData: CupertinoIcons.star),
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
                            final result = await ref.read(homeProvider.notifier).resetCustomer();
                            if (result != null) {
                              showMessageDialog(
                                context,
                                message: result.toString(),
                              );
                            } else {
                              // ref
                              //     .read(homeProvider.notifier)
                              //     .syncInfoCustomerPage(method: WindowsMethodEnum.customer);
                              // xoá khách xong thì áp dụng lại giảm giá (hiện bên NQ bỏ api nên thấy thông tin vẫn còn nguyên)
                              await ref.read(homeProvider.notifier).applyCustomerPolicy();
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
