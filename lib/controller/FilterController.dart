import 'package:dinelah/models/ModelAllAttributes.dart';
import 'package:dinelah/repositories/get_attribute_data_repository.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  Rx<ModelAllAttributes> model = ModelAllAttributes().obs;
  RxBool isDataLoading = false.obs;
  List<String> listServiceType = ['All', 'Simple', 'Bookable', 'Variable'];

  RxDouble startPriceValue = 0.0.obs;
  RxDouble endPriceValue = 500.0.obs;
  RxInt indexServiceType = 0.obs;
  RxInt indexCustomerReview = 4.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getData() {
    getAllAttributes().then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }
}
