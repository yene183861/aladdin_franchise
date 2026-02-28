import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider.dart';
import '../state.dart';

class O2oModeSwitcher extends ConsumerWidget {
  const O2oModeSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewMode = ref.watch(orderToOnlinePageProvider.select((value) => value.viewMode));
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: O2oViewModeEnum.values.map(
          (e) {
            bool selected = viewMode == e;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  ref.read(orderToOnlinePageProvider.notifier).onChangeViewMode(e);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:
                        selected ? const [BoxShadow(color: Colors.black12, blurRadius: 6)] : null,
                  ),
                  child: Text('${e.icon} ${e.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.black : Colors.grey,
                      )),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
