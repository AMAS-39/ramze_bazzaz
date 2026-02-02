import 'package:flutter/material.dart';
import 'package:app/feature/pay_insteads/data/models/pay_instead_details_model.dart';

class PayInsteadDetailsWidget extends StatefulWidget {
  final PayInsteadDetailsModel payInstead;

  const PayInsteadDetailsWidget({super.key, required this.payInstead});

  @override
  State<PayInsteadDetailsWidget> createState() {
    return _PayInsteadDetailsWidgetState();
  }
}

class _PayInsteadDetailsWidgetState extends State<PayInsteadDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("data");
  }
}
