import 'package:dinelah/controller/ProfileController.dart';
import 'package:dinelah/models/ModelHomeData.dart';
import 'package:dinelah/repositories/get_home_data_repository.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:get/get.dart';

class GetHomeController extends GetxController {
  final ProfileController _profileController = Get.put(ProfileController());

  Rx<ModelHomeData> model = ModelHomeData().obs;
  RxBool isDataLoading = false.obs;

  final currentIndex = 0.obs;
  final currentIndex1 = 0.obs;

  final productQuantity = 1.obs;
  increment() {
    productQuantity.value++;
  }

  decrement() {
    if (productQuantity <= 1) {
      showToast("Minimum quantity must be 1");
    } else {
      productQuantity.value--;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getHomeData().then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });

    _profileController.getData();
  }

  getData() {
    getHomeData().then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }
}
