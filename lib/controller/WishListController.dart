import 'package:dinelah/models/ModelWishlist.dart';
import 'package:dinelah/repositories/get_wishlist_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
class WishListController extends GetxController{
  Rx<ModelWishListData> model= ModelWishListData().obs;
  RxBool isDataLoading = false.obs;


  final currentIndex = 0.obs;
  final currentIndex1 = 0.obs;

  final productQuantity = 1.obs;
  increment() {
    productQuantity.value++;
  }
  decrement() {
    print("lokesh decrement" + productQuantity.toString());
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
    }else{
      productQuantity.value--;
    }

  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getYourWishList();
  }

   getYourWishList() async{
     getWishlistData().then((value) {
       isDataLoading.value = true;
       model.value = value;
       return null;
     });
   }

}