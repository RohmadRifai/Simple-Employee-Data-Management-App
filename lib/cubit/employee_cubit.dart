import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/model/employee_model.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeEmpty());

  void login(String email, String password) async {
    emit(EmployeeLoginInProgress());
    final result = await Employee.login(email, password);

    if (result.contains('Missing')) {
      emit(EmployeeLoginFailure(error: result));
    } else {
      emit(EmployeeLoginSuccess(token: result));
    }
  }

  void getListEmployee() async {
    emit(EmployeeFetchInProgress());
    final result = await Employee.getListEmployee();
    emit(EmployeeFetchSuccess(list: result));
  }

  void addEmployee(Employee employee) async {
    emit(EmployeeCreateInProgress());
    final result = await Employee.createEmployee(employee);

    if (result) {
      emit(EmployeeCreateSuccess(message: "Add data employee successful!"));
    } else {
      emit(EmployeeCreateFailure(error: "Add data employee failed!"));
    }
  }

  void changeFavoriteEmployee(List<Employee> list, int index) {
    list[index].favorite = !list[index].favorite!;
    emit(EmployeeFetchSuccess(list: list));
  }
}
