import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';

import 'package:aladdin_franchise/src/features/dialogs/image_bill_checker.dart';
import 'package:aladdin_franchise/src/features/dialogs/note_for_waiter.dart';
import 'package:aladdin_franchise/src/features/dialogs/number_of_people.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_tab_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/payment/preview_receipt.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_dropdown_button.dart';

import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/tab_custom_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContentConfirmPaymentWidget extends ConsumerStatefulWidget {
  const ContentConfirmPaymentWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContentConfirmPaymentWidgetState();
}

class _ContentConfirmPaymentWidgetState
    extends ConsumerState<ContentConfirmPaymentWidget> {
  final List<String> tabs = ['Hóa đơn', 'Thanh toán'];
  String tabSelect = 'Hóa đơn';

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool isTablet = AppDeviceSizeUtil.checkTabletDevice();
    bool portraitOrientation =
        AppDeviceSizeUtil.checkPortraitOrientation(context);

    bool useTab = (isMobile || (isTablet && portraitOrientation));
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (useTab)
            Row(
              children: tabs
                  .map(
                    (e) => Expanded(
                        child: AppTabBarWidget(
                      title: e,
                      onTap: () {
                        setState(() {
                          tabSelect = e;
                        });
                      },
                      selected: tabSelect == e,
                    )),
                  )
                  .toList(),
            ),
          const Gap(8),
          Expanded(
              child: IndexedStack(
            index: useTab ? max(0, tabs.indexOf(tabSelect)) : 0,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        child: PreviewPaymentReceiptWidget(
                      showTitle: !useTab,
                    )),
                  ),
                  if (!useTab) ...[
                    const VerticalDivider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 400,
                      child: _MorePaymentInfoWidget(),
                    ),
                  ],
                ],
              ),
              const _MorePaymentInfoWidget(),
              // SingleChildScrollView(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         S.current.confirm_payment_tmp,
              //         style: AppTextStyle.regular(),
              //       ),
              //       const PQCImageBillCheckerWidget(),
              //       const GapH(12),
              //       Consumer(
              //         builder: (context, ref, child) {
              //           var checked = ref.watch(homeProvider
              //               .select((value) => value.printNumberOfPeople));
              //           return GestureDetector(
              //             onTap: ref
              //                 .read(homeProvider.notifier)
              //                 .onChangePrintNumberOfPeople,
              //             child: Row(
              //               children: [
              //                 CustomCheckbox(
              //                   onChange: ref
              //                       .read(homeProvider.notifier)
              //                       .onChangePrintNumberOfPeople,
              //                   checked: checked,
              //                 ),
              //                 const Gap(4),
              //                 Flexible(
              //                     child:
              //                         Text(S.current.print_number_of_people)),
              //               ],
              //             ),
              //           );
              //         },
              //       ),
              //       const CheckoutNumberOfPeopleWidget(),
              //       const GapH(12),
              //       const CustomerPortraitSelectWidget(),
              //       const GapH(12),
              //       const EmployeeSaleSelectWidget(),
              //       const GapH(12),
              //       const CheckoutNoteForWaiterWidget(),
              //     ],
              //   ),
              // ),
            ],
          )),
        ],
      ),
    );
  }
}

