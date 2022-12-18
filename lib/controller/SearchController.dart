import 'package:dinelah/models/ModelAllAttributes.dart';
import 'package:dinelah/models/ModelSearchProduct.dart';
import 'package:dinelah/models/PopularProduct.dart';
import 'package:dinelah/repositories/get_search_product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  Rx<ModelSearchProduct> model = ModelSearchProduct().obs;
  Rx<ModelAllAttributes> modelAttribute = ModelAllAttributes().obs;
  var mListProducts = List<ModelProduct>.empty(growable: true).obs;
  RxBool isDataLoading = false.obs;
 final TextEditingController searchKeyboard = TextEditingController();
  RxString productType = ''.obs;
  RxString minPrice = ''.obs;
  RxString maxPrice = ''.obs;
  RxString rating = ''.obs;
  RxString sortBy = ''.obs;

  RxBool isSort = false.obs;

  // BuildContext? context;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.arguments != null) {
        searchKeyboard.text = Get.arguments[0].toString();
      }
      // controller.searchKeyboard.addListener(() {
      // });
      getData(
          searchKeyboard.text,
          productType.value,
          minPrice.value,
          maxPrice.value,
          rating.value,
          sortBy.value,
          modelAttribute.value);
      if (sortBy.value != '') {
        isSort.value = true;
      }
    });
  }

  void getMapData() {
    getData(searchKeyboard.text, productType.value, minPrice.value,
        maxPrice.value, rating.value, sortBy.value, modelAttribute.value);
  }

  void getData(searchKeyboard, productType, minPrice, maxPrice, rating, sortBy,
      modelAttribute) {
    isDataLoading.value = false;
    getSearchProductData(searchKeyboard, productType, minPrice,
            maxPrice, rating, sortBy, modelAttribute)
        .then((value) {
      isDataLoading.value = true;
      mListProducts.clear();
      mListProducts.addAll(value.data!.products);
      model.value = value;
    });
  }
}
