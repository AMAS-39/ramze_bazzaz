import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:flutter/material.dart';

class PayInsteadWidget extends StatelessWidget {
  final PayInsteadModel payInstead;
  const PayInsteadWidget({
    super.key,
    required this.payInstead,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(kIndent),
        decoration: BoxDecoration(
            color: appConfig.app == App.rbb ? context.cardColor : null,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _InfoWidget(
              //1
              title: "${Trans.amount.trans()} ¥ ",
              value: payInstead.transferAmount.format,
              icon: null,
            ),
            _InfoWidget(
                //2

                title: "${Trans.cc.trans()} % ",
                value: payInstead.commission.format,
                icon: null),
            _InfoWidget(
                //3

                title: "${Trans.total.trans()} ¥ ",
                value: payInstead.totalTransferAmount.format,
                icon: null),
            _InfoWidget(
                //4

                title: "${Trans.price.trans()} ¥ ",
                value: payInstead.exchangeRate.format,
                icon: null),
            _InfoWidget(
                //5
                title: "${Trans.unitPrice.trans()} \$ ",
                value: payInstead.price.formatUSD,
                icon: null),
            _InfoWidget(
                //6

                title: "${Trans.tc.trans()} \$ ",
                value: payInstead.expensePrice.format,
                icon: null),
            _InfoWidget(

                ///7
                title: "${Trans.oAmount.trans()} \$ ",
                value: payInstead.otherPrice.format,
                icon: null),
            _InfoWidget(

                ///8
                title: "${Trans.total.trans()} \$ ",
                value: ((payInstead.isLost
                        ? (payInstead.totalPrice + payInstead.forgivePrice)
                        : -(payInstead.totalPrice + payInstead.forgivePrice))
                    .format),
                icon: null),
            _InfoWidget(
                title: Trans.date.trans(),
                value: payInstead.date.onlyDate,
                icon: null),
            _InfoWidget(
                title: Trans.shopNo.trans(),
                value: payInstead.shopNo ?? "",
                icon: null),
            _InfoWidget(
                title: Trans.shopInvoice.trans(),
                value: payInstead.invoiceNumber ?? "",
                icon: null),
            _InfoWidget(
                title: Trans.shopName.trans(),
                value: payInstead.shopName ?? "",
                icon: null),
            // _InfoWidget(
            //     title: Trans.carton.trans(),
            //     value: payInstead.qu ?? "",
                // icon: null),
            if (!checkIsNull(payInstead.description))
              _InfoWidget(
                  title: Trans.description.trans(),
                  value: payInstead.description ?? "",
                  icon: null)
          ],
        ),
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  const _InfoWidget(
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

 