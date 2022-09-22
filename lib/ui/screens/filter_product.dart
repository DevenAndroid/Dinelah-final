import 'dart:convert';

import 'package:dinelah/controller/FilterController.dart';
import 'package:dinelah/controller/SearchController.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_button_white.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ModelAllAttributes.dart';

class FilterProduct extends StatefulWidget {
  const FilterProduct({Key? key}) : super(key: key);

  @override
  State<FilterProduct> createState() => FilterProductState();
}

class FilterProductState extends State<FilterProduct> {
  final controller = Get.put(FilterController());

  RangeValues currentRangeValues = RangeValues(0, 500);
  @override
  void initState() {
    super.initState();
    initSPref();
  }

  Future<void> initSPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble('startPriceRange') != null) {
      controller.startPriceValue.value = prefs.getDouble('startPriceRange')!;
      controller.endPriceValue.value = prefs.getDouble('endPriceRange')!;
      controller.indexServiceType.value = prefs.getInt('indexServiceType')!;
      controller.indexCustomerReview.value =
          prefs.getInt('indexCustomerReview')!;
      print('RESPONSE DATA :: ' + prefs.getString('attributes').toString());
      controller.isDataLoading.value = true;
      controller.model.value = ModelAllAttributes.fromJson(
          jsonDecode(prefs.getString('attributes')!));
      currentRangeValues = RangeValues(
          controller.startPriceValue.value, controller.endPriceValue.value);
    } else {
      controller.getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text(
          "Filter",
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Price Range",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "0-1000\$",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                RangeSlider(
                  values: currentRangeValues,
                  max: 1000,
                  min: 0,
                  divisions: 1000,
                  activeColor: AppTheme.primaryColor,
                  inactiveColor: AppTheme.primaryColor.withAlpha(60),
                  labels: RangeLabels(
                    currentRangeValues.start.round().toString(),
                    currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      currentRangeValues = values;
                    });
                  },
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Service Type",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        // childAspectRatio: AddSize.size5 / 2.3,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 36,
                        crossAxisSpacing: 8,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.listServiceType.length,
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              controller.indexServiceType.value = index;
                            });
                          },
                          child: Container(
                            // margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 8),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                border: Border.all(
                                    color:
                                        index == controller.indexServiceType.value
                                            ? AppTheme.primaryColor
                                            : Colors.black),
                                color: index == controller.indexServiceType.value
                                    ? AppTheme.primaryColor.withAlpha(60)
                                    : Colors.transparent,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppTheme.etBgColor,
                                    offset: Offset(0.0, 1.5),
                                    blurRadius: 1.5,
                                  ),
                                ]),
                            child: Text(
                              controller.listServiceType[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                      index == controller.indexServiceType.value
                                          ? AppTheme.primaryColor
                                          : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      }),
                ),
                addHeight(16),
                const Divider(
                  height: 1,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Customer Review",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            controller.indexCustomerReview.value = index;
                          });
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: (4 - index.toDouble()),
                                        minRating: 0,
                                        itemSize: 24,
                                        ignoreGestures: true,
                                        // direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: AppTheme.primaryColor,
                                        ),
                                        onRatingUpdate: (rating) {
                                          // debugPrint(rating.toString());
                                        },
                                      ),
                                      const Text(
                                        " & up",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    controller.indexCustomerReview.value ==
                                            index
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: AppTheme.primaryColor,
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
                    }),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Attributes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                !controller.isDataLoading.value
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.model.value.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.model.value.data![index].title
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                addHeight(10),
                                GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            // childAspectRatio: 2.7,
                                            // childAspectRatio:
                                            //     AddSize.size5 / 1.9,
                                            crossAxisSpacing: 16,
                                            mainAxisExtent: 36,
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 16),
                                    itemCount: controller
                                        .model.value.data![index].items!.length,
                                    itemBuilder:
                                        (BuildContext ctx, indexChild) {
                                      Items item = controller.model.value
                                          .data![index].items![indexChild];
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            item.isSelected = !item.isSelected;
                                          });
                                        },
                                        child: Container(
                                          // margin: const EdgeInsets.all(2),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(6),
                                              ),
                                              border: Border.all(
                                                  color: item.isSelected
                                                      ? AppTheme.primaryColor
                                                      : Colors.black),
                                              color: item.isSelected
                                                  ? AppTheme.primaryColor
                                                      .withAlpha(60)
                                                  : Colors.transparent,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: AppTheme.etBgColor,
                                                  offset: Offset(0.0, 1.5),
                                                  blurRadius: 1.5,
                                                ),
                                              ]),
                                          child: Text(
                                            item.name.toString().capitalizeFirst??'',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: item.isSelected
                                                    ? AppTheme.primaryColor
                                                    : Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      );
                                    }),
                                addHeight(16),
                              ],
                            ),
                          );
                        }),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommonButton(
                        buttonHeight: 6.5,
                        buttonWidth: 45,
                        mainGradient: AppTheme.primaryGradientColor,
                        text: 'Apply',
                        textColor: Colors.white,
                        onTap: () async {
                          final searchController = Get.put(SearchController());
                          var minPrice = currentRangeValues.start.toString();
                          var maxPrice = currentRangeValues.end.toString();
                          debugPrint('Range Error :: $currentRangeValues');
                          debugPrint(
                              'Customer Review :: ${4 - controller.indexCustomerReview.value}');
                          searchController.searchKeyboard.value =
                              Get.arguments == null ? '' : Get.arguments[0];
                          searchController.productType.value = controller
                              .listServiceType[
                                  controller.indexServiceType.value]
                              .toLowerCase()
                              .toString();
                          searchController.minPrice.value =
                              currentRangeValues.start.toString();
                          searchController.maxPrice.value =
                              currentRangeValues.end.toString();
                          searchController.rating.value =
                              (4 - controller.indexCustomerReview.value)
                                  .toString();
                          searchController.modelAttribute.value =
                              controller.model.value;

                          // print('DTAA  :: ' +
                          //     jsonEncode(
                          //         searchController.modelAttribute.value));
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setDouble(
                              'startPriceRange', currentRangeValues.start);
                          prefs.setDouble(
                              'endPriceRange', currentRangeValues.end);
                          prefs.setInt('indexServiceType',
                              controller.indexServiceType.value);
                          prefs.setInt('indexCustomerReview',
                              controller.indexCustomerReview.value);
                          prefs.setString(
                              'attributes', jsonEncode(controller.model.value));

                          searchController.getData(
                              Get.arguments == null ? '' : Get.arguments[0],
                              controller.listServiceType[
                                      controller.indexServiceType.value]
                                  .toLowerCase()
                                  .toString(),
                              minPrice,
                              maxPrice,
                              (4 - controller.indexCustomerReview.value)
                                  .toString(),
                              searchController.sortBy.value,
                              searchController.modelAttribute.value);

                          searchController.getMapData();
                          // Get.offAllNamed(MyRouter.searchProductScreen);
                          Get.back();
                        },
                      ),
                      CommonButtonWhite(
                        buttonHeight: 6,
                        buttonWidth: 45,
                        mainGradient: AppTheme.primaryGradientColor,
                        text: 'Clear',
                        textColor: AppTheme.primaryColor,
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('startPriceRange');
                          prefs.remove('endPriceRange');
                          prefs.remove('indexServiceType');
                          prefs.remove('indexCustomerReview');
                          prefs.remove('attributes');
                          final searchController = Get.put(SearchController());
                          // searchController.searchKeyboard.value = '';
                          searchController.productType.value = '';
                          searchController.minPrice.value = '';
                          searchController.maxPrice.value = '';
                          searchController.rating.value = '';
                          searchController.sortBy.value = '';
                          searchController.getMapData();
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
