import 'package:flutter/material.dart';
import 'package:test_application/model/employee_model.dart';

class DetailEmployeePage extends StatelessWidget {
  final Employee employee;
  const DetailEmployeePage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: employee.favorite!
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
              onPressed: () {}),
          IconButton(icon: const Icon(Icons.edit), onPressed: () {})
        ],
      ),
      // appBar: SliverAppBar(),
      body: Column(
        children: [
          sliver(context),
          ListTile(
              leading: const Icon(Icons.phone),
              title: Text(employee.number!),
              subtitle: const Text('Telephone'),
              trailing: const Icon(Icons.message)),
          ListTile(
              leading: const Icon(Icons.mail),
              title: Text(employee.email!),
              subtitle: const Text('E-mail')),
          ListTile(
              leading: const Icon(Icons.work),
              title: Text(employee.job!),
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
            ClipOval(child: Image.network(employee.avatar!)),
            const SizedBox(height: 25),
            Text(
              '${employee.firstName} ${employee.lastName}',
              style: const TextStyle(fontSize: 26, color: Colors.white),
            )
          ],
        ),
      );
}
