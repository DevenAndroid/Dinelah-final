
import 'package:dinelah/models/ModelProfileFields.dart';
import 'package:dinelah/repositories/get_profile_field_repository.dart';
import 'package:get/get.dart';
class CommonDrawerController extends GetxController {
  Rx<ModelProfileFieldData> model = ModelProfileFieldData().obs;
  RxBool isDataloading = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileFieldData().then((value) {
      isDataloading.value = true;
      model.value= value;
      return null;
    });

  }
}