import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:flutter/material.dart';

class PayReturnWidget extends StatelessWidget {
  final PayInsteadModel payInstead;
  const PayReturnWidget({
    super.key,
    required this.payInstead,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onLongPress: () {
      //   showOptionBottomSheet(options: [
      //     Options.View,
      //     Options.Edit,
      //     Options.Delete,
      //   ]).then((value) async {
      //     if (value == Options.View) {
      //       context.to(PayInsteadDetailsScreen(
      //           id: payInstead.id, name: payInstead.name));
      //     } else if (value == Options.Edit) {
      //       context.to(CreateUpdatePayInsteadScreen(payInstead: payInstead));
      //     } else if (value == Options.Delete) {
      //       final res = await getUserConfirm(
      //           desc: Trans.areYouSureYouWantToDeleteSelectedItem.trans());
      //       if (res == true) {
      //         sl<PayInsteadsBloc>().add(PayInsteadDeleteEvent(payInstead));
      //       }
      //     }
      //   });
      // },
      // onTap: () {
      //   context.to(PayInsteadDetailsScreen(
      //       id: payInstead.id, name: payInstead.accountant));
      // },
      child: Container(
        padding: const EdgeInsets.all(kIndent),
        decoration: BoxDecoration(
            color: appConfig.app == App.rbb ? context.cardColor : null,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _MyWidget(
              title: Trans.invoiceNumber.trans(),
              value: payInstead.invoiceNumber ?? "",
              icon: null,
            ),
            _MyWidget(
              title: Trans.title.trans(),
              value: payInstead.title ?? "",
              icon: null,
            ),
            _MyWidget(
                title: Trans.totalPrice.trans(),
                value: payInstead.totalPrice.formatUSD,
                icon: null),
            _MyWidget(
                title: Trans.safebox.trans(),
                value: payInstead.safeboxName ?? "",
                icon: null),
            _MyWidget(
                title: Trans.date.trans(),
                value: payInstead.date.onlyDate,
                icon: null),
            if (!checkIsNull(payInstead.description))
              _MyWidget(
                  title: Trans.description.trans(),
                  value: payInstead.description ?? "",
                  icon: null)
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
      padding: const EdgeInsets.only(bottom: 4),
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
