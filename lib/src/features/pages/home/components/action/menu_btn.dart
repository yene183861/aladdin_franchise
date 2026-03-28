import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: CupertinoIcons.home,
      onTap: Scaffold.of(context).openDrawer,
    );
  }
}
