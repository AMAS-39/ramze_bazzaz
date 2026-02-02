import 'package:app/core/shared/imports.dart';
import 'package:app/feature/payments/data/models/payment_details_model.dart';
import 'package:app/feature/payments/data/models/payments_model.dart';
import 'package:app/feature/payments/presentation/view/pages/payment_details_screen.dart';
import 'package:flutter/material.dart';

class PaymentWidget extends StatelessWidget {
  final PaymentModel payment;
  const PaymentWidget({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onLongPress:(){
      //       showOptionBottomSheet(options: [
      //                   Options.View,
      //                   Options.Edit,
      //                   Options.Delete,
      //                 ]).then((value) async {
      //                   if (value == Options.View) {
      //                     context.to(
      //                     PaymentDetailsScreen(id: payment.id, name: payment.name));
      //                   } else if (value == Options.Edit) {
      //                      context.to( CreateUpdatePaymentScreen(payment: payment));
      //                   } else if (value == Options.Delete) {
      //                     final res = await getUserConfirm(
      //                         desc: Trans.areYouSureYouWantToDeleteSelectedItem
      //                             .trans());
      //                     if (res == true) {
      //                       sl<PaymentsBloc>().add(PaymentDeleteEvent(payment));
      //                     }
      //                   }
      //                 });
      // },
      onTap: () {
        context.to(PaymentDetailsScreen(
            payment: PaymentDetailsModel.fromMap(payment.toMap()),
            id: payment.id,
            name: payment.invoiceNumber ?? ""));
      },
      child: Container(
        decoration: BoxDecoration(
            color: appConfig.app == App.rbb ? context.cardColor : null,
            // border: Border.all(width: .5, color: context.primaryColor),
            borderRadius: BorderRadius.circular(BORDER_RADUIS)),
        padding: const EdgeInsets.all(kIndent),
        child: Column(
          children: [
            _MyWidget(
              icon: Icons.wallet,
              title: Trans.amount.trans(),
              value: (payment.byMain
                  ? payment.price.formatUSD
                  : payment.scPrice.formatIQD),
            ),
            const SizedBox(height: 8),
            _MyWidget(
              icon: Icons.wallet_giftcard_outlined,
              title: Trans.forgivePrice.trans(),
              value: (payment.byMain
                  ? payment.forgivePrice.formatUSD
                  : payment.scForgivePrice.formatIQD),
            ),
            const SizedBox(height: 8),
            _MyWidget(
              icon: Icons.date_range_rounded,
              title: Trans.date.trans(),
              value: payment.date.onlyDate,
            ),
            const SizedBox(height: 8),
            _MyWidget(
              icon: Icons.person_2_sharp,
              title: Trans.paidBy.trans(),
              value: payment.paidBy ?? "",
            ),
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
    return Row(
      children: [
        if (icon != null)
          Icon(icon, size: 18, color: context.style12W400.color),
        if (icon != null) const SizedBox(width: 6),
        SizedBox(
            width: 120, child: Text("$title: ", style: context.style14W400B)),
        Text(value, style: context.style14W400B)
      ],
    );
  }
}
