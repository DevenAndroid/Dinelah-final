import 'package:dinelah/controller/BottomNavController.dart';
import 'package:dinelah/controller/SearchController.dart';
import 'package:dinelah/helper/Helpers.dart';
import 'package:dinelah/models/PopularProduct.dart';
import 'package:dinelah/repositories/get_update_cart_repository.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/screens/item/ItemVariationBottomSheet.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/app_assets.dart';
import '../../routers/my_router.dart';
import '../widget/common_widget.dart';
import 'package:flutter_html/flutter_html.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  SearchProductState createState() => SearchProductState();
}

class SearchProductState extends State<SearchProduct> {
  final controller = Get.put(SearchController());
  bool value = false;
  int? val = -1;

  var indexSortBy = 0;
  RxBool isSort = false.obs;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      controller.searchKeyboard.value = Get.arguments[0];
    }
    searchController.text = controller.searchKeyboard.value;
    searchController.addListener(() {
      controller.searchKeyboard.value = searchController.text;
    });
    searchController.addListener(() {
      controller.searchKeyboard.value = searchController.text;
      controller.mListProducts.clear();
      // if (searchController.text.isEmpty) {
      //   controller.mListProducts.clear();
      //   controller.mListProducts.addAll(controller.model.value.data!.products);
      // }
      for (var item in controller.model.value.data!.products) {
        if (item.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase().toString()) ||
            item.slug
                .toLowerCase()
                .contains(searchController.text.toLowerCase())) {
          controller.mListProducts.add(item);
        }
      }
    });
    controller.getData(
        controller.searchKeyboard.value,
        controller.productType.value,
        controller.minPrice.value,
        controller.maxPrice.value,
        controller.rating.value,
        controller.sortBy.value,
        controller.modelAttribute.value);
  }

  final searchController = TextEditingController();
  List<String> listSortBy = [
    'Recently Added',
    'Price: Low to High',
    'Price: High to Low',
    'Top Rated'
  ];


  @override
  void dispose() {
    super.dispose();
    controller.onClose();
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xfffff8f9),
        image: DecorationImage(
          image: AssetImage(
            AppAssets.shapeBg,
          ),
          alignment: Alignment.topRight,
          fit: BoxFit.contain,
        ),
      ),
      child: Scaffold(
        appBar: backAppBar('Search Result'),
        backgroundColor: Colors.transparent,
        body: Obx(() {
          if (controller.sortBy.value != '') {
            isSort.value = true;
          }
          return controller.isDataLoading.value
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenSize.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: searchView(context, () {
                                      controller.getMapData();
                                    }, searchController),
                                  ),
                                  filter(() {
                                    Get.toNamed(MyRouter.filterProduct,
                                        arguments: [
                                          controller.searchKeyboard.value
                                        ]);
                                  })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      addHeight(10),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16))),
                                builder: (context) => DraggableScrollableSheet(
                                  initialChildSize: 0.4,
                                  minChildSize: 0.2,
                                  maxChildSize: 0.40,
                                  expand: false,
                                  builder: (_, controller) => Column(
                                    children: [
                                      Icon(
                                        Icons.remove,
                                        size: 50,
                                        color: Colors.grey[600],
                                      ),
                                      Text(
                                        'Sort By',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      addHeight(24),
                                      Expanded(
                                        child: ListView.builder(
                                          controller: controller,
                                          itemCount: listSortBy.length,
                                          itemBuilder: (_, index) {
                                            return itemTextFilter(index);
                                          },
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Sort by',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isSort.value,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSort.value = !isSort.value;
                                  controller.sortBy.value = '';
                                  controller.getData(
                                      controller.searchKeyboard.value,
                                      controller.productType.value,
                                      controller.minPrice.value,
                                      controller.maxPrice.value,
                                      controller.rating.value,
                                      '',
                                      controller.modelAttribute.value);
                                });
                              },
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.white,
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  child: Row(
                                    children: [
                                      Text(controller.sortBy.value.toString()),
                                      addWidth(8),
                                      Icon(Icons.clear)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      addHeight(8),
                      controller.mListProducts.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 80.0),
                              child: Text('No Product Found'),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: controller.mListProducts.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return orderCard(
                                        controller.mListProducts[index]);
                                  }),
                            ),
                    ],
                  ),
                )
              : loader(context);
        }),
      ),
    );
  }

  Widget filter(onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8)),
        child: Image.asset(AppAssets.filterIcon),
      ),
    );
  }

  Widget orderCard(ModelProduct product) {
    final bottomNavController = Get.put(BottomNavController());
    return GestureDetector(
      onTap: () {
        if (product.type.toString() == "simple") {
          Get.toNamed(MyRouter.singleProductScreen,
              arguments: [product]);
        } else if (product.type.toString() ==
            "variable") {
          Get.toNamed(MyRouter.singleProductScreen,
              arguments: [product]);
        } else {
          Get.toNamed(MyRouter.bookingProductScreen,
              arguments: [product]);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(50),
                  elevation: 3,
                  child: SizedBox(
                    height: 85,
                    width: 85,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.network(
                        product.imageUrl,
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
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                addWidth(12),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addHeight(8),
                    Text(
                      product.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                    addHeight(4),
                    Text(
                      product.categoryName,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                    addHeight(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Html(data: product.price.toString(),
                            style: {
                              "bdi": Style(
                                fontSize: FontSize(14.0),
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // print(product.type.toString());
                            if (product.type.toString() == "simple") {
                              getUpdateCartData(context, product.id, 1)
                                  .then((value) {
                                    showToast(value.message);
                                if (value.status) {

                                  // final bottomNavController = Get.put(BottomNavController());
                                  // ++bottomNavController.cartBadgeCount.value;
                                  bottomNavController.getData();
                                  // Helpers.createSnackBar(
                                  //     context, value.message.toString());
                                } else {}
                                return;
                              });
                            } else if (product.type.toString() == "variable") {
                              _getVariationBottomSheet(product);
                            } else if (product.type.toString() == "booking") {
                              Get.toNamed(MyRouter.bookingProductScreen,
                                  arguments: [product]);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppTheme.primaryColor,
                            ),
                            child: Row(
                              children: const [
                                Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getVariationBottomSheet(ModelProduct popularProduct) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return ItemVariationBottomSheet(popularProduct);
        });
  }

  Widget itemTextFilter(index) {
    return InkWell(
      onTap: () {
        setState(() {
          indexSortBy = index;
          controller.sortBy.value = listSortBy[index].toString();
        });
        controller.getData(
            controller.searchKeyboard.value,
            controller.productType.value,
            controller.minPrice.value,
            controller.maxPrice.value,
            controller.rating.value,
            listSortBy[index]
                .toLowerCase()
                .trim()
                .replaceAll(' ', '')
                .replaceAll(':', '')
                .toString(),
            controller.modelAttribute.value);
        Get.back();
      },
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  listSortBy[index],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
