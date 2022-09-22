import 'package:dinelah/models/ModelBookableProduct.dart';
import 'package:dinelah/repositories/bookable_end_date.dart';
import 'package:dinelah/repositories/get_Bookable_Product.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookableProductController extends GetxController {
  Rx<ModelBookableProductData> model = ModelBookableProductData().obs;
  RxBool isDataLoading = false.obs;
  RxBool isEndDataLoading = false.obs;
  RxString resourcesValue = ''.obs;
  BuildContext? context;

  var mListEndTime = List<String>.empty(growable: true);
  var resourcesList = List<String>.empty(growable: true);
  RxString dropdownEndTimeValue = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getBookableProducts(Get.arguments[0]).then((value) {
      isDataLoading.value = true;
      isEndDataLoading.value = true;

      if (value.data!.resourceList!.isNotEmpty) {
        resourcesValue.value = value.data!.resourceList![0].name!;
      }
      for (var item in value.data!.resourceList!) {
        resourcesList.add(item.name!);
      }
      model.value = value;
      return null;
    });
  }

  getBookableEndDateData(productId, dateYear, dateMonth, dateDay, dateTime) {
    isEndDataLoading.value = false;
    getBookableEndDate(
            context!, productId, dateYear, dateMonth, dateDay, dateTime)
        .then((value) {
      isEndDataLoading.value = true;
      if (value.status) {
        if (value.endTimeSlots.isEmpty) {
          showToast(
              'No slot found for selected time.\nPlease select another time');
        }
        for (var item in value.endTimeSlots) {
          if (!mListEndTime.contains(item.time)) {
            mListEndTime.add(item.time);
          }
          dropdownEndTimeValue.value = value.endTimeSlots[0].time;
        }
      }
      return null;
    });
  }
}
