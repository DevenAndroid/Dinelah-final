import 'package:dinelah/models/ModelAddress.dart';
import 'package:dinelah/repositories/get_address_repository.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  Rx<ModelGetAddresss> model = ModelGetAddresss().obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAddressData().then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }
}
