import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_application/features/authentication/data/models/auth_model.dart';
import 'package:test_application/features/authentication/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AuthAdapter());
  await Hive.openBox<Auth>('token');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Data Management App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LoginPage(),
    );
  }
}
