import 'package:hive/hive.dart';
import 'package:test_application/core/utils/constant.dart';
import 'package:test_application/features/authentication/data/models/auth_model.dart';

class AuthLocalDataSource {
  static final AuthLocalDataSource instance = AuthLocalDataSource._init();
  static Box? _box;

  AuthLocalDataSource._init();

  Future<Box> get box async {
    if (_box != null) return _box!;

    _box = Hive.box('token');
    return _box!;
  }

  Future<void> cacheToken(String token) async {
    final box = await instance.box;
    box.put(cachedToken, token);
  }

  Future<String> getLastToken() async {
    final box = await instance.box;
    final token = box.get(cachedToken);
    if (token != null) {
      return Future.value(token);
    } else {
      throw Exception(cacheTokenFailureMessage);
    }
  }

  Future<void> deleteToken() async {
    final box = await instance.box;
    box.delete(cachedToken);
  }
}
