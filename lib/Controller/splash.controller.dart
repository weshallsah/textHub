import 'package:get/get.dart';
import 'package:texthub/Component/Loading.component.dart';
import 'package:texthub/Component/navbar.dart';
import 'package:texthub/Screen/Home_ui.dart';
import 'package:texthub/Screen/Splash_ui.dart';
import 'package:texthub/Srevice/Auth.Srevice.dart';

class SplashController extends GetxController {
  RxBool islogin = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    islogin.value = await AuthSrevice().islogin();
    if (islogin.value) {
      Get.offAll(() => Nav());
    } else {
      Get.offAll(() => Splash());
    }
  }
}
