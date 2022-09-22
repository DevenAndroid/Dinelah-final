import 'package:dinelah/controller/vendorsListController.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_button_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterHost extends StatefulWidget {
  const FilterHost({Key? key}) : super(key: key);

  @override
  State<FilterHost> createState() => FilterHostState();
}

class FilterHostState extends State<FilterHost> {
  final controller = Get.put(VendorsController());

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 14,
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
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: (4 - index.toDouble()),
                                      minRating: 0,
                                      itemSize: 24,
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
                                  controller.indexCustomerReview.value == index
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
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Near by",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Checkbox(
                        value: controller.isNearBy.value,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            controller.isNearBy.value = value!;
                          });
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
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
                        final searchController = Get.put(VendorsController());
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        var map = <String, dynamic>{};
                        map['search'] = searchController.searchKeyboard.value;
                        map['latitude'] = pref.getString('latitude');
                        map['longitude'] = pref.getString('longitude');
                        map['categories'] = searchController.categories.value;
                        map['sort_by'] = searchController.sortBy.value;
                        map['rating'] =
                            (4 - controller.indexCustomerReview.value)
                                .toString();
                        map['nearby'] =
                            searchController.isNearBy.value.toString();

                        searchController.rating.value =
                            (4 - controller.indexCustomerReview.value)
                                .toString();
                        searchController.latitude.value =
                            pref.getString('latitude').toString();
                        searchController.longitude.value =
                            pref.getString('longitude').toString();
                        searchController.rating.value =
                            (4 - controller.indexCustomerReview.value)
                                .toString();

                        // print('REQUEST PARAMETER :: ' + (map.toString()));
                        searchController.getData(map);
                        // Get.offAllNamed(MyRouter.searchHostProduct, arguments: [
                        //   searchController.searchKeyboard.value.toString()
                        // ]);
                        Get.back();
                      },
                    ),
                    CommonButtonWhite(
                      buttonHeight: 6.5,
                      buttonWidth: 45,
                      mainGradient: AppTheme.primaryGradientColor,
                      text: 'Clear',
                      textColor: AppTheme.primaryColor,
                      onTap: () async {

                        final searchController = Get.put(VendorsController());
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.remove('latitude');
                        pref.remove('longitude');

                        controller.indexCustomerReview.value = 3;

                        controller.isNearBy.value = false;
                        searchController.getResetData();

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
      ),
    );
  }
}
