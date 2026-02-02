import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/lanucher.dart';
import 'package:app/feature/payments/data/models/payment_details_model.dart';
import 'package:flutter/material.dart';

class PaymentDetailsWidget extends StatelessWidget {
  final PaymentDetailsModel payment;

  const PaymentDetailsWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _MyWidget(
          // icon: Icons.wallet,
          title: Trans.amount.trans(),
          value: (payment.byMain
              ? payment.price.formatUSD
              : payment.scPrice.formatIQD),
        ),
        _MyWidget(
          // icon: Icons.wallet,
          title: Trans.amount.trans(),
          value: payment.priceText,
        ),
        _MyWidget(
          // icon: Icons.wallet_giftcard_outlined,
          title: Trans.forgivePrice.trans(),
          value: (payment.byMain
              ? payment.forgivePrice.formatUSD
              : payment.scForgivePrice.formatIQD),
        ),
        _MyWidget(
          // icon: Icons.date_range_rounded,
          title: Trans.date.trans(),
          value: payment.date.onlyDate,
        ),
        _MyWidget(
          // icon: Icons.person_2_sharp,
          title: Trans.paidBy.trans(),
          value: payment.paidBy,
        ),
        _MyWidget(
          title: Trans.accountant.trans(),
          value: payment.accountant,
        ),
        _MyWidget(
          title: Trans.note.trans(),
          value: payment.note ?? "",
        ),
        _MyWidget(
          title: Trans.invoiceNumber.trans(),
          value: payment.invoiceNumber,
        ),
        if (payment.attachment != null)
          InkWell(
            onTap: () {
              openUrl(payment.attachment);
            },
            child: _MyWidget(
              title: Trans.attachment.trans(),
              value: Trans.view.trans(),
            ),
          ),
      ],
    );
  }
}

class _MyWidget extends StatelessWidget {
  // ignore: unused_element
  const _MyWidget({
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          // if (icon != null) Icon(icon, size: 18, color: Colors.grey.shade900),
          // if (icon != null) const SizedBox(width: 6),
          SizedBox(
              width: 120, child: Text("$title: ", style: context.style14W400B)),
          Text(value, style: context.style14W400B)
        ],
      ),
    );
  }
}
//node_modules
