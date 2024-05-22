import 'package:get/get.dart';
import 'package:texthub/Srevice/Auth.Srevice.dart';

class SplashController extends GetxController {
  RxBool islogin = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print(await AuthSrevice().islogin());
    // print(await AuthSrevice().getuser());
    islogin.value = await AuthSrevice().islogin();
  }
}
