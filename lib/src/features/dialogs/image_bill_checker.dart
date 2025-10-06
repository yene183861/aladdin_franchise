import 'dart:io';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/view_image.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button_square_menu.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// Author: sondv
/// Created 15/03/2024 at 13:51

class PQCImageBillCheckerWidget extends ConsumerStatefulWidget {
  const PQCImageBillCheckerWidget({super.key, this.canAction = true});
  final bool canAction;
  @override
  ConsumerState createState() => _PQCImageBillCheckerWidgetState();
}

class _PQCImageBillCheckerWidgetState
    extends ConsumerState<PQCImageBillCheckerWidget> {
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final images = ref.watch(homeProvider.select((value) => value.imageBills));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.attached_image,
                    style: AppTextStyle.bold(),
                  ),
                  Text(
                    S.current.attached_image_purpose,
                    style: AppTextStyle.regular(),
                  ),
                ],
              ),
            ),
            const Gap(8),
            if (images.length < 3 && widget.canAction)
              Platform.isAndroid
                  ? PopupMenuButton(
                      icon: const ResponsiveIconWidget(
                          iconData: Icons.add_photo_alternate),
                      iconColor: AppColors.secondColor,
                      iconSize: 28,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.camera_alt_outlined),
                              title: Text(
                                S.current.take_photo_use_camera,
                                style: AppTextStyle.regular(),
                              ),
                              onTap: () =>
                                  _onTakeImage(context, useCamera: true),
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.image_search),
                              title: Text(
                                S.current.select_photo_from_galley,
                                style: AppTextStyle.regular(),
                              ),
                              onTap: () => _onTakeImage(context),
                            ),
                          ),
                        ];
                      },
                    )
                  : ButtonSquareMenuWidget(
                      onPressed: () async {
                        _onTakeImage(context, popContext: false);
                      },
                      child: const ResponsiveIconWidget(
                        iconData: Icons.add_photo_alternate,
                      ),
                    ),
          ],
        ),
        const GapH(8),
        if (images.isNotEmpty)
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    images.map((e) => _BoxImageBillWidget(image: e)).toList(),
              ),
            ),
          )
      ],
    );
  }

  Future<void> _onTakeImage(BuildContext context,
      {bool useCamera = false, bool popContext = true}) async {
    try {
      if (popContext) pop(context);
      final XFile? photo = await picker.pickImage(
        source: useCamera ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 1920,
        maxWidth: 1080,
      );
      // Có 1 case ảnh từ thiết bị bị null nên cần check lại size ảnh
      if (photo != null) {
        final file = File(photo.path);
        final fileSize = await file.length();
        if (fileSize <= 0) {
          showMessageDialog(
            context,
            message: S.current.invalid_photo_select_again,
          );
        } else {
          ref.read(homeProvider.notifier).updateImageBill(file);
        }
      }
    } catch (ex) {
      showLog(ex, flags: '_onTakeCamera');
    }
  }
}

class _BoxImageBillWidget extends ConsumerWidget {
  final File image;
  const _BoxImageBillWidget({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showImageWidget(
          context: context,
          imageWidget: Image.file(image),
        );
      },
      child: Container(
        width: 80,
        color: Colors.grey.shade100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            Image.file(
              image,
              errorBuilder: (context, obj, st) {
                return Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    S.current.image_error_delete,
                    style: AppTextStyle.regular(
                      // fontSize: 16.sp,
                      // fontSize: 16,
                      color: AppColors.redColor,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: -10,
              right: -5,
              child: IconButton(
                onPressed: () {
                  ref.read(homeProvider.notifier).updateImageBill(image);
                },
                padding: EdgeInsets.zero,
                color: Colors.red,
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
