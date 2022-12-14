import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_application/features/authentication/data/repositories/auth_repositories.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      await AuthRepository.login(emailController.text, passwordController.text);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async => await AuthRepository.logout();

  Future<bool> anyToken() async => await AuthRepository.checkToken();
}
