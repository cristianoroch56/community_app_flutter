// ignore_for_file: constant_identifier_names

import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  Future<bool> saveUserId(String? id) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.ID.toString(), id);
    return true;
  }

  Future<bool> saveUserName(String? name) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.NAME.toString(), name);
    return true;
  }

  saveLanguage(String? language) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.LANGUAGE.toString(), language);
  }

  String? getUserName() {
    final box = GetStorage();
    return box.read(CacheManagerKey.NAME.toString());
  }

  String? getLanguage() {
    final box = GetStorage();
    return box.read(CacheManagerKey.LANGUAGE.toString());
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  String? getUserId() {
    final box = GetStorage();
    return box.read(CacheManagerKey.ID.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.NAME.toString());
    await box.remove(CacheManagerKey.TOKEN.toString());
    await box.remove(CacheManagerKey.ID.toString());
  }
}

enum CacheManagerKey { TOKEN, ID, USER, NAME, LANGUAGE }
