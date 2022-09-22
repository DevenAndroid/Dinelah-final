import 'package:card_swiper/card_swiper.dart';
import 'package:dinelah/controller/vendorsListController.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/item/host_item.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//
// class AllHostsScreen extends StatefulWidget {
//   const AllHostsScreen({Key? key}) : super(key: key);
//
//   @override
//   AllHostsScreenState createState() => AllHostsScreenState();
// }

class AllHostsScreen extends StatelessWidget {
  final searchController = TextEditingController();
  final controller = Get.put(VendorsController());
  //
  // @override
  // void initState() {
  //   super.initState();
  //   controller.getResetData();
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   // searchController.clear();
  //   controller.onClose();
  // }

  void applySearch(BuildContext context) {
    if (searchController.text.isEmpty) {
      showToast('Please enter something to search');
    } else {
      controller.searchKeyboard.value = searchController.text;
      controller.getDataMap();
      Get.toNamed(MyRouter.searchHostProduct,
          arguments: [searchController.text]);
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          // controller.context = context;
          return !controller.isDataLoading.value
              ? loader(context)
              : SingleChildScrollView(
                  child: SizedBox(
                    width: screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          searchView(context, () {
                            applySearch(context);
                          }, searchController),
                          addHeight(20),
                          Container(
                            height: screenSize.height * 0.18,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: const Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(15)),
                            child: Swiper(
                              autoplay: true,
                              outer: false,
                              autoplayDisableOnInteraction: false,
                              itemBuilder: (BuildContext context, int index) {
                                return
                                    //   CachedNetworkImage(
                                    //   imageUrl: controller
                                    //       .model.value.data!.slider.slides[0].url,
                                    //   imageBuilder: (context, imageProvider) =>
                                    //       Container(
                                    //     decoration: BoxDecoration(
                                    //       image: DecorationImage(
                                    //         image: imageProvider,
                                    //         fit: BoxFit.fill,
                                    //         // colorFilter: ColorFilter.mode(
                                    //         //     Colors.red,
                                    //         //     BlendMode.colorBurn
                                    //         // )
                                    //       ),
                                    //     ),
                                    //   ),
                                    //   placeholder: (context, url) => const SizedBox(
                                    //       height: 4,
                                    //       width: 4,
                                    //       child: CircularProgressIndicator(
                                    //         color: AppTheme.primaryColor,
                                    //       )),
                                    //   errorWidget: (context, url, error) =>
                                    //       const Icon(Icons.error),
                                    // );

                                    Image.network(
                                  controller
                                      .model.value.data!.slider.slides[0].url,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: CircularProgressIndicator(
                                          color: AppTheme.primaryColor,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              itemCount: controller
                                  .model.value.data!.slider.slides.length,
                              pagination: const SwiperPagination(),
                              control:
                                  const SwiperControl(size: 0), // remove arrows
                            ),
                          ),
                          addHeight(10),
                          Text(controller.model.value.data!.stores.length.toString()),
                          addHeight(10),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.model.value.data!.stores.length,
                              itemBuilder: (context, index) {
                                return hostItem(context, controller.model.value.data!.stores[index]);
                              }),
                          addHeight(10),
                        ],
                      ),
                    ),
                  ),
                );
        }));
  }

}