class _MorePaymentInfoWidget extends StatelessWidget {
  const _MorePaymentInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.confirm_payment_tmp,
            style: AppTextStyle.regular(),
          ),
          const PQCImageBillCheckerWidget(),
          const GapH(12),
          Consumer(
            builder: (context, ref, child) {
              var checked = ref.watch(
                  homeProvider.select((value) => value.printNumberOfPeople));
              return GestureDetector(
                onTap:
                    ref.read(homeProvider.notifier).onChangePrintNumberOfPeople,
                child: Row(
                  children: [
                    CustomCheckbox(
                      onChange: ref
                          .read(homeProvider.notifier)
                          .onChangePrintNumberOfPeople,
                      checked: checked,
                    ),
                    const Gap(4),
                    Flexible(
                      child: Text(
                        S.current.print_number_of_people,
                        style: AppTextStyle.regular(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const CheckoutNumberOfPeopleWidget(),
          const GapH(12),
          const CustomerPortraitSelectWidget(),
          // const GapH(12),
          // const EmployeeSaleSelectWidget(),
          const GapH(12),
          const CheckoutNoteForWaiterWidget(),
        ],
      ),
    );
  }
}

// class ContentConfirmPaymentWidget extends StatelessWidget {
//   const ContentConfirmPaymentWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.maxFinite,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           const Expanded(
//             child: PreviewPaymentReceiptWidget(),
//           ),
//           const VerticalDivider(
//             thickness: 2,
//             color: Colors.grey,
//           ),
//           SizedBox(
//             width: 400,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(S.current.confirm_payment_tmp),
//                   const PQCImageBillCheckerWidget(),
//                   const GapH(12),
//                   Consumer(
//                     builder: (context, ref, child) {
//                       var checked = ref.watch(homeProvider
//                           .select((value) => value.printNumberOfPeople));
//                       return GestureDetector(
//                         onTap: ref
//                             .read(homeProvider.notifier)
//                             .onChangePrintNumberOfPeople,
//                         child: Row(
//                           children: [
//                             CustomCheckbox(
//                               onChange: ref
//                                   .read(homeProvider.notifier)
//                                   .onChangePrintNumberOfPeople,
//                               checked: checked,
//                             ),
//                             const Gap(4),
//                             Flexible(
//                                 child: Text(S.current.print_number_of_people)),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   const CheckoutNumberOfPeopleWidget(),
//                   const GapH(12),
//                   const CustomerPortraitSelectWidget(),
//                   const GapH(12),
//                   const EmployeeSaleSelectWidget(),
//                   const GapH(12),
//                   const CheckoutNoteForWaiterWidget(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CheckoutNumberOfPeopleWidget extends ConsumerWidget {
  const CheckoutNumberOfPeopleWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeNotifier = ref.read(homeProvider.notifier);
    final coupons = ref.watch(homeProvider.select((value) => value.coupons));

    var requireApplyPolicy = coupons.any((e) => e.isType == 6);
    bool allowChangeNumberOfAdults = !requireApplyPolicy;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLineWidget(title: S.current.number_of_people),
        const Gap(8),
        SpinBox(
          min: 1,
          max: 200,
          enabled: allowChangeNumberOfAdults,
          incrementIcon: const Icon(CupertinoIcons.add),
          decrementIcon: const Icon(CupertinoIcons.minus),
          textStyle: AppTextStyle.bold(),
          value: ref
              .watch(homeProvider.select((value) => value.numberOfAdults))
              .toDouble(),
          decoration: InputDecoration(
            label: Text(
              S.current.number_of_adults,
              style: AppTextStyle.regular(),
            ),
          ),
          onChanged: (value) {
            homeNotifier.changeNumberOfPeople(
              numberOfAdults: value.toInt(),
              // applyPolicy: requireApplyPolicy
            );
          },
        ),
        if (requireApplyPolicy) ...[
          const Gap(8),
          Text(
            'Mã giảm giá theo số khách, thay đổi sổ khách người lớn trong mục Ưu đãi.',
            style:
                AppTextStyle.regular(color: AppColors.redColor, fontSize: 12),
          )
        ],
        const GapH(24),
        SpinBox(
          min: 0,
          max: 200,
          incrementIcon: const Icon(CupertinoIcons.add),
          decrementIcon: const Icon(CupertinoIcons.minus),
          textStyle: AppTextStyle.bold(),
          value: ref
              .watch(homeProvider.select((value) => value.numberOfChildren))
              .toDouble(),
          decoration: InputDecoration(
            label: Text(
              S.current.number_of_children,
              style: AppTextStyle.regular(),
            ),
          ),
          onChanged: (value) {
            homeNotifier.changeNumberOfPeople(
              numberOfChildren: value.toInt(),
            );
          },
        ),
      ],
    );
  }
}

