import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_application/features/authentication/data/models/auth_model.dart';

import '../../../../core/utils/constant.dart';
import '../sources/auth_local_data_source.dart';

class AuthRepository {
  static Future<void> login(String email, String password) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final data = {"email": email, "password": password};
        final response = await Dio().post('$baseUrl/login', data: data);
        final token = Auth()..token = response.data['token'];

        await AuthLocalDataSource.instance.cacheToken(token);
      } on DioError catch (e) {
        throw e.response!.data['error'];
      }
    } else {
      throw connectionFailureMessage;
    }
  }

  static Future<void> logout() async =>
      await AuthLocalDataSource.instance.deleteToken();

  static Future<bool> checkToken() async =>
      await AuthLocalDataSource.instance.getLastToken();
}
