import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/models/product_cancel.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RequestCancelWidget extends ConsumerWidget {
  const RequestCancelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductCancelModel> productCancels = [];
    // =ref.watch(homeProvider.select((value) => value.pro,));
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.red.shade400,
        ),
        borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusSecond),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleLineWidget(
            title:
                "${S.current.cancellation_request_is_pending} (${productCancels.length})",
            fontSize: 14.sp,
            color: Colors.red.shade700,
          ),
          ...productCancels
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    tileColor: Colors.grey.shade100,
                    shape: AppConfig.shapeBorderSecond,
                    title: Text(
                      e.getNameView(),
                      style: AppTextStyle.bold(),
                    ),
                    leading: Text(
                      "${S.current.quantityCut}: ${e.quantity}",
                      style: AppTextStyle.bold(
                        color: AppColors.secondColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(e.note),
                    trailing: ButtonSimpleWidget(
                      textAction: S.current.recall,
                      onPressed: () {
                        // showConfirmAction(context,
                        //     message:
                        //         "${S.current.revoke_the_order_cancellation_request} \"${e.getNameView()}\"?",
                        //     action: () async {
                        //   var result = await ref
                        //       .read(checkoutProvider.notifier)
                        //       .recallCancel(e);
                        //   if (result == null) {
                        //     // ignore: use_build_context_synchronously
                        //     showDoneSnackBar(
                        //       context: context,
                        //       message: S.current.success,
                        //     );
                        //   } else {
                        //     // ignore: use_build_context_synchronously
                        //     showMessageDialog(
                        //       context,
                        //       message: result,
                        //     );
                        //   }
                        //   ref.read(checkoutProvider.notifier).init();
                        //   ref.invalidate(productCheckoutProvider);
                        // });
                      },
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
