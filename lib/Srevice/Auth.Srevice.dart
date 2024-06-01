import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:get/get.dart';
import 'package:texthub/Controller/splash.controller.dart';
import 'package:texthub/DB/controller/DB.controller.dart';
import 'package:texthub/DB/model/user.model.dart';

class AuthSrevice {
  Future<bool> islogin() async {
    return await APICacheManager().isAPICacheKeyExist("user");
  }

  Future<void> logout() async {
    await APICacheManager().deleteCache("user");
    Get.put(SplashController());
  }

  Future<void> setlogin(User user) async {
    print("user :- ${user.toMap()}");
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "user",
      syncData: jsonEncode(user.toMap()),
    );
    await APICacheManager().addCacheData(cacheDBModel);
    Get.put(SplashController());
    DBcontroller().Createdb();
  }

  Future<User?> getuser() async {
    final user = await APICacheManager().getCacheData('user');
    if (user.key.isNotEmpty) {
      final cachedata = jsonDecode(user.syncData);
      return User(
          uid: cachedata['uid'],
          phone: cachedata['phone'],
          name: cachedata['name'],
          email: cachedata['email'],
          avatar: cachedata['avatar']);
    }
  }
}
