import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:test_application/features/employee/data/models/employee_model.dart';
import 'package:test_application/features/employee/data/repositories/employee_repository.dart';

class EmployeeController extends GetxController {
  static EmployeeController get to => Get.find();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final jobController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final _list = <Employee>[].obs;

  List<Employee> get list => _list;

  Future<void> getListEmployee() async {
    try {
      final list = await EmployeeRepository.fetchListEmployee();
      _list.value = list;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addEmployee() async {
    try {
      final employee = await EmployeeRepository.createEmployee(Employee(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          job: jobController.text,
          number: numberController.text,
          email: emailController.text));
      _list.add(employee);
      clear();
    } catch (e) {
      rethrow;
    }
  }

  void clear() {
    firstNameController.clear();
    lastNameController.clear();
    jobController.clear();
    numberController.clear();
    emailController.clear();
  }

  @override
  void onInit() {
    getListEmployee();
    super.onInit();
  }

  @override
  void onClose() {
    Hive.close();
    clear();
    super.onClose();
  }
}
