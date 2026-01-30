import 'dart:io';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/view_image.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/image_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ButtonTicketWidget extends StatelessWidget {
  const ButtonTicketWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return const _TicketForm();
          },
        );
      },
      leading: SvgPicture.asset(
        Assets.iconsSupport,
        color: Colors.black,
        height: 18,
      ),
      title: Text('Ticket'),
    );
  }
}

class _TicketForm extends StatefulWidget {
  const _TicketForm({super.key});

  @override
  State<_TicketForm> createState() => __TicketFormState();
}

class __TicketFormState extends State<_TicketForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleCtrl, descCtrl;
  List<File> images = [];

  int maxImage = 3;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController();
    descCtrl = TextEditingController();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          SvgPicture.asset(
            Assets.iconsSupport,
            color: AppColors.black,
            height: 20,
          ),
          const Gap(20),
          Expanded(
            child: Text('Ticket'),
          ),
          const Gap(20),
          CloseButton(),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TitleWidget(
                  title: 'Vấn đề',
                  isRequired: true,
                ),
                AppTextFormField(
                  required: true,
                  multiLine: false,
                  textController: titleCtrl,
                  validator: (value) {
                    var text = value?.trim() ?? '';
                    if (text.isEmpty) {
                      return 'Vấn đề không được để trống';
                    }
                    return null;
                  },
                ),
                const Gap(20),
                const _TitleWidget(
                  title: 'Mô tả',
                  isRequired: true,
                ),
                const Gap(8),
                AppTextFormField(
                  required: true,
                  multiLine: true,
                  minLines: 3,
                  textController: descCtrl,
                  validator: (value) {
                    var text = value?.trim() ?? '';
                    if (text.isEmpty) {
                      return 'Hãy mô tả chi tiết vấn đề mà bạn đang gặp phải';
                    }
                    return null;
                  },
                ),
                const Gap(20),
                const _TitleWidget(
                  title: 'Đính kèm',
                  isRequired: false,
                ),
                const Gap(8),
                Wrap(
                  runSpacing: 12,
                  children: [
                    if (images.length < maxImage)
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
                        ),
                        onPressed: () async {
                          var file = await ImageUtil.onTakeImage(context, popContext: false);
                          if (file != null) {
                            images.add(file);
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.attach_file_rounded),
                      ),
                    if (images.isNotEmpty)
                      ...images.map(
                        (e) => BoxImageWidget(
                          image: e,
                          widthFactor: 0.9,
                          onDeleteImage: (p0) {
                            images.removeWhere((element) => element == p0);
                            setState(() {});
                          },
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        AppCloseButton(
          textAction: 'Đóng',
          // padding: const EdgeInsets.all(8),
          onPressed: () {
            pop(context);
          },
        ),
        // ButtonCancelWidget(
        //   textAction: 'Đóng',
        //   padding: const EdgeInsets.all(8),
        //   onPressed: () {
        //     pop(context);
        //   },
        // ),
        SizedBox(
          width: 150,
          child: Consumer(
            builder: (context, ref, child) => ButtonMainWidget(
              textAction: 'Gửi ticket',
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  var result = await ref.read(homeProvider.notifier).sendTicket(
                        title: titleCtrl.text.trim(),
                        desc: descCtrl.text.trim(),
                        files: images,
                      );

                  if (result != null) {
                    showMessageDialog(context, message: result);
                    return;
                  }
                  pop(context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class BoxImageWidget extends ConsumerWidget {
  final File image;

  final double? widthFactor;

  final Function(File)? onDeleteImage;
  const BoxImageWidget({
    super.key,
    required this.image,
    this.widthFactor,
    this.onDeleteImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showImageWidget(
          context: context,
          imageWidget: Image.file(image),
          widthFactor: widthFactor,
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
                    "Ảnh lỗi, hãy xoá bỏ!",
                    style: AppTextStyle.regular(
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
                  onDeleteImage?.call(image);
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

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    required this.title,
    this.isRequired = false,
  });
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        children: [
          if (isRequired)
            TextSpan(
              text: ' *',
              style: AppTextStyle.medium(color: AppColors.redColor),
            ),
        ],
      ),
      style: AppTextStyle.medium(),
    );
  }
}
