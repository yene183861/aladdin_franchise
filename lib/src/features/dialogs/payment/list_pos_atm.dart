import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListPosATMWidget extends ConsumerStatefulWidget {
  const ListPosATMWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListPosATMWidgettState();
}

class _ListPosATMWidgettState extends ConsumerState<ListPosATMWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeProvider.notifier).getListAtmPos();
    });
  }

  @override
  Widget build(BuildContext context) {
    var atmPosSelect =
        ref.watch(homeProvider.select((value) => value.atmPosSelect));
    var orderSelect =
        ref.watch(homeProvider.select((value) => value.orderSelect));
    var dataBill = ref.watch(homeProvider.select((value) => value.dataBill));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 400),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.bgMenu),
              borderRadius: AppConfig.borderRadiusMain,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.order_info,
                  style: AppTextStyle.bold(),
                ),
                const Gap(6),
                _TitleLine(
                  title: '${S.current.order_code}: ',
                  content: orderSelect?.getOrderMisc() ?? '',
                ),
                const Gap(4),
                _TitleLine(
                  title: '${S.current.total_amount}: ',
                  content: AppConfig.formatCurrency()
                      .format(dataBill.price.totalPriceFinal),
                ),
                if (atmPosSelect != null) ...[
                  const Gap(4),
                  _TitleLine(
                    title: '${S.current.machine_type}: ',
                    content: atmPosSelect.name,
                  ),
                ],
              ],
            ),
          ),
          const Gap(12),
          Consumer(
            builder: (context, ref, child) {
              var listAtmPos =
                  ref.watch(homeProvider.select((value) => value.listAtmPos));
              var state = ref
                  .watch(homeProvider.select((value) => value.listAtmPosState));

              switch (state.status) {
                case PageCommonState.loading:
                  return AppLoadingSimpleWidget(
                    message: S.current.loading_pos_list,
                  );

                case PageCommonState.error:
                  return AppErrorSimpleWidget(
                    message: state.messageError,
                    onTryAgain: () {
                      ref.read(homeProvider.notifier).getListAtmPos();
                    },
                  );
                case PageCommonState.success:
                  return listAtmPos.isEmpty
                      ? Text(S.current.no_pos_info)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              S.current.select_pos_to_continue,
                              style: AppTextStyle.regular(fontSize: 12),
                            ),
                            const Gap(12),
                            ...listAtmPos.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: InkWell(
                                  onTap: () {
                                    ref
                                        .read(homeProvider.notifier)
                                        .onChangeAtmPosSelect(e);
                                  },
                                  borderRadius: AppConfig.borderRadiusMain,
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 500),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: atmPosSelect == e
                                              ? AppColors.mainColor
                                              : Colors.grey.shade300),
                                      borderRadius: AppConfig.borderRadiusMain,
                                    ),
                                    child: Text(
                                      e.name,
                                      style: AppTextStyle.regular(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );

                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _TitleLine extends StatelessWidget {
  const _TitleLine({
    required this.title,
    required this.content,
    this.titleTextStyle,
    this.contentTextStyle,
  });

  final String title;
  final String content;

  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: title,
          children: [
            TextSpan(
                text: content,
                style: contentTextStyle ?? AppTextStyle.regular()),
          ],
          style: titleTextStyle),
      style: titleTextStyle ?? AppTextStyle.bold(),
    );
  }
}
