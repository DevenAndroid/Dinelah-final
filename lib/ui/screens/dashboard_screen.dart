
import 'package:card_swiper/card_swiper.dart';
import 'package:dinelah/controller/SearchController.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/screens/item/ItemProduct.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/ui/widget/gps.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/GetHomeController.dart';
import '../../models/ModelHomeData.dart';
import '../../routers/my_router.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  final _controller = Get.put(GetHomeController());
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GpsState().checkGps();
    _controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double itemHeight = screenSize.height / 2.8;
    final double  itemWidth = screenSize.width / 2;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() {
        return !_controller.isDataLoading.value
            ? Center(child: loader(context))
            : Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, left: 16.0, right: 16.0, bottom: 12),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lets You Find\nGood Quality Food',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'popins',
                              color: AppTheme.colorWhite),
                        ),
                        addHeight(20),
                        searchView(context, () {
                          applySearch(context);
                        }, searchController),
                        addHeight(20),
                        Container(
                          height: screenSize.height * 0.18,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Swiper(
                            autoplay: true,
                            outer: false,
                            autoplayDisableOnInteraction: false,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                _controller
                                    .model.value.data!.slider.slides[0].url
                                    .toString(),
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
                            itemCount: _controller
                                .model.value.data!.slider.slides.length,
                            pagination: const SwiperPagination(),
                            control:
                                const SwiperControl(size: 0), // remove arrows
                          ),
                        ),
                        addHeight(20),
                        SizedBox(
                          height: screenSize.height * 0.05,
                          child: ListView.builder(
                              itemCount: _controller
                                  .model.value.data!.category.categories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return categoryList(
                                    _controller
                                        .model.value.data!.category.categories,
                                    index);
                              }),
                        ),
                        addHeight(20),
                        const Text(
                          'Popular Dishes',
                          style: TextStyle(
                              color: AppTheme.textColorDarkBLue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        addHeight(10),
                      ],
                    )),
                    SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // childAspectRatio: (itemWidth / itemHeight),
                          mainAxisExtent: 242,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ItemProduct(
                              _controller,
                              _controller.model.value.data!.popularProducts,
                              index,
                              itemHeight,
                              false);
                        },
                        childCount: _controller
                            .model.value.data!.popularProducts.length,
                      ),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 40.0),
                    )
                  ],
                ),
              );
      }),
    );
  }

  void applySearch(BuildContext context) {
    final controller = Get.put(SearchController());
    controller.context = context;
    if (searchController.text.isEmpty) {
      showToast('Please enter something to search');
    } else {
      controller.searchKeyboard.value = searchController.text;
      Get.toNamed(MyRouter.searchProductScreen,
          arguments: [searchController.text]);
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  Widget categoryList(List<Categories> categories, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(MyRouter.categoryScreen, arguments: [
          categories,
          categories[index].termId,
          index,
        ]);
      },
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(50),
                  elevation: 3,
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      child: Image.network(
                        categories[index].imageUrl.toString(),
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
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
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                addWidth(8),
                Text(
                  categories[index].name.toString(),
                  style: const TextStyle(
                      color: AppTheme.textColorDarkBLue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )),
    );
  }
}
