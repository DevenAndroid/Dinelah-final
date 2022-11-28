import 'package:dinelah/models/ModelVendorStore.dart';
import 'package:dinelah/repositories/get_vendor_stores_repository.dart';
import 'package:get/get.dart';

class VendorsController extends GetxController {
  Rx<ModelVendorStores> model = ModelVendorStores().obs;
  RxBool isDataLoading = false.obs;
  RxString searchKeyboard = ''.obs;
  // BuildContext? context;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxString categories = ''.obs;
  RxString sortBy = ''.obs;
  RxString rating = ''.obs;
  RxBool isNearBy = false.obs;

  RxInt indexCustomerReview = 3.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      searchKeyboard.value = Get.arguments[0];
    }
    getDataMap();
  }

  Future<void> getDataMap() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    var map = <String, dynamic>{};
    map['search'] = searchKeyboard.value;
    map['latitude'] = latitude.value;
    map['longitude'] = longitude.value;
    map['categories'] = categories.value;
    map['sort_by'] = sortBy.value;
    map['rating'] = rating.value;
    map['nearby'] = isNearBy.value == false ? '' : true;

    getData(map);
  }

  getResetData() async {
    var map = <String, dynamic>{};
    map['search'] = '';
    map['latitude'] = '';
    map['longitude'] = '';
    map['categories'] = '';
    map['sort_by'] = '';
    map['rating'] = '';
    map['nearby'] = '';

    isDataLoading.value = false;
    getVendorStores(map).then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }

  getData(map) async {
    isDataLoading.value = false;
    getVendorStores(map).then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }
}
