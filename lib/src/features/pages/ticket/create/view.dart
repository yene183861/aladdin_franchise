import 'dart:io';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/view_image.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/app_log.dart';
import '../../../../utils/date_time.dart';
import '../../../../utils/field_validation.dart';
import '../../../dialogs/message.dart';
import '../../../dialogs/processing.dart';
import 'provider.dart';
import 'state.dart';

class TicketCreateWidget extends ConsumerStatefulWidget {
  const TicketCreateWidget({
    super.key,
    this.title,
    this.content,
    this.attachFile,
  });
  final String? title;
  final String? content;
  final List<File>? attachFile;

  @override
  ConsumerState createState() => _TicketCreateWidgetState();
}

class _TicketCreateWidgetState extends ConsumerState<TicketCreateWidget> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleCtrl, contentCtrl;
  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.title);
    contentCtrl = TextEditingController(text: widget.content);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(ticketCreatePageProvider.notifier).initialize(
            title: widget.title,
            content: widget.content,
            attachFile: widget.attachFile,
          );
    });
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    contentCtrl.dispose();
    super.dispose();
  }

  _listenEvent(BuildContext context, WidgetRef ref) =>
      (TicketCreateEvent? previous, TicketCreateEvent? next) {
        switch (next) {
          case TicketCreateEvent.processing:
            showProcessingDialog(
              context,
              message: S.current.sending_ticket,
            );
            break;
          case TicketCreateEvent.error:
            Navigator.pop(context);
            showMessageDialog(
              context,
              titleMessage: S.current.sending_ticket_failed,
              message:
                  ref.read(ticketCreatePageProvider.notifier).getErrorMessage(),
            );
            break;
          case TicketCreateEvent.success:
            Navigator.pop(context);
            showConfirmAction(
              context,
              title: S.current.success,
              message: S.current.msg_send_ticket_success,
              notCancel: true,
              actionTitle: S.current.close,
              action: () => pop(context),
            );
            break;
          default:
            break;
        }
      };

  @override
  Widget build(BuildContext context) {
    ref.listen<TicketCreateEvent>(
      ticketCreatePageProvider.select((value) => value.events),
      _listenEvent(context, ref),
    );
    final notifier = ref.read(ticketCreatePageProvider.notifier);
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool isTablet = AppDeviceSizeUtil.checkTabletDevice();
    bool portraitOrientation =
        AppDeviceSizeUtil.checkPortraitOrientation(context);

    bool useTab = (isMobile || (isTablet && portraitOrientation));
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            width: useTab ? 80.w : 45.w,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                ListTile(
                  leading: ResponsiveIconWidget(
                    iconData: Icons.outgoing_mail,
                    color: Colors.black,
                  ),
                  // const Icon(
                  //   Icons.outgoing_mail,
                  //   color: Colors.black,
                  //   size: 24,
                  // ),
                  title: Text(
                    S.current.create_ticket_apos_lite_sys,
                    style: AppTextStyle.bold(fontSize: 14.sp),
                  ),
                  trailing: CloseButton(
                    onPressed: () => pop(context),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                ),
                const Divider(height: 0, color: Colors.grey),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          TextFieldSimpleWidget(
                            label: S.current.problem,
                            required: true,
                            textController: titleCtrl,
                            validator: (value) =>
                                FieldValidationUtils.checkRequired(value),
                            maxLength: 1000,
                            multiLine: true,
                            minLines: 1,
                            onChanged: (text) {
                              notifier.changeForm(title: text.trim());
                            },
                          ),
                          const Gap(26),
                          TextFieldSimpleWidget(
                            label: S.current.description,
                            textController: contentCtrl,
                            validator: (value) =>
                                FieldValidationUtils.checkRequired(value),
                            required: true,
                            multiLine: true,
                            minLines: 3,
                            maxLength: 3000,
                            onChanged: (text) {
                              notifier.changeForm(content: text.trim());
                            },
                          ),
                          const Gap(16),
                          const _DateOfWishWidget(),
                          const Gap(24),
                          const _AttachedFileWidget(),
                          const Gap(56),
                          ButtonMainWidget(
                            textAction: S.current.send_ticket,
                            widthFactor: 0.5,
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await notifier.onSummit();
                              }
                            },
                          ),
                          const Gap(16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DateOfWishWidget extends ConsumerStatefulWidget {
  const _DateOfWishWidget({super.key});

  @override
  ConsumerState createState() => __DateOfWishWidgetState();
}

class __DateOfWishWidgetState extends ConsumerState<_DateOfWishWidget> {
  @override
  Widget build(BuildContext context) {
    final dateOfWish =
        ref.watch(ticketCreatePageProvider.select((value) => value.dateOfWish));
    return Material(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Colors.grey.shade200,
        title: Text(S.current.desired_completion_date),
        subtitle: Row(
          children: [
            Text(
              dateOfWish == null
                  ? S.current.no_date_selected
                  : DateTimeUtils.instance.dateFormatDDMMYYYY
                      .format(dateOfWish),
            ),
            if (dateOfWish != null)
              IconButton(
                tooltip: S.current.delete_desired_completion_date,
                onPressed: () {
                  ref
                      .read(ticketCreatePageProvider.notifier)
                      .changeDateOfWish(null);
                },
                color: AppColors.redColor,
                iconSize: 20,
                icon: const Icon(CupertinoIcons.clear_circled),
              ),
          ],
        ),
        trailing: IconButton(
          onPressed: () async {
            final pickDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2222),
            );
            if (pickDate != null) {
              ref
                  .read(ticketCreatePageProvider.notifier)
                  .changeDateOfWish(pickDate);
            }
          },
          tooltip: S.current.select_completion_date,
          color: Colors.blueAccent,
          icon: const Icon(Icons.date_range),
        ),
      ),
    );
  }
}

