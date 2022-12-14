import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  void login() async {
    try {
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Processing. . .',
          content: const Center(
            child: CircularProgressIndicator(strokeWidth: 7.5),
          ));
      await AuthController.to.login();
      Get
        ..back()
        ..offNamed('/home');
    } catch (e) {
      Get
        ..back()
        ..defaultDialog(title: 'Login Failed!', content: Text(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset('assets/logo/logo.png', width: 150),
                      ),
                    ),
                    Expanded(
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextField(
                                controller: AuthController.to.emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    labelText: 'E-mail',
                                    icon: Icon(Icons.mail)),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller:
                                    AuthController.to.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                    labelText: 'Password',
                                    icon: Icon(Icons.lock)),
                                obscureText: true,
                              ),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                  onPressed: login, child: const Text('LOGIN'))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
