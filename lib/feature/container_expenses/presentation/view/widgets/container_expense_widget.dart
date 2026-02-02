import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:flutter/material.dart';

class ContainerExpenseWidget extends StatelessWidget {
  final ContainerExpenseModel containerExpense;
  const ContainerExpenseWidget({
    super.key,
    required this.containerExpense,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: containerExpense.container.containerStatus ==
                        ContainerStatus.Arrived ||
                    containerExpense.container.arrivalDate != null
                ? Colors.red
                : context.cardColor,
            borderRadius: BorderRadius.circular(BORDER_RADUIS)),
        padding: const EdgeInsets.all(kIndent),
        child: Column(
          children: [
            _MyWidget(
              icon: null,
              title: Trans.price.trans(),
              value: containerExpense.price.formatUSD,
            ),
            _MyWidget(
              icon: null,
              title: Trans.container.trans(),
              value: (containerExpense.container.number.toString()),
            ),
            _MyWidget(
              icon: null,
              title: Trans.shippingDate.trans(),
              value: containerExpense.container.shippingDate?.onlyDate ?? "",
            ),
            _MyWidget(
              icon: null,
              title: Trans.arrivalDate.trans(),
              value: containerExpense.container.arrivalDate?.onlyDate ?? "",
            ),
            if (!checkIsNull(containerExpense.description)) ...[
              _MyWidget(
                icon: null,
                title: Trans.description.trans(),
                value: containerExpense.description ?? "",
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class _MyWidget extends StatelessWidget {
  const _MyWidget(
      {required this.title, required this.value, required this.icon});
  final String title;
  final String value;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 18, color: Colors.grey.shade900),
          if (icon != null) const SizedBox(width: 6),
          SizedBox(
              // width: 80,
              child: Text("$title: ", style: context.style14W400B)),
          Flexible(
            child: Text(value,
                style: context.style14W400B.copyWith(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
