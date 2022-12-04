import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/cubit/employee_cubit.dart';
import 'package:test_application/view/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
