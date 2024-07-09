import 'package:get/get.dart';
import 'package:texthub/DB/controller/DB.controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Homecontroller extends GetxController {
  RxBool isavatar = false.obs;
  var avatar;
  late IO.Socket socket;
  RxList chatRooms = [].obs;

  Homecontroller(this.socket);
  @override
  void onInit() async {
    super.onInit();
    getdata();
  }

  void getdata() async {
    print("Loading data......");
    final res = await DBcontroller().fetchusers();
    if (res.length > chatRooms.length) {
      for (int i = chatRooms.length; i < res.length; i++) {
        print(res[i]);
        chatRooms.add(res[i]);
      }
    }
    await Future.delayed(Duration(milliseconds: 5000));
    getdata();
  }
}
