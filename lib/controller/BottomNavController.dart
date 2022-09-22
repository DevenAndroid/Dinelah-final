import 'package:dinelah/models/ModelCartQuantity.dart';
import 'package:dinelah/repositories/getCartCount.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt cartBadgeCount = 0.obs;

  Rx<ModelCartQuantity> model = Get.put(ModelCartQuantity()).obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() {
    getCartCount().then((value) {
      cartBadgeCount.value = value.quantity;
      return null;
    });
  }
}
