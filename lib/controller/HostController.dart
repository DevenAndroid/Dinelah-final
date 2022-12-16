import 'package:dinelah/models/ModelVendorStore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../models/ModelStoreInfo.dart';
import '../repositories/get_store_info_repository.dart';

class HostController extends GetxController {
  Rx<ModelStoreInfoData> model= ModelStoreInfoData().obs;
  RxBool isDataLoading = false.obs;
  var id;
  final currentIndex = 0.obs;
  final currentIndex1 = 0.obs;
  final productQuantity = 1.obs;
  increment() {
    productQuantity.value++;
  }

  decrement() {
    if(productQuantity<=1){
      Fluttertoast.showToast(
          msg: "Minimum quantity must be 1",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      productQuantity.value--;
    }
  }

  int perPage = 10;
  int pageCount = 1;
  bool loadingPagination = false;
  RxBool allLoaded = false.obs;
  String storeId = "";

  @override
  void onInit() {
    super.onInit();
    ModelStores store = Get.arguments[0];
    storeId = store.id.toString();
    getStoreInfo(
        storeId,
      pageCount: pageCount,
      perPage: perPage
    ).then((value) {
      isDataLoading.value = true;
      model.value = value;
      if(model.value.data!.storeProducts.isNotEmpty) {
        pageCount++;
      }
    });
  }
 Future<dynamic> getHostData(context) async {
    if(!allLoaded.value) {
      if (loadingPagination == false) {
        loadingPagination = true;
       await getStoreInfo(
           storeId,
           perPage: perPage,
           pageCount: pageCount,
           context: context
       ).then((value1) {
          loadingPagination = false;
          if (value1.data!.storeProducts.isNotEmpty) {
            model.value.data!.storeProducts.addAll(value1.data!.storeProducts);
           return pageCount++;
          }
          else {
           return allLoaded.value = true;
          }
        });
      }
    }
  }
}