class CustomerPortraitSelectWidget extends ConsumerWidget {
  const CustomerPortraitSelectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portraitSelect =
        ref.watch(homeProvider.select((value) => value.customerPortraitSelect));
    final portraits = ref.read(homeProvider.notifier).getCustomerPortrait();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text.rich(
            style: AppTextStyle.bold(),
            TextSpan(
              text: S.current.customer_portrait,
              children: [
                TextSpan(
                  text: " *",
                  style: AppTextStyle.bold(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        portraits.isEmpty
            ? Text(S.current.customer_portrait_not_setup)
            : DropdownButtonFormField<CustomerPortrait?>(
                value: portraitSelect,
                hint: Text(S.current.customer_portrait_select_portrait_group),
                style: AppTextStyle.regular(color: Colors.black),
                items: portraits
                    .map(
                      (e) => DropdownMenuItem<CustomerPortrait>(
                        value: e,
                        child: Text(e.display()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  ref
                      .read(homeProvider.notifier)
                      .onChangeCustomerPortraitSelect(value!);
                },
              ),
      ],
    );
  }
}

class EmployeeSaleSelectWidget extends ConsumerWidget {
  const EmployeeSaleSelectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text.rich(
            style: AppTextStyle.bold(),
            TextSpan(
              text: S.current.sale_staff,
              children: [
                TextSpan(
                  text: " *",
                  style: AppTextStyle.bold(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        Consumer(builder: (context, ref, child) {
          var saleState = ref.watch(employeeSalesProvider);
          final empSelect = ref
              .watch(homeProvider.select((value) => value.employeeSaleSelect));
          // final state = ref
          //     .watch(homeProvider.select((value) => value.employeeSaleState));
          // final data =
          //     ref.watch(homeProvider.select((value) => value.employeeSales));
          return saleState.when(
            data: (data) {
              var dataView = data
                  .where((e) => [
                        0,
                        kTypeOrder == AppConfig.orderOfflineValue ? 1 : 2
                      ].contains(e.isOnline))
                  .toList();
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  if (empSelect != null && !dataView.contains(empSelect)) {
                    ref
                        .read(homeProvider.notifier)
                        .onChangeEmployeeSaleSelect(null);
                  }
                },
              );
              if (dataView.isEmpty) {
                return Text(
                  S.current.no_sale_staff_set_up,
                  style: AppTextStyle.regular(),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdownButton<EmployeeSaleModel>(
                    data: dataView,
                    allowSearch: true,
                    buildTextDisplay: (data) {
                      return data.fullName;
                    },
                    initData: empSelect == null ? [] : [empSelect],
                    onChangeData: (p0) {
                      ref
                          .read(homeProvider.notifier)
                          .onChangeEmployeeSaleSelect(p0.firstOrNull);
                    },
                    hintText: S.current.select_sales_staff,
                    searchMatchFn: (p0, p1) {
                      return removeDiacritics(
                              (p0.value?.fullName ?? '').trim().toLowerCase())
                          .contains(removeDiacritics(p1.trim().toLowerCase()));
                    },
                  ),
                ],
              );
            },
            error: (error, stackTrace) => AppErrorSimpleWidget(
              onTryAgain: () {
                ref.refresh(employeeSalesProvider);
              },
              textButton: S.current.reload,
              message: error.toString(),
            ),
            loading: () => const AppLoadingLineWidget(),
          );
          // var dataView = data
          //     .where((e) => [
          //           0,
          //           kTypeOrder == AppConfig.orderOfflineValue ? 1 : 2
          //         ].contains(e.isOnline))
          //     .toList();
          // final empSelect = ref
          //     .watch(homeProvider.select((value) => value.employeeSaleSelect));
          // switch (state.status) {
          //   case PageCommonState.loading:
          //     return const AppLoadingLineWidget();
          //   case PageCommonState.error:
          //     return AppErrorSimpleWidget(
          //       onTryAgain: ref.read(homeProvider.notifier).getEmployeeSales,
          //       textButton: S.current.reload,
          //       message: state.messageError,
          //     );
          //   default:
          // }
          // if (dataView.isEmpty) {
          //   return Text(S.current.no_sale_staff_set_up);
          // }

          // return Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     CustomDropdownButton<EmployeeSaleModel>(
          //       data: dataView,
          //       allowSearch: true,
          //       buildTextDisplay: (data) {
          //         return data.fullName;
          //       },
          //       initData: empSelect == null ? [] : [empSelect],
          //       onChangeData: (p0) {
          //         ref
          //             .read(homeProvider.notifier)
          //             .onChangeEmployeeSaleSelect(p0.firstOrNull);
          //       },
          //       hintText: S.current.select_sales_staff,
          //       searchMatchFn: (p0, p1) {
          //         return removeDiacritics(
          //                 (p0.value?.fullName ?? '').trim().toLowerCase())
          //             .contains(removeDiacritics(p1.trim().toLowerCase()));
          //       },
          //     ),
          //   ],
          // );
        })
      ],
    );
  }
}
