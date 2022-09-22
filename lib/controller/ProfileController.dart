import 'dart:convert';
import 'dart:io';

import 'package:dinelah/models/ModelLogIn.dart';
import 'package:dinelah/models/ModelProfileFields.dart';
import 'package:dinelah/repositories/get_profile_field_repository.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  Rx<ModelProfileFieldData> model = ModelProfileFieldData().obs;
  RxBool isDataLoading = false.obs;
  File? image;
  final ImagePicker picker = ImagePicker();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? fName;
  var index;
  RxBool isLoggedIn = false.obs;

  /*late RxString userName;

  initData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('user')!=null){
      ModelLogInData? user = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
        userName = user!.user!.username;
        *//*userEmail = user!.user!.email;
        userImage = user!.user!.url;
        print("<<<<<<<<<<< userName>>>>>>>>>>>"+userName.toString());
        print("<<<<<<<<<<<userEmail>>>>>>>>>>>"+userEmail.toString());
        print("<<<<<<<<<<<userImage>>>>>>>>>>>"+userImage.toString());*//*
    }

  }*/

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();




/*    firstNameController.text= model.value.data!.fields[0].value ;
    lastNameController.text= model.value.data!.fields[1].value ;
    emailController.text= model.value.data!.fields[2].value ;
    phoneController.text= model.value.data!.fields[3].value ;*/
  }
  getUser() async {
    isLoggedIn.value = await isLogIn();
    showToast(isLoggedIn.value.toString());
  }
    getData() {
      //SharedPreferences pref = await SharedPreferences.getInstance();
      getProfileFieldData().then((value) {
        isDataLoading.value = true;
        model.value = value;
       // pref.setString('user', jsonEncode(value.data));
        return null;
      });
    }

    /*sendData(){
    model.value.data!.fields.forEach((field) {

      if(field.name=='first_name'){
        print("<<<<>>>>>>>>><<<<<<<>>>>>>>>"+)
      }

    });
    }*/


}
