import 'package:dinelah/models/ModelMyBookings.dart';
import 'package:dinelah/models/MyBookings.dart';
import 'package:dinelah/repositories/get_my_bookings_repository.dart';
import 'package:get/get.dart';

class MyBookingsController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<ModelMyBookingsNew> model = ModelMyBookingsNew().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    getMyBookings().then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }
}
