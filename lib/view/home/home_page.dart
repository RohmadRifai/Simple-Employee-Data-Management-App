import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/view/add_employee/add_employee_page.dart';
import 'package:test_application/view/detail_employee/detail_employee_page.dart';

import '../../cubit/employee_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void refresh() async => context.read<EmployeeCubit>().getListEmployee();

  @override
  void initState() {
    refresh();
    super.initState();
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

  Widget body() => BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeFetchSuccess) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailEmployeePage(employee: state.list[index]))),
                child: ListTile(
                  leading:
                      ClipOval(child: Image.network(state.list[index].avatar!)),
                  title: Text(
                      '${state.list[index].firstName} ${state.list[index].lastName}'),
                  subtitle: Text(state.list[index].job!),
                  trailing: InkWell(
                    child: state.list[index].favorite!
                        ? Icon(Icons.star,
                            color: Theme.of(context).primaryColor)
                        : const Icon(Icons.star_border),
                    onTap: () => context
                        .read<EmployeeCubit>()
                        .changeFavoriteEmployee(state.list, index),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
