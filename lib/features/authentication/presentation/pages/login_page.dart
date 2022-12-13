import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_application/features/authentication/presentation/controllers/auth_controller.dart';

import '../../../employee/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController get = Get.put(AuthController());

  void login() async {
    try {
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Processing. . .',
          content: const Center(
            child: CircularProgressIndicator(strokeWidth: 7.5),
          ));
      await get.login(emailController.text, passwordController.text);
      if (!mounted) return;

      Navigator.of(context).pop();
      Get.to(const HomePage());
    } catch (e) {
      Navigator.of(context).pop();
      Get.defaultDialog(title: 'Login Failed!', content: Text(e.toString()));
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
                        child: Image.network("https://reqres.in/img/logo.png",
                            width: 150,
                            loadingBuilder: (_, child, loadingProgress) =>
                                loadingProgress == null
                                    ? child
                                    : const CircularProgressIndicator(
                                        color: Colors.white)),
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
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    labelText: 'E-mail',
                                    icon: Icon(Icons.mail)),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: passwordController,
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
