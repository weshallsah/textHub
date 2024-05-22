import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  RxList chat = [].obs;
  late IO.Socket socket;
  RxBool ismenu = false.obs;
  TextEditingController message = TextEditingController();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    socket = await IO.io(
      "https://zk29l5cf-9000.inc1.devtunnels.ms/",
      // "http://10.0.2.2:9000/",
      <String, dynamic>{
        "autoConnect": true,
        'transports': ['websocket'],
      },
    );
    final res = await socket.connect();
    print("res :- ${socket}");
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
    socket.emit("joinchat", {"phone": 9511286245});
    socket.on("message", (data) {
      chat.value.insert(0, data);
      print(data);
      print(chat.value[0]);
      print(chat.length);
      chat.refresh();
    });
  }

  void send() {
    socket.emit("chat", {
      "phone": 9322297210,
      "message": message.text,
    });
    message.clear();
  }
}
