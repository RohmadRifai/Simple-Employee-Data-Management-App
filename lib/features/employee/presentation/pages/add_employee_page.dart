import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_application/features/employee/data/models/employee_model.dart';
import 'package:test_application/features/employee/presentation/controllers/employee_controller.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final jobController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final EmployeeController get = Get.find<EmployeeController>();

  void addEmployee() async {
    try {
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Processing. . .',
          content: const Center(
            child: CircularProgressIndicator(strokeWidth: 7.5),
          ));
      get.createEmployee(Employee(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          job: jobController.text,
          number: numberController.text,
          email: emailController.text));
    } on Exception catch (e) {
      Navigator.of(context).pop();
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Create Failed!',
          content: Text(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Employee'),
          actions: [
            TextButton(
                onPressed: addEmployee,
                child:
                    const Text('SAVE', style: TextStyle(color: Colors.white)))
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          reverse: true,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
                child: const Icon(Icons.camera_alt, color: Colors.white),
              ),
              TextField(
                controller: firstNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'First Name', icon: Icon(Icons.person)),
              ),
              TextField(
                controller: lastNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Last Name', icon: Icon(Icons.person)),
              ),
              TextField(
                controller: jobController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Job', icon: Icon(Icons.work)),
              ),
              TextField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                maxLength: 16,
                decoration: const InputDecoration(
                    labelText: 'Telephone', icon: Icon(Icons.phone)),
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    labelText: 'E-mail', icon: Icon(Icons.person)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
