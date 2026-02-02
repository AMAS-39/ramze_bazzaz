import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:flutter/material.dart';

class CustomerDoubleEntryWidget extends StatelessWidget {
  final CustomerDoubleEntryModel customerDoubleEntry;
  const CustomerDoubleEntryWidget({
    super.key,
    required this.customerDoubleEntry,
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
              value: customerDoubleEntry.transferAmount.format,
              icon: null,
            ),
            _InfoWidget(
                //2

                title: "${Trans.cc.trans()} % ",
                value: customerDoubleEntry.commission.format,
                icon: null),
            _InfoWidget(
                //3

                title: "${Trans.total.trans()} ¥ ",
                value: customerDoubleEntry.totalTransferAmount.format,
                icon: null),
            _InfoWidget(
                //4

                title: "${Trans.price.trans()} ¥ ",
                value: customerDoubleEntry.exchangeRate.format,
                icon: null),
            _InfoWidget(
                //5

                title: "${Trans.amount.trans()} \$ ",
                value: customerDoubleEntry.price.format,
                icon: null),
            _InfoWidget(
                //6

                title: "${Trans.tc.trans()} \$ ",
                value: customerDoubleEntry.expensePrice.format,
                icon: null),
            _InfoWidget(

                ///7
                title: "${Trans.oAmount.trans()} \$ ",
                value: customerDoubleEntry.otherPrice.format,
                icon: null),
            _InfoWidget(

                ///8
                title: "${Trans.total.trans()} \$ ",
                value: ((customerDoubleEntry.isLost
                        ? (customerDoubleEntry.totalPrice +
                            customerDoubleEntry.forgivePrice)
                        : -(customerDoubleEntry.totalPrice +
                            customerDoubleEntry.forgivePrice))
                    .format),
                icon: null),
            _InfoWidget(
                title: Trans.date.trans(),
                value: customerDoubleEntry.date.onlyDate,
                icon: null),
            _InfoWidget(
                title: Trans.shopNo.trans(),
                value: customerDoubleEntry.shopNumber ?? "",
                icon: null),
            _InfoWidget(
                title: Trans.shopInvoice.trans(),
                value: customerDoubleEntry.invoiceNumber ?? "",
                icon: null),
            _InfoWidget(
                title: Trans.shopName.trans(),
                value: customerDoubleEntry.shopName ?? "",
                icon: null),
            // _InfoWidget(
            //     title: Trans.carton.trans(),
            //     value: customerDoubleEntry.qu ?? "",
            // icon: null),
            // if (!checkIsNull(customerDoubleEntry.description))
            //   _InfoWidget(
            //       title: Trans.description.trans(),
            //       value: customerDoubleEntry.description ?? "",
            //       icon: null)
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
