import 'package:dinelah/models/ModelAttributeData.dart';
import 'package:dinelah/models/ModelHomeData.dart';
import 'package:dinelah/repositories/get_attribute_data_repository.dart';
import 'package:dinelah/repositories/get_home_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../models/ModelSingleProduct.dart';
import '../repositories/get_single_product.dart';
class SingleProductController extends GetxController {
  Rx<ModelSingleProductData> model= ModelSingleProductData().obs;
  //Rx<ModelGetAttributeData> modelGetAttribute= ModelGetAttributeData().obs;
  RxBool isDataLoading = false.obs;
  var productId;
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


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    productId = Get.arguments[0];
    getSingleProductData(productId).then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }
  getData(){
    getSingleProductData(productId).then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }
}