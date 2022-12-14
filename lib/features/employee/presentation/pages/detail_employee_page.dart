import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_application/features/employee/data/models/employee_model.dart';

class DetailEmployeePage extends StatelessWidget {
  const DetailEmployeePage({Key? key}) : super(key: key);
  static const String routeName = '/detail_employee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Column(
        children: [
          sliver(context),
          ListTile(
              leading: const Icon(Icons.phone),
              title: Text(((Get.arguments as Employee).number!)),
              subtitle: const Text('Telephone'),
              trailing: const Icon(Icons.message)),
          ListTile(
              leading: const Icon(Icons.mail),
              title: Text((Get.arguments as Employee).email!),
              subtitle: const Text('E-mail')),
          ListTile(
              leading: const Icon(Icons.work),
              title: Text((Get.arguments as Employee).job!),
              subtitle: const Text('Job')),
        ],
      ),
    );
  }

  Widget sliver(BuildContext context) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .4,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
                child: (Get.arguments as Employee).avatar != null
                    ? Image.network((Get.arguments as Employee).avatar!)
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(20),
                        child: Icon(Icons.person,
                            size: 80, color: Theme.of(context).primaryColor))),
            const SizedBox(height: 25),
            Text(
              '${(Get.arguments as Employee).firstName} ${(Get.arguments as Employee).lastName}',
              style: const TextStyle(fontSize: 26, color: Colors.white),
            )
          ],
        ),
      );
}
