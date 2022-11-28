import 'package:dinelah/controller/AddressController.dart';
import 'package:dinelah/repositories/update_user_meta_repository.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_text_field.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BillingAddress extends StatefulWidget {
  const BillingAddress({Key? key}) : super(key: key);


  @override
  State<BillingAddress> createState() => _BillingAddressState();
}

class _BillingAddressState extends State<BillingAddress> {

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _addressController = Get.put(AddressController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
        Obx(() {
          if (_addressController.isDataLoading.value) {
            fnameController.text =
                _addressController.model.value.data!.billingAddress.billingFirstName
                    .toString();
            lnameController.text =
                _addressController.model.value.data!.billingAddress.billingLastName
                    .toString();
            countryController.text =
                _addressController.model.value.data!.billingAddress.billingCountry
                    .toString();
            address1.text =
                _addressController.model.value.data!.billingAddress.billingAddress_1
                    .toString();
            address2.text =
                _addressController.model.value.data!.billingAddress.billingAddress_2
                    .toString();

            postcodeController.text =
                _addressController.model.value.data!.billingAddress.billingPostcode
                    .toString();
            cityController.text =
                _addressController.model.value.data!.billingAddress.billingCity
                    .toString();
            phoneController.text =
                _addressController.model.value.data!.billingAddress.billingPhone
                    .toString();
            emailController.text =
                _addressController.model.value.data!.billingAddress.billingEmail
                    .toString();
          }
          return _addressController.isDataLoading.value
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('First name'),
              addHeight(8),
              CommonTextFieldWidget(
                icon: Icons.person,
                hint: 'First name',
                controller: fnameController,
                bgColor: AppTheme.colorEditFieldBg,),
              addHeight(12),
              const Text('Last name'),
              addHeight(8),
              CommonTextFieldWidget(
                icon: Icons.person,
                hint: 'Last name',
                controller: lnameController,
                bgColor: AppTheme.colorEditFieldBg,),
              addHeight(12),
              const Text('Address 1'),
              addHeight(8),
              CommonTextFieldWidget(
                icon: Icons.home_outlined,
                hint: 'Street address',
                controller: address1,
                bgColor: AppTheme.colorEditFieldBg,),
              addHeight(12),
              const Text('Address 2'),
              addHeight(8),
              CommonTextFieldWidget(
                icon: Icons.home_outlined,
                hint: 'Street Optional',
                controller: address2,
                bgColor: AppTheme.colorEditFieldBg,),
              addHeight(12),
              const Text('Postcode/ zip'),
              addHeight(8),
              CommonTextFieldWidget(
                icon: Icons.home_outlined,
                hint: 'Postcode',
                controller: postcodeController,
                bgColor: AppTheme.colorEditFieldBg,),
              addHeight(12),
              const Text('Town/ City'),
              addHeight(8),
              CommonTextFieldWidget(
                icon: Icons.location_city_sharp,
                hint: 'City/town',
                controller: cityController,
                bgColor: AppTheme.colorEditFieldBg,),
              addHeight(12),
              const Text('Phone'),
              addHeight(8),
              CommonTextFieldWidget(
                icon: Icons.phone_android_sharp,
                hint: 'Phone',
                controller: phoneController,
                bgColor: AppTheme.colorEditFieldBg,),
              addHeight(12),
              const Text('Email'),
              addHeight(8),
              CommonTextFieldWidget(
                icon: Icons.mail_outlined,
                hint: 'Email address',
                controller: emailController,
                bgColor: AppTheme.colorEditFieldBg,),
              addHeight(36),
              CommonButton(
                  buttonHeight: 6.5,
                  buttonWidth: 100,
                  text: 'SAVE ADDRESS',
                  onTap: () {
                    updateAddress(
                      context,
                      fnameController.text.toString(),
                      lnameController.text.toString(),
                      address1.text.toString(),
                      address2.text.toString(),
                      postcodeController.text.toString(),
                      cityController.text.toString(),
                      phoneController.text.toString(),
                      emailController.text.toString(),
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                    ).then((value) {
                      if (value.status) {
                        Fluttertoast.showToast(
                          msg: value.message, // message
                          toastLength: Toast.LENGTH_SHORT, // length
                          gravity: ToastGravity.BOTTOM, // location// duration
                        );
                      }
                      return null;
                    });
                  },
                  mainGradient: AppTheme.primaryGradientColor)
            ],
          )
              : const Center(child: CircularProgressIndicator(color: AppTheme.newprimaryColor));
        }),
      ),
    );
  }
}
