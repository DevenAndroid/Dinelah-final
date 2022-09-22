import 'package:dinelah/utils/ApiConstant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CustomNavigationBarController extends GetxController {
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoggedIn.value = pref.getString('user') == null ? false : true;    // isLoggedIn.value = await isLogIn();
    //showToast(isLoggedIn.value.toString());
  }
}
