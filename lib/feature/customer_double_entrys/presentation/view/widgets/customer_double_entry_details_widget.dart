import 'package:flutter/material.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entry_details_model.dart';

class CustomerDoubleEntryDetailsWidget extends StatefulWidget {
  final CustomerDoubleEntryDetailsModel customerDoubleEntry;

  const CustomerDoubleEntryDetailsWidget({super.key, required this.customerDoubleEntry});

  @override
  State<CustomerDoubleEntryDetailsWidget> createState() {
    return _CustomerDoubleEntryDetailsWidgetState();
  }
}

class _CustomerDoubleEntryDetailsWidgetState extends State<CustomerDoubleEntryDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("data");
  }
}
