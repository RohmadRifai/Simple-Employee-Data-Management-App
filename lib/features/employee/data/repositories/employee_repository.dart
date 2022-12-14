import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/utils/constant.dart';
import '../models/employee_model.dart';

class EmployeeRepository {
  static Future<List<Employee>> fetchListEmployee() async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await Dio().get('$baseUrl/users');
        final json = response.data;
        final data = json['data'] as List;
        final list = data.map((e) => Employee.fromJson(e)).toList();
        return list;
      } on DioError catch (e) {
        throw e.response!.data['error'];
      }
    } else {
      throw connectionFailureMessage;
    }
  }

  static Future<Employee> createEmployee(Employee employee) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final data = employee.toJson();
        await Dio().post('$baseUrl/users', data: data);
        return employee;
      } on DioError catch (e) {
        throw e.response!.data['error'];
      }
    } else {
      throw connectionFailureMessage;
    }
  }
}
