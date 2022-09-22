import 'package:dinelah/controller/AddressController.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_text_field.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../repositories/update_user_meta_repository.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({Key? key}) : super(key: key);


  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final AddressController _addressController = Get.put(AddressController());

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_addressController.isDataLoading.value) {
      fnameController.text =
          _addressController.model.value.data!.shippingAddress.shippingFirstName
              .toString();
      lnameController.text =
          _addressController.model.value.data!.shippingAddress.shippingLastName
              .toString();
      address1.text =
          _addressController.model.value.data!.shippingAddress.shippingAddress_1
              .toString();
      address2.text =
          _addressController.model.value.data!.shippingAddress.shippingAddress_2
              .toString();
      postcodeController.text =
          _addressController.model.value.data!.shippingAddress.shippingPostcode
              .toString();
      cityController.text =
          _addressController.model.value.data!.shippingAddress.shippingCity
              .toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              hint: 'last name',
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
            addHeight(36),
            CommonButton(
                buttonHeight: 6.5,
                buttonWidth: 100,
                text: 'SAVE ADDRESS',
                onTap: (){
                  updateAddress(context,
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                    fnameController.text.toString(),
                    lnameController.text.toString(),
                    address1.text.toString(),
                    address2.text.toString(),
                    postcodeController.text.toString(),
                    cityController.text.toString(),
                  ).then((value) {
                        if(value.status){
                          Fluttertoast.showToast(
                              msg: value.message,  // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.BOTTOM,    // location// duration
                          );
                        }
                        return null;
                      });
                },
                mainGradient: AppTheme.primaryGradientColor)
          ],
        ),
      ),
    );
  }
}
