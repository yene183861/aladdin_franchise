import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/view_list_discount.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../generated/l10n.dart';

class CouponInfoWidget extends ConsumerWidget {
  final bool canAction;
  const CouponInfoWidget({
    Key? key,
    this.canAction = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allProduct = ref.watch(homeProvider.select((value) => value.products));
    var coupons = ref.watch(homeProvider.select((value) => value.coupons));
    var productCheckouts = ref.watch(homeProvider.select((value) => value.productCheckout));
    final numberOfAdults = ref.watch(homeProvider.select((value) => value.numberOfAdults));
    if (coupons.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          S.current.notDiscountApply,
          style: AppTextStyle.regular(),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        CustomerPolicyModel coupon = coupons[index];

        showLogs('name: ${coupon.name}, isType: ${coupon.isType}', flags: '==== View Mã giảm giá');

        List<DiscountPolicy> discountView = [];
        List<ProductModel> productForXPeople = [];
        // Đối với các mã giảm giá tổng bill thì add luôn không phải check
        bool notTotalBill = coupon.discount.any((element) => element.name != null);
        if (coupon.isTotalBill()) {
          discountView = coupon.discount;
        } else {
          /// mã giảm theo số lượng khách người lớn
          if (coupon.isType == 6) {
            for (final discount in coupon.discount) {
              for (final pCheckout in productCheckouts) {
                final product =
                    allProduct.firstWhereOrNull((element) => element.id == pCheckout.id);
                if (product == null) continue;
                ProductModel? productDiscount;
                if (pCheckout.id.toString() == discount.id) {
                  productDiscount = product.copyWith(
                    quantityDiscount: pCheckout.quantity,
                    unitPriceDiscount: discount.amount,
                  );
                } else if (coupon.applyComboItem) {
                  List<ComboItemModel> comboItems =
                      ProductHelper().getComboDescription(product) ?? [];
                  for (final cbi in comboItems) {
                    if (cbi.id.toString() == discount.id) {
                      final cbiQuantity = cbi.quantity * pCheckout.quantity;
                      productDiscount =
                          allProduct.firstWhereOrNull((element) => element.id == cbi.id)?.copyWith(
                                withComboDiscount: cbiQuantity,
                                quantityDiscount: cbiQuantity,
                                unitPriceDiscount: discount.amount,
                              );
                    }
                  }
                }
                if (productDiscount != null &&
                    productDiscount.getUnitPriceNum() >= discount.amount) {
                  // kiểm tra tồn tại chưa
                  final xProductPeople = productForXPeople
                      .firstWhereOrNull((element) => element.id == productDiscount?.id);
                  if (xProductPeople != null) {
                    final indexPXPeople = productForXPeople.indexOf(xProductPeople);
                    productForXPeople[indexPXPeople] = xProductPeople.copyWith(
                      quantityDiscount:
                          xProductPeople.quantityDiscount + productDiscount.quantityDiscount,
                      withComboDiscount:
                          xProductPeople.withComboDiscount + productDiscount.withComboDiscount,
                    );
                  } else {
                    productForXPeople.add(productDiscount);
                  }
                }
              }
            }
          } else {
            bool flagCheckAddDiscountView = false;
            // duyệt danh sách được giảm giá trong danh sách món đã gọi để kiểm tra
            for (var discount in coupon.discount) {
              for (var e in productCheckouts) {
                var product = allProduct.firstWhereOrNull((element) => element.id == e.id);
                if (product == null) {
                  continue; // Không muốn check cái này đâu nhưng mà =))
                }
                // product normal
                // nếu là món ăn thông thường, kiểm tra xem có nằm trong danh sách được giảm giá hay không
                if (product.id.toString() == discount.id) {
                  discountView.add(discount);
                  flagCheckAddDiscountView = true;
                  break;
                } else if (coupon.applyComboItem) {
                  // check combo
                  // nếu món là combo, cần lấy danh sách món trong combo trong description để check tiếp
                  List<ComboItemModel>? comboItems = ProductHelper().getComboDescription(product);
                  if (comboItems != null) {
                    // kiểm tra danh sách món trong combo với món discount
                    if (comboItems.any((cbi) => cbi.id.toString() == discount.id)) {
                      discountView.add(discount);
                      flagCheckAddDiscountView = true;
                      break;
                    }
                  }
                }
              }
              // lấy duy nhất 1 món nếu only=true
              if (flagCheckAddDiscountView && (coupon.only ?? false)) {
                break;
              }
            }
          }
        }
        // } else {
        //   discountView = coupon.discount;
        // }

        int totalNumberSelected = 0;
        if (coupon.isPromotion()) {
          totalNumberSelected = coupon.discount.map((e) => e.numberSelect).sum;
        }
        if (coupon.isType == 6 && productForXPeople.isNotEmpty) {
          // sắp xếp theo giá giảm dần (cao tới thấp)
          productForXPeople.sort((a, b) => b.getUnitPriceNum().compareTo(a.getUnitPriceNum()));
          // Kiểm tra nếu danh sách mã có mã only, cần giảm sl món trong món đồng giá
          for (final couponCheck in coupons) {
            if (couponCheck.only && couponCheck.discount.isNotEmpty) {
              final discountOnly = couponCheck.discount.first;
              for (int i = 0; i < productForXPeople.length; i++) {
                final pfp = productForXPeople[i];
                if (pfp.id.toString() == discountOnly.id) {
                  if (pfp.quantityDiscount > 0) {
                    productForXPeople[i] = pfp.copyWith(
                      quantityDiscount: pfp.quantityDiscount - 1,
                      withComboDiscount: pfp.withComboDiscount > 0 ? pfp.withComboDiscount - 1 : 0,
                    );
                  }
                }
              }
            }
          }
          // lấy số món đồng giá theo max
          productForXPeople = _optimizeProductCheckoutListByMax(
            productForXPeople,
            numberOfAdults ~/ coupon.getDiscountItemsPerCustomer,
          );
        }
        return Column(
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${coupon.name} ", style: AppTextStyle.bold()),
                  if (coupon.paymentNotAllowed.isNotEmpty)
                    Text(
                      '- ${S.current.code_limit_payment_method}',
                      style: AppTextStyle.regular(
                        rawFontSize: 13,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  if (coupon.isType == 6)
                    Text(
                      '- ${S.current.apply_policy_after_change_adults}',
                      style: AppTextStyle.medium(
                        rawFontSize: 13,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  const GapH(8),
                  InkWell(
                    onTap: () {
                      showCouponDetailDialog(context, coupon);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            CupertinoIcons.doc_text_search,
                            size: 20,
                          ),
                          const GapW(6),
                          Text(
                            S.current.conditions_and_products_apply,
                            style: AppTextStyle.bold(
                              rawFontSize: 13,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: (discountView.isEmpty && productForXPeople.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        S.current.messageAddCouponNoProducts,
                        style: AppTextStyle.regular(),
                      ),
                    )
                  : coupon.isType == 5 // Chọn món được khuyến mại
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "${S.current.select_up_to} ${coupon.maxNumberSelected} ${S.current.product.toLowerCase()}. ${S.current.selected} $totalNumberSelected/${coupon.maxNumberSelected}",
                            style: AppTextStyle.regular(
                              rawFontSize: 13,
                            ),
                          ),
                        )
                      : null,
              trailing: canAction
                  ? IconButton(
                      onPressed: () {
                        showConfirmAction(
                          context,
                          message: S.current.deleteDiscountCode,
                          action: () async {
                            var resultRemove = await ref
                                .read(homeProvider.notifier)
                                .removeCoupon(coupon, applyPolicy: true);
                            if (resultRemove != null) {
                              showErrorDialog(
                                context,
                                message: resultRemove,
                                isNotifier: true,
                              );
                              // showMessageDialog(context,
                              //     message: resultRemove);
                            }
                          },
                        );
                        // onRemoveCoupon.call(coupon);
                      },
                      icon: const ResponsiveIconWidget(
                        iconData: CupertinoIcons.delete,
                        color: AppColors.redColor,
                      ))
                  : null,
            ),
            (discountView.isEmpty && productForXPeople.isEmpty)
                ? const SizedBox()
                : coupon.isType == 5 // Chọn món được khuyến mại
                    ? Column(
                        children: discountView.map(
                          (discount) {
                            final productCheckout = productCheckouts
                                .firstWhereOrNull((p) => p.id.toString() == discount.id);
                            // mã này đang không áp dụng trong combo
                            if (productCheckout == null) {
                              return const SizedBox.shrink();
                            }
                            final isSelected = discount.numberSelect >= 1;

                            int maxDiscountSelect = discount.maxNumber;
                            if (productCheckout.quantity <= maxDiscountSelect) {
                              maxDiscountSelect = productCheckout.quantity;
                            }
                            int totalSelectByDish = 0;
                            for (final cc in coupons) {
                              if (cc.isType == 5) {
                                for (final ccd in cc.discount) {
                                  if (productCheckout.id.toString() == ccd.id &&
                                      coupon.id != cc.id) {
                                    totalSelectByDish += ccd.numberSelect;
                                  }
                                }
                              }
                            }

                            final enabled = isSelected ||
                                (totalSelectByDish <
                                        productCheckout.getQuantityFinal() +
                                            discount.numberSelect &&
                                    totalNumberSelected < coupon.maxNumberSelected);

                            return Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    value: isSelected,
                                    dense: true,
                                    enabled: enabled,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    title: Text(
                                      "${discount.name}",
                                      style: AppTextStyle.regular(),
                                    ),
                                    subtitle: Text(
                                      discount.namePromotion,
                                      style: AppTextStyle.regular(),
                                    ),
                                    onChanged: (value) {
                                      ref.read(homeProvider.notifier).changeSelectDiscountPromotion(
                                            coupon,
                                            discount,
                                            value == true ? 1 : 0,
                                          );
                                    },
                                  ),
                                ),
                                isSelected
                                    ? SizedBox(
                                        width: 120,
                                        height: 36,
                                        child: SpinBox(
                                          min: 0,
                                          max: maxDiscountSelect.toDouble(),
                                          enabled: totalNumberSelected < coupon.maxNumberSelected,
                                          showButtons: maxDiscountSelect > 1,
                                          incrementIcon: const Icon(
                                            CupertinoIcons.add,
                                            size: 22,
                                          ),
                                          decrementIcon: const Icon(
                                            CupertinoIcons.minus,
                                            size: 22,
                                          ),
                                          textStyle: AppTextStyle.bold(),
                                          value: discount.numberSelect.toDouble(),
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          onChanged: (value) {
                                            ref
                                                .read(homeProvider.notifier)
                                                .changeSelectDiscountPromotion(
                                                  coupon,
                                                  discount,
                                                  value.toInt(),
                                                );
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            );
                          },
                        ).toList(),
                      )
                    : coupon.isType == 6
                        ? Column(
                            children: productForXPeople.map((e) {
                              final amountView =
                                  "${AppConfig.formatCurrency().format((e.getUnitPriceNum() - e.unitPriceDiscount))} x ${e.quantityDiscount}";
                              return Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: ListTile(
                                  dense: true,
                                  title: Text(
                                    e.name,
                                    style: AppTextStyle.regular(),
                                  ),
                                  trailing: Text(
                                    "-$amountView",
                                    style: AppTextStyle.regular(),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : Column(
                            children: discountView.map((e) {
                              String amountView = "???";
                              if (e.type == 1) {
                                // giảm %
                                amountView = "${e.amount}%";
                              } else {
                                // giảm tiền
                                switch (coupon.isType) {
                                  // giảm luỹ kế
                                  case 3:
                                    // showLogs(null, flags: '====Giảm lũy kế');
                                    int xQuantity = 0;
                                    for (final pCheckout in productCheckouts) {
                                      final product = allProduct.firstWhereOrNull(
                                          (element) => element.id == pCheckout.id);

                                      if (product == null) continue;
                                      if (product.id.toString() == e.id) {
                                        xQuantity += pCheckout.getQuantityFinal();
                                      } else if (coupon.applyComboItem) {
                                        List<ComboItemModel>? comboItems =
                                            ProductHelper().getComboDescription(product);
                                        if (comboItems != null) {
                                          // kiểm tra danh sách món trong combo với món discount
                                          for (final cbi in comboItems) {
                                            if (cbi.id.toString() == e.id) {
                                              xQuantity += cbi.quantity;
                                            }
                                          }
                                        }
                                      }
                                    }
                                    amountView = xQuantity > 0
                                        ? "${AppConfig.formatCurrency().format(e.amount)} x $xQuantity"
                                        : "";
                                    break;
                                  default:
                                    "${amountView = AppConfig.formatCurrency().format(e.amount)} x 1";
                                    break;
                                }
                              }
                              if (amountView.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              return Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: ListTile(
                                  dense: true,
                                  title: Text(
                                    e.name ?? S.current.billTotal,
                                    style: AppTextStyle.regular(),
                                  ),
                                  trailing: Text(
                                    "-$amountView",
                                    style: AppTextStyle.regular(),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 0),
      itemCount: coupons.length,
    );
  }

  List<ProductModel> _optimizeProductCheckoutListByMax(
    List<ProductModel> products,
    int max,
  ) {
    List<ProductModel> result = [];
    int total = 0;

    // Duyệt món thường
    for (var p in products) {
      if (total >= max) break;

      int normalQty = p.quantityDiscount - p.withComboDiscount;
      int remaining = max - total;
      int take = normalQty <= remaining ? normalQty : remaining;

      if (take > 0) {
        result.add(
          p.copyWith(quantityDiscount: take, withComboDiscount: 0),
        );
        total += take;
      }
    }
    // showLog(
    //   result.map((e) => "${e.name}-${e.quantityDiscount}-${e.withComboDiscount}"),
    //   flags: "normal",
    // );

    // Duyệt phần combo
    if (total < max) {
      for (var p in products) {
        if (total >= max) break;

        int remaining = max - total;
        int take = p.withComboDiscount <= remaining ? p.withComboDiscount : remaining;

        if (take > 0) {
          // Kiểm tra xem đã tồn tại trong result chưa
          final index = result.indexWhere((e) => e.id == p.id);
          if (index != -1) {
            final existing = result[index];
            result[index] = existing.copyWith(
              quantityDiscount: existing.quantityDiscount + take,
              withComboDiscount: existing.withComboDiscount + take,
            );
          } else {
            result.add(
              p.copyWith(quantityDiscount: take, withComboDiscount: take),
            );
          }
          total += take;
        }
      }
    }
    // showLog(
    //   result.map((e) => "${e.name}-${e.quantityDiscount}-${e.withComboDiscount}"),
    //   flags: "final",
    // );

    return result;
  }
}
