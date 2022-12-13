import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:test_application/features/employee/presentation/controllers/employee_controller.dart';
import 'package:test_application/features/employee/presentation/pages/add_employee_page.dart';
import 'package:test_application/features/employee/presentation/pages/detail_employee_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeController get = Get.find<EmployeeController>();

  void refresh() async => get.getListEmployee();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Employees'),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {})
          ]),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEmployeePage()));
          refresh();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget body() => GetBuilder<EmployeeController>(
      builder: (controller) => controller.list.isNotEmpty
          ? ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailEmployeePage(employee: controller.list[index]))),
                child: ListTile(
                    leading: ClipOval(
                        child: Image.network(controller.list[index].avatar!)),
                    title: Text(
                        '${controller.list[index].firstName} ${controller.list[index].lastName}'),
                    subtitle: Text(controller.list[index].job!)),
              ),
            )
          : const Center(child: CircularProgressIndicator()));
}
