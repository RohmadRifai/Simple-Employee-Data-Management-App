import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/cubit/employee_cubit.dart';
import 'package:test_application/view/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeLoginInProgress) {
          showDialog(
              context: context,
              builder: (_) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 7.5)));
        } else if (state is EmployeeLoginFailure) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                  title: const Text('Login Failed!'),
                  content: Text(state.error)));
        } else if (state is EmployeeLoginSuccess) {
          Navigator.of(context)
            ..pop()
            ..pushReplacement(
                MaterialPageRoute(builder: (_) => const HomePage()));
        }
      },
      child: GestureDetector(
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
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      labelText: 'Password',
                                      icon: Icon(Icons.lock)),
                                  obscureText: true,
                                ),
                                const SizedBox(height: 40),
                                ElevatedButton(
                                    child: const Text('LOGIN'),
                                    onPressed: () async {
                                      context.read<EmployeeCubit>().login(
                                          emailController.text,
                                          passwordController.text);
                                    })
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
      ),
    );
  }
}