class _AttachedFileWidget extends ConsumerStatefulWidget {
  const _AttachedFileWidget({super.key});

  @override
  ConsumerState createState() => __AttachedFileWidgetState();
}

class __AttachedFileWidgetState extends ConsumerState<_AttachedFileWidget> {
  Future<void> _onTakeImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1920,
        maxWidth: 1080,
      );
      if (photo != null) {
        final file = File(photo.path);
        final fileSize = await file.length();
        if (fileSize <= 0) {
          showMessageDialog(
            context,
            message: S.current.invalid_image_please_take_again,
          );
        } else {
          ref.read(ticketCreatePageProvider.notifier).updateAttachFile(file);
        }
      }
    } catch (ex) {
      showLog(ex, flags: '_onTakeCamera');
    }
  }

  @override
  Widget build(BuildContext context) {
    final attachFile =
        ref.watch(ticketCreatePageProvider.select((value) => value.attachFile));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(S.current.attach_three_image),
            attachFile.length >= 3
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () => _onTakeImage(),
                    tooltip: S.current.add_attachment,
                    iconSize: 26,
                    color: Colors.blueAccent,
                    icon: const Icon(Icons.attach_file),
                  ),
          ],
        ),
        const Gap(12),
        SizedBox(
          height: 100,
          child: attachFile.isEmpty
              ? Center(
                  child: Text(
                    S.current.no_attached_photos,
                    style: AppTextStyle.regular(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...attachFile.map((e) {
                      return Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 16),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: GestureDetector(
                                onTap: () {
                                  showImageWidget(
                                    context: context,
                                    imageProvider: Image.file(e).image,
                                  );
                                },
                                child: Image.file(
                                  e,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, obj, st) {
                                    return Container(
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: Text(
                                        S.current.image_error_delete,
                                        style: AppTextStyle.regular(
                                          fontSize: 16,
                                          color: AppColors.redColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -5,
                              child: IconButton(
                                onPressed: () {
                                  ref
                                      .read(ticketCreatePageProvider.notifier)
                                      .updateAttachFile(e);
                                },
                                padding: EdgeInsets.zero,
                                color: Colors.red,
                                icon: const Icon(
                                  CupertinoIcons.delete_solid,
                                  size: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
        ),
      ],
    );
  }
}
