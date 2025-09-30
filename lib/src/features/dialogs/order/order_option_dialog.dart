import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_detail.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showOrderOptionDialog(BuildContext context) async {
  if (context.mounted) {
    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: TitleDialogWithCloseWidget(
            title: S.current.order,
          ),
          content: const _OrderOptionWidget(),
          shape:
              RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}

class _OrderOptionWidget extends ConsumerStatefulWidget {
  const _OrderOptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _OrderOptionWidgetState();
}

class _OrderOptionWidgetState extends ConsumerState<_OrderOptionWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.refresh(tablesAndOrdersProvider);
        ref.refresh(reservationsProvider);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const DropdownOrderWidget(
      showOtherOption: true,
      isExpanded: true,
    );
  }
}
