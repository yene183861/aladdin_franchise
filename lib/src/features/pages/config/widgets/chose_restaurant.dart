// ignore_for_file: use_build_context_synchronously

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/services/aladdin_web.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_simple_loading.dart';
import 'package:aladdin_franchise/src/features/widgets/change_server_config.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/services/provider.dart';
import '../../../../models/restaurant_config.dart';
import '../../../../utils/show_snackbar.dart';
import '../../../widgets/textfield_simple.dart';
import '../provider.dart';

class ChoseRestaurantWidget extends ConsumerStatefulWidget {
  const ChoseRestaurantWidget({super.key});

  @override
  ConsumerState createState() => _ChoseRestaurantWidgetState();
}

class _ChoseRestaurantWidgetState extends ConsumerState<ChoseRestaurantWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(configProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final server = ref.watch(configProvider.select((value) => value.server));
    final providerByPlatform = restaurantConfigAladdinWebProvider;
    var restaurants = ref.watch(providerByPlatform);
    final keyword = ref.watch(configProvider.select((value) => value.keyword));
    final tags = ref.watch(configProvider.select((value) => value.tags));
    var paddingHorizontal = const EdgeInsets.symmetric(horizontal: 20);
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: Gap(12)),
        SliverToBoxAdapter(
          child: Padding(
            padding: paddingHorizontal,
            child: ChangeServerConfigWidget(
              value: server,
              onChangeValue: (value) {
                ref.read(configProvider.notifier).onChangeServer(value);
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: Gap(12)),
        SliverToBoxAdapter(
          child: Padding(
            padding: paddingHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${S.current.chose} ${S.current.restaurant.toLowerCase()}",
                  style: AppTextStyle.medium(),
                ),
                FilledButton.tonalIcon(
                  onPressed: () {
                    ref.refresh(providerByPlatform);
                    showDoneSnackBar(
                      context: context,
                      message: S.current.data_updated,
                    );
                  },
                  icon: const Icon(Icons.cloud_download_outlined),
                  label: Text(
                    S.current.reload_list,
                    style: AppTextStyle.regular(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: Gap(12)),
        SliverToBoxAdapter(
          child: Padding(
            padding: paddingHorizontal,
            child: AppTextFieldWidget(
              label: "${S.current.search} ${S.current.restaurant.toLowerCase()}",
              onChanged: (value) => ref.read(configProvider.notifier).changeKeyword(value.trim()),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: Gap(12)),
        SliverToBoxAdapter(
          child: Padding(padding: paddingHorizontal, child: const _RestaurantTagsWidget()),
        ),
        const SliverToBoxAdapter(child: Gap(12)),
        restaurants.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            List<RestaurantConfigModel> dataView = List.from(data);
            if (keyword.isNotEmpty) {
              dataView = dataView
                  .where((element) => element.name.toLowerCase().contains(keyword))
                  .toList();
            }
            if (tags.isNotEmpty) {
              dataView = dataView.where((element) => tags.contains(element.tags)).toList();
            }
            return dataView.isEmpty
                ? SliverToBoxAdapter(
                    child: Container(
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 100),
                        child: Text(S.current.restaurantEmpty)),
                  )
                : SliverList.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: paddingHorizontal,
                      child: _LineRestaurantConfigWidget(
                        restaurant: dataView[index],
                      ),
                    ),
                    itemCount: dataView.length,
                  );
          },
          error: (error, stackTrace) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: AppErrorSimpleWidget(
                  message: error.toString(),
                  onTryAgain: () {
                    ref.refresh(providerByPlatform);
                  },
                ),
              ),
            );
          },
          loading: () {
            return const SliverToBoxAdapter(
              child: Padding(padding: EdgeInsets.only(top: 100), child: AppSimpleLoadingWidget()),
            );
          },
        ),
      ],
    );
  }
}

class _LineRestaurantConfigWidget extends ConsumerWidget {
  final RestaurantConfigModel restaurant;
  const _LineRestaurantConfigWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
      color: Colors.grey[50],
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        leading: Icon(
          CupertinoIcons.home,
          color: restaurant.orderOnline ? Colors.green : null,
        ),
        onTap: () {
          showConfirmAction(
            context,
            title: S.current.infoConfig,
            message: '''
🏠 ${restaurant.name}

⛳︎ ${restaurant.address}

🌐 ${restaurant.orderOnline ? S.current.yes.toUpperCase() : S.current.no.toUpperCase()} ${S.current.orderOnline.toLowerCase()}
            ''',
            action: () async {
              await ref.read(configProvider.notifier).onConfirmRestaurantConfig(restaurant);
              ref.refresh(styleAppProvider);
              showDoneSnackBar(context: context, message: S.current.settings_saved);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          );
        },
        title: Text(
          restaurant.name,
          style: AppTextStyle.regular(),
        ),
        subtitle: Text(
          restaurant.address,
          style: AppTextStyle.regular(),
        ),
      ),
    );
  }
}

class _RestaurantTagsWidget extends ConsumerWidget {
  const _RestaurantTagsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsSelect = ref.watch(configProvider.select((value) => value.tags));
    final appAction = ref.watch(restaurantTagsProvider);
    return appAction.when(
      data: (tags) {
        return Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            ...tags.map(
              (e) => FilterChip(
                label: Text(
                  e,
                  style: AppTextStyle.regular(),
                ),
                selected: tagsSelect.contains(e),
                onSelected: (value) {
                  ref.read(configProvider.notifier).onChangeTags(e);
                },
              ),
            ),
          ],
        );
      },
      error: (_, __) {
        return Container();
      },
      loading: () {
        return const LinearProgressIndicator();
      },
    );
  }
}
