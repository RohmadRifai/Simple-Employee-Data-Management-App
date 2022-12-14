import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hive/hive.dart';

import '../../../authentication/presentation/controllers/auth_controller.dart';
import '../controllers/employee_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     EmployeeController.to.getListEmployee();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     Hive.close();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Employees'),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await AuthController.to.logout();
                  Get.offNamed('/login');
                })
          ]),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add_employee'),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Widget body() => GetBuilder<EmployeeController>(
  //     initState: (_) => EmployeeController.to.getListEmployee(),
  //     dispose: (_) => Hive.close(),
  //     builder: (controller) => controller.list.isNotEmpty
  //         ? ListView.builder(
  //             itemCount: controller.list.length,
  //             itemBuilder: (context, index) => InkWell(
  //               onTap: () =>
  //                   Get.toNamed('/detail', arguments: controller.list[index]),
  //               child: ListTile(
  //                   leading: ClipOval(
  //                       child: Image.network(controller.list[index].avatar!)),
  //                   title: Text(
  //                       '${controller.list[index].firstName} ${controller.list[index].lastName}'),
  //                   subtitle: Text(controller.list[index].job!)),
  //             ),
  //           )
  //         : const Center(child: CircularProgressIndicator()));

  Widget body() => Obx(() => EmployeeController.to.list.isNotEmpty
      ? ListView.builder(
          itemCount: EmployeeController.to.list.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Get.toNamed('/detail_employee',
                arguments: EmployeeController.to.list[index]),
            child: ListTile(
                leading: ClipOval(
                    child: EmployeeController.to.list[index].avatar != null
                        ? Image.network(
                            EmployeeController.to.list[index].avatar!)
                        : Container(
                            color: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.all(10),
                            child: const Icon(Icons.person,
                                size: 37, color: Colors.white))),
                title: Text(
                    '${EmployeeController.to.list[index].firstName} ${EmployeeController.to.list[index].lastName}'),
                subtitle: Text(EmployeeController.to.list[index].job!)),
          ),
        )
      : const Center(child: CircularProgressIndicator()));
}
