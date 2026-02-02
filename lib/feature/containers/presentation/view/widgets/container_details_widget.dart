import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/container_details_model.dart';
import 'package:flutter/material.dart';

class ContainerDetailsWidget extends StatelessWidget {
  final ContainerDetailsModel container;

  const ContainerDetailsWidget({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kIndent),
      child: Card(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              Trans.containerInformations.trans(),
              style: context.style20W400B,
            ),
            const SizedBox(height: 8),
            _MyWidget(
                title: Trans.shippingDate.trans(),
                value: container.shippingDate?.onlyDate ?? "",
                icon: null),
            _MyWidget(
                title: Trans.arrivalDate.trans(),
                value: container.arrivalDate?.onlyDate ?? "",
                icon: null),
            _MyWidget(
                title: Trans.containerStatus.trans(),
                value: container.containerStatus,
                icon: null),
            _MyWidget(
                title: Trans.containerTypeName.trans(),
                value: container.containerTypeName,
                icon: null),
            _MyWidget(
                title: Trans.number.trans(),
                value: container.number,
                icon: null),
            _MyWidget(
                title: Trans.awbNumber.trans(),
                value: container.awbNumber ?? "",
                icon: null),
            _MyWidget(
                title: Trans.line.trans(),
                value: container.line ?? "",
                icon: null),
            _MyWidget(
                title: Trans.faxNumber.trans(),
                value: container.faxNumber ?? "",
                icon: null),
            _MyWidget(
                title: Trans.originCountryName.trans(),
                value: container.originCountryName ?? "",
                icon: null),
            _MyWidget(
                title: Trans.destinationCountryName.trans(),
                value: container.destinationCountryName ?? "",
                icon: null),
            _MyWidget(
                title: Trans.note.trans(),
                value: container.destinationCountryName ?? "",
                icon: null),
            _MyWidget(
                title: Trans.description.trans(),
                value: container.description ?? "",
                icon: null),
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
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 18, color: Colors.grey.shade900),
          if (icon != null) const SizedBox(width: 6),
          SizedBox(
              // width: 80,
              child: Text("$title: ", style: context.style14W400B)),
          Text(value,
              style: context.style14W400B.copyWith(fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
