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
    SplashController().onInit();
  }

  Future<void> setdbinfo(final dbinfo) async {
    print("set DB info :- ${dbinfo}");
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "dbinfo",
      syncData: jsonEncode(dbinfo),
    );
    await APICacheManager().addCacheData(cacheDBModel);
  }

  Future<void> setlogin(User user) async {
    print("user :- ${user.toMap()}");
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "user",
      syncData: jsonEncode(user.toMap()),
    );
    await APICacheManager().addCacheData(cacheDBModel);
    SplashController().onInit();
    DBcontroller().Createdb();
  }

  Future<User?> getuser() async {
    final user = await APICacheManager().getCacheData('user');
    if (user.key.isNotEmpty) {
      final cachedata = jsonDecode(user.syncData);
      return User(
          phone: cachedata['phone'],
          name: cachedata['name'],
          avatar: cachedata['avatar']);
    }
  }
}
