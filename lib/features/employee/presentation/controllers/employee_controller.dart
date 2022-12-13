import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_application/features/employee/data/models/employee_model.dart';

import '../../../../core/utils/constant.dart';

class EmployeeController extends GetxController {
  List<Employee> _list = <Employee>[];

  List<Employee> get list => _list;

  Future<void> getListEmployee() async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await Dio().get('$baseUrl/users');
        final json = response.data;
        final data = json['data'] as List;
        final list = data.map((e) => Employee.fromJson(e)).toList();
        _list = list;
        update();
      } on DioError catch (e) {
        throw Exception(e.response!.data['error']);
      }
    } else {
      throw Exception(connectionFailureMessage);
    }
  }

  Future<void> createEmployee(Employee employee) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final data = employee.toJson();
        await Dio().post('$baseUrl/users', data: data);
      } on DioError catch (e) {
        throw Exception(e.response!.data['error']);
      }
    } else {
      throw Exception(connectionFailureMessage);
    }
  }
}
