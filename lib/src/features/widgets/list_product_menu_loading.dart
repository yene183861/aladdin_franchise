import 'package:aladdin_franchise/src/features/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';

class ListProductMenuLoadingWidget extends StatelessWidget {
  const ListProductMenuLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double borderRadiusValue = 12;
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: ContainerBoxWidget(
              width: 220,
              height: 52,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(22),
                bottomLeft: Radius.circular(22),
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2,
            ),
            children: List.generate(
                12,
                (index) => Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(borderRadiusValue)),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 3,
                            child: ContainerBoxWidget(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(borderRadiusValue),
                                  bottomLeft:
                                      Radius.circular(borderRadiusValue)),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const ContainerBoxWidget(
                                    height: 50,
                                    width: double.maxFinite,
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                            Radius.circular(borderRadiusValue)),
                                  ),
                                  const ContainerBoxWidget(
                                      height: 36, width: 80),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(),
                                        const SizedBox(),
                                        ContainerBoxWidget(
                                          height: 45,
                                          width: 45,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )),
          ),
        ),
      ],
    );
  }
}
