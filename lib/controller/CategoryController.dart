import 'package:dinelah/models/ModelCategoryData.dart';
import 'package:dinelah/models/ModelCategoryProducts.dart';
import 'package:dinelah/repositories/get_category_products.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:get/get.dart';

import '../repositories/category_repository.dart';

class CategoryController extends GetxController {
  Rx<ModelCategoryData> catModel = ModelCategoryData().obs;
  Rx<ModelCategoryProductData> model = ModelCategoryProductData().obs;

  RxBool isDataLoading = false.obs;
  RxBool isCategorySelected = false.obs;

  String categoryId = "";

  final currentIndex = 0.obs;
  final currentIndex1 = 0.obs;


  int perPage = 10;
  int pageCount = 1;
  bool loadingPagination = false;
  RxBool allLoaded = false.obs;
  String storeId = "";


  Future<dynamic> getMoreProducts(context) async {
    if(!allLoaded.value) {
      if (loadingPagination == false) {
        loadingPagination = true;
        await getCategoryProductData(
            categoryId,
            perPage: perPage,
            pageCount: pageCount,
            context: context).then((value1) {
          loadingPagination = false;
          if (value1.data!.products.isNotEmpty) {
            model.value.data!.products.addAll(value1.data!.products);
            return pageCount++;
          }
          else {
            return allLoaded.value = true;
          }
        });
      }
    }
  }

  final productQuantity = 1.obs;
  increment() {
    productQuantity.value++;
  }

  decrement() {
    if (productQuantity <= 1) {
      showToast("Minimum quantity must be 1");
    } else {
      productQuantity.value--;
    }
  }

  void getProduct() {
    isDataLoading.value = false;
    pageCount = 1;
    allLoaded.value = false;
    loadingPagination = false;
    getCategoryProductData(categoryId,perPage: perPage,pageCount: pageCount).then((value) {
      isDataLoading.value = true;
      model.value = value;
      if(value.data!.products.isNotEmpty){
        pageCount++;
      }
    });
  }

  // void getCategory() {
  //   getCategoryData().then((value) {
  //     isDataLoading.value = true;
  //     catModel.value = value;
  //     return null;
  //   });
  // }
}
