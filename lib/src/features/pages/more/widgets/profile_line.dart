import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storages/local.dart';

class ProfileLineWidget extends ConsumerWidget {
  const ProfileLineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userData = LocalStorage.getDataLogin()!;
    var user = userData.user;
    var restaurant = userData.restaurant;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppImageCacheNetworkWidget(
                imageUrl: user?.image ?? "",
                width: 98,
                height: 98,
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? "User",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bold(),
                  ),
                  const SizedBox(height: 8),
                  Text(user?.email ?? "Email"),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          InfoLineWidget(
            iconData: CupertinoIcons.home,
            content: restaurant?.name ?? "",
            iconColor: AppColors.mainColor,
          ),
          InfoLineWidget(
            iconData: CupertinoIcons.location_solid,
            content: restaurant?.address ?? "",
            iconColor: AppColors.secondColor,
          ),
        ],
      ),
    );
  }
}

class InfoLineWidget extends StatelessWidget {
  final IconData iconData;
  final String content;
  final Color? iconColor;
  const InfoLineWidget({
    Key? key,
    required this.iconData,
    required this.content,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: iconColor,
      ),
      title: Text(
        content,
        style: AppTextStyle.regular(),
      ),
    );
  }
}
