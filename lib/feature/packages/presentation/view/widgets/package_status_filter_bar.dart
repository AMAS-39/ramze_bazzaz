import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:flutter/material.dart';

class PackageStatusFilterBar extends StatelessWidget {
  const PackageStatusFilterBar({
    super.key,
    required this.selected,
    required this.onChanged,
    this.padding,
  });

  final PackageStatusFilter selected;
  final ValueChanged<PackageStatusFilter> onChanged;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: PackageStatusFilter.values.map((filter) {
          final bool isSelected = filter == selected;
          return InkWell(
            onTap: () => onChanged(filter),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.primaryColor
                    : (appConfig.app == App.rbb ? context.cardColor : null),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? context.primaryColor
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                filter.label(context),
                style: context.style12W500B.copyWith(
                    color: isSelected
                        ? Colors.white
                        : (context.style12W500B.color ?? Colors.black)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
