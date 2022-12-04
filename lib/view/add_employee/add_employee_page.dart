import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/cubit/employee_cubit.dart';
import 'package:test_application/model/employee_model.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final jobController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeCubit, EmployeeState>(
      listener: (context, state) async {
        if (state is EmployeeCreateInProgress) {
          showDialog(
              context: context,
              builder: (_) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 7.5)));
        } else if (state is EmployeeCreateFailure) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                  title: const Text('Create Failed!'),
                  content: Text(state.error)));
        } else if (state is EmployeeCreateSuccess) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                  title: const Text('Create Success!'),
                  content: Text(state.message)));
          await Future.delayed(const Duration(seconds: 2));
          if (!mounted) {
            return;
          }
          Navigator.of(context)
            ..pop()
            ..pop();
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Employee'),
            actions: [
              TextButton(
                  child:
                      const Text('SAVE', style: TextStyle(color: Colors.white)),
                  onPressed: () => context.read<EmployeeCubit>().addEmployee(
                      Employee(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          job: jobController.text,
                          number: numberController.text,
                          email: emailController.text)))
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
      ),
    );
  }
}
