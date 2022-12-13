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
}
