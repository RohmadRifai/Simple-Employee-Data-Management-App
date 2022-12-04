import 'dart:convert';

import 'package:http/http.dart' as http;

class Employee {
  final int? id;
  final String firstName;
  final String lastName;
  final String? job;
  final String? number;
  final String? email;
  final String? avatar;
  bool? favorite;

  Employee(
      {this.id,
      required this.firstName,
      required this.lastName,
      this.job,
      this.number,
      this.email,
      this.avatar,
      this.favorite});

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      job: json['job'] ?? 'Unemployment',
      number: json['number'] ?? '(999) 99999-9999',
      email: json['email'],
      avatar: json['avatar'],
      favorite: json['favorite'] ?? false);

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'job': job,
        'number': number,
        'email': email
      };

  static const String url = 'https://reqres.in/api';

  static Future<String> login(String email, String password) async {
    final body = {"email": email, "password": password};
    final response = await http.post(Uri.parse('$url/login'), body: body);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return json['token'];
    } else {
      return json['error'];
    }
  }

  static Future<List<Employee>> getListEmployee() async {
    final response = await http.get(Uri.parse('$url/users'));
    final json = jsonDecode(response.body);
    final data = json['data'] as List;
    final list = data.map((e) => Employee.fromJson(e)).toList();

    return list;
  }

  static Future<bool> createEmployee(Employee employee) async {
    final body = employee.toJson();
    final response = await http.post(Uri.parse('$url/users'), body: body);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
