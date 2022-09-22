import 'dart:convert';
import 'dart:io';

import 'package:dinelah/controller/ProfileController.dart';
import 'package:dinelah/repositories/get_update_profile_field_repository.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final ProfileController _profileController = Get.put(ProfileController());
  bool isFirstNameValidate = false;
  bool isLastNameValidate = false;
  bool isEmailValidate = false;
  bool isMobileValidate = false;
  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userMobileController = TextEditingController();

  //late Future<ModelProfileFieldData> future;
  // File? cameraFile;

  @override
  void initState() {
    super.initState();
    _profileController.getData();
  }

  @override
  void dispose() {
    super.dispose();
    _profileController.firstNameController.clear();
    _profileController.emailController.clear();
    _profileController.phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      // decoration: const BoxDecoration(
      //   color: Color(0xfff3f3f3),
      //   image: DecorationImage(
      //     image: AssetImage(AppAssets.profileBgShape,),
      //     alignment: Alignment.topRight,
      //     fit: BoxFit.contain,
      //   ),
      // ),
      child: Scaffold(
        //appBar: backAppBarOrders('My profile'),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Obx(() {
            if (_profileController.isDataLoading.value &&
                _profileController.model.value.data != null) {
              _profileController.firstNameController.text =
                  _profileController.model.value.data!.firstName.toString();
              _profileController.lastNameController.text =
                  _profileController.model.value.data!.lastName.toString();
              _profileController.emailController.text =
                  _profileController.model.value.data!.email.toString();
              _profileController.phoneController.text =
                  _profileController.model.value.data!.phone.toString();
            }
            return _profileController.isDataLoading.value
                ? SizedBox(
                    width: screenSize.width,
                    child: _profileController.isDataLoading.value &&
                            _profileController.model.value.data != null
                        ? Column(
                            children: [
                              Stack(
                                children: [
                                  Material(
                                    borderRadius: BorderRadius.circular(50),
                                    elevation: 3,
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        child: _profileController.image == null
                                            ? _profileController.model.value
                                                    .data!.profileImage.isEmpty
                                                ? Image.asset(
                                                    'assets/images/app_icon.png')
                                                : Image.network(
                                                    _profileController
                                                        .model
                                                        .value
                                                        .data!
                                                        .profileImage,
                                                    fit: BoxFit.cover,
                                                  )
                                            : Image.file(
                                                _profileController.image!,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: () => pickImage(),
                                        child: const CircleAvatar(
                                            backgroundColor:
                                                AppTheme.primaryColor,
                                            radius: 12,
                                            child: Icon(
                                              Icons.edit,
                                              size: 14,
                                              color: AppTheme.colorWhite,
                                            )),
                                      ))
                                ],
                              ),
                              addHeight(8.0),
                              Text(
                                _profileController
                                            .model.value.data!.firstName ==
                                        null
                                    ? "Test Customer"
                                    : "${_profileController.model.value.data!.firstName} ${_profileController.model.value.data!.lastName}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              addHeight(4.0),
                              Text(
                                _profileController.model.value.data!.email,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              addHeight(42),
                              commonTextField(
                                true,
                                'First Name',
                                _profileController.firstNameController,
                                TextInputType.name,
                              ),
                              addHeight(12),
                              commonTextField(
                                true,
                                'Last Name',
                                _profileController.lastNameController,
                                TextInputType.name,
                              ),
                              addHeight(12),
                              commonTextField(
                                false,
                                'Email',
                                _profileController.emailController,
                                TextInputType.emailAddress,
                              ),
                              addHeight(14),
                              commonTextField(
                                true,
                                'Phone number',
                                _profileController.phoneController,
                                TextInputType.number,
                              ),
                              addHeight(36),
                              CommonButton(
                                  buttonHeight: 6.5,
                                  buttonWidth: 75,
                                  text: 'UPDATE',
                                  onTap: () {
                                    if (_profileController
                                        .firstNameController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "please fill your first name",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else if (_profileController
                                        .lastNameController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "please fill your last name",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                    /*else if(_profileController.emailController.text.isEmpty){Fluttertoast.showToast(
                              msg: "please enter your email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );}
                        else if(!RegExp(
                            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
                        ).hasMatch(_profileController.emailController.text)){
                          Fluttertoast.showToast(
                              msg: "please enter your valid email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }*/
                                    else if (_profileController
                                        .phoneController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "please enter your number",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else if (_profileController
                                            .phoneController.text.length !=
                                        10) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Mobile Number must be of 10 digit",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      var imageData = "";
                                      if (_profileController.image != null) {
                                        List<int> imageBytes = _profileController.image!.readAsBytesSync();
                                        String base64Image = base64Encode(imageBytes);
                                        imageData = base64Image;
                                      }

                                      getUpdateProfileFieldData(
                                        context,
                                        _profileController
                                            .firstNameController.text,
                                        _profileController
                                            .lastNameController.text,
                                        _profileController.emailController.text,
                                        _profileController.phoneController.text,
                                        imageData,
                                      ).then((value) {
                                        showToast(value.message);
                                        if (value.status == true) {
                                          _profileController.getData();
                                        }
                                        return null;
                                      });
                                    }
                                  },
                                  mainGradient: AppTheme.primaryGradientColor),
                              addHeight(28),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(MyRouter.changePassword);
                                },
                                child: const Text(
                                  'Change Password',
                                  style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),
                  )
                : loader(context);
          }),
        ),
      ),
    );
  }

  commonTextField(
    fieldActive,
    String hintText,
    TextEditingController controller,
    TextInputType inputType,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        enabled: fieldActive,
        controller: controller,
        obscureText: false,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);

      final bytes = File(image.path).readAsBytesSync();
      String base64Image = base64Encode(bytes);
      setState(() => _profileController.image = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pic image: $e');
    }
  }
}
