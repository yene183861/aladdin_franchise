import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/ticket/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'components/ticket_info.dart';
import 'components/ticket_item.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(S.current.ticket_submission_history),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Danh sách ticket',
                    style: AppTextStyle.bold(),
                  ),
                  const Gap(12),
                  AppTextFormField(
                    hintText: 'Tìm ticket',
                    prefixIcon: const Icon(CupertinoIcons.search, size: 18),
                    onChanged: (value) {
                      ref.read(ticketPageProvider.notifier).onChangeTextSearch(value);
                    },
                  ),
                  const Gap(12),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        return ListView.separated(
                          itemBuilder: (context, index) => TicketItem(),
                          itemCount: 4,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      const VerticalDivider(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.iconsSupport,
                                  color: AppColors.black,
                                  height: 18,
                                ),
                                Gap(12),
                                Expanded(
                                  child: Text(
                                    'Khi add mã DTL2 thì hệ thống báo mã không tồn tại',
                                    style: AppTextStyle.bold(rawFontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Gap(20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TicketInfoWidget(),
                                    _TitleWidget(
                                      iconWidget: Icon(
                                        Icons.person,
                                        size: 16,
                                        color: AppColors.white,
                                      ),
                                      title: 'Nhận ticket từ',
                                    ),
                                    _TitleWidget(
                                      iconWidget: Icon(
                                        Icons.history,
                                        size: 16,
                                        color: AppColors.white,
                                      ),
                                      title: 'Lịch sử xử lý',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    required this.title,
    required this.iconWidget,
  });

  final String title;
  final Widget iconWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: const BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          iconWidget,
          const Gap(6),
          Flexible(
            child: Text(
              title,
              style: AppTextStyle.medium(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
