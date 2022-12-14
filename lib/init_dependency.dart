import 'package:get/get.dart';
import 'package:test_application/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:test_application/features/employee/presentation/controllers/employee_controller.dart';

class InitDependency extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<EmployeeController>(() => EmployeeController());
  }
}
