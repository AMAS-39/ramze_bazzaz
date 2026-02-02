import 'package:flutter/material.dart';
import 'package:app/feature/container_expenses/data/models/container_expense_details_model.dart';

class ContainerExpenseDetailsWidget extends StatefulWidget {
  final ContainerExpenseDetailsModel containerExpense;

  const ContainerExpenseDetailsWidget({super.key, required this.containerExpense});

  @override
  State<ContainerExpenseDetailsWidget> createState() {
    return _ContainerExpenseDetailsWidgetState();
  }
}

class _ContainerExpenseDetailsWidgetState extends State<ContainerExpenseDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("data");
  }
}
