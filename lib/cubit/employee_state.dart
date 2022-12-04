part of 'employee_cubit.dart';

@immutable
abstract class EmployeeState {}

class EmployeeEmpty extends EmployeeState {}

class EmployeeLoginInProgress extends EmployeeState {}

class EmployeeLoginSuccess extends EmployeeState {
  final String token;

  EmployeeLoginSuccess({required this.token});
}

class EmployeeLoginFailure extends EmployeeState {
  final String error;

  EmployeeLoginFailure({required this.error});
}

class EmployeeFetchInProgress extends EmployeeState {}

class EmployeeFetchSuccess extends EmployeeState {
  final List<Employee> list;

  EmployeeFetchSuccess({required this.list});
}

class EmployeeCreateInProgress extends EmployeeState {}

class EmployeeCreateFailure extends EmployeeState {
  final String error;

  EmployeeCreateFailure({required this.error});
}

class EmployeeCreateSuccess extends EmployeeState {
  final String message;

  EmployeeCreateSuccess({required this.message});
}
