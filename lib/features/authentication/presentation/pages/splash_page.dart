import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_application/features/authentication/presentation/controllers/auth_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 2),
        () async => await AuthController.to.anyToken()
            ? Get.offNamed('/home')
            : Get.offNamed('/login'));
    return Material(
      color: Theme.of(context).primaryColor,
      child: Center(child: Image.asset('assets/logo/logo.png', width: 250)),
    );
  }
}
