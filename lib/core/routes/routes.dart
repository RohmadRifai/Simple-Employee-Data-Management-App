import 'package:get/get.dart';
import 'package:test_application/features/authentication/presentation/pages/login_page.dart';
import 'package:test_application/features/authentication/presentation/pages/splash_page.dart';
import 'package:test_application/features/employee/presentation/pages/add_employee_page.dart';
import 'package:test_application/features/employee/presentation/pages/detail_employee_page.dart';
import 'package:test_application/features/employee/presentation/pages/home_page.dart';

final routes = [
  GetPage(name: SplashPage.routeName, page: () => const SplashPage()),
  GetPage(name: LoginPage.routeName, page: () => const LoginPage()),
  GetPage(name: HomePage.routeName, page: () => const HomePage()),
  GetPage(
      name: DetailEmployeePage.routeName,
      page: () => const DetailEmployeePage()),
  GetPage(name: AddEmployeePage.routeName, page: () => const AddEmployeePage()),
];
