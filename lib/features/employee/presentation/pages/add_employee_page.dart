import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_application/features/employee/presentation/controllers/employee_controller.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({Key? key}) : super(key: key);
  static const String routeName = '/add_employee';

  void addEmployee() async {
    try {
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Processing. . .',
          content: const Center(
            child: CircularProgressIndicator(strokeWidth: 7.5),
          ));
      await EmployeeController.to.addEmployee();
      Get
        ..back()
        ..defaultDialog(
            title: 'Create Success!',
            content: const Text('Add data employee successful!'));
    } catch (e) {
      Get
        ..back()
        ..defaultDialog(
            title: 'Create Failed!',
            content: e.toString().isEmpty
                ? const Text('Add data employee failed!')
                : Text(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              EmployeeController.to.clear();
              Get.back();
            },
          ),
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
                controller: EmployeeController.to.firstNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'First Name', icon: Icon(Icons.person)),
              ),
              TextField(
                controller: EmployeeController.to.lastNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Last Name', icon: Icon(Icons.person)),
              ),
              TextField(
                controller: EmployeeController.to.jobController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Job', icon: Icon(Icons.work)),
              ),
              TextField(
                controller: EmployeeController.to.numberController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                maxLength: 16,
                decoration: const InputDecoration(
                    labelText: 'Telephone', icon: Icon(Icons.phone)),
              ),
              TextField(
                controller: EmployeeController.to.emailController,
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
