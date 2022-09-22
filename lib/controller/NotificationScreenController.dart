
import 'package:dinelah/models/ModelNotification.dart';
import 'package:dinelah/repositories/get_Notification_repository.dart';
import 'package:get/get.dart';

class NotificationScreenController extends GetxController {
  Rx<ModelNotificationData> model = ModelNotificationData().obs;
  RxBool isDataLoad = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    getNotificationData().then((value) async {
      print('RESPONSE DATA 11:: ' + value.toString());
      isDataLoad.value = true;

      return model.value = value;
    });
  }
}
