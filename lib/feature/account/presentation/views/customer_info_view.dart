import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/bloc/customer_info/customer_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerInfoView extends StatefulWidget {
  const CustomerInfoView({super.key});

  @override
  State<CustomerInfoView> createState() => _CustomerInfoViewState();
}

class _CustomerInfoViewState extends State<CustomerInfoView> {
  @override
  void initState() {
    sl<CustomerInfoBloc>().add(const CustomerInfoFromLocalEvent());
    sl<CustomerInfoBloc>().add(const CustomerInfoFromRemoteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
      builder: (context, state) {
        logger("CustomerInfoBloc $state");
        return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: appConfig.app == App.rbb ? 12 : 0,
                right: appConfig.app == App.rbb ? 12 : 0,
                bottom: 12,
                top: 12),
            decoration: appConfig.app == App.kostolog
                ? null
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(BORDER_RADUIS),
                    color: context.primaryColor.withOpacity(.1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (appConfig.app == App.rbb)
                  Text(
                    Trans.accountSummary.trans(),
                    style: context.style20W400B.copyWith(),
                  ),
                // if (state is CustomerInfoInitial)
                if (appConfig.app == App.rbb) const SizedBox(height: 12),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _MyWidget(
                        size: 24 + 6,
                        icon: Assets.images.truck,
                        color: Colors.red.withOpacity(.8),
                        text: Trans.currentLoan.trans(),
                        value:
                            sl<CustomerInfoBloc>().info?.currentLoan.format ??
                                "",
                      ),
                      const SizedBox(width: 12),
                      _MyWidget(
                        size: 24,
                        icon: Assets.images.payMoneyIcon,
                        color: Colors.green.withOpacity(.8),
                        text: Trans.payInstead.trans(),
                        value: sl<CustomerInfoBloc>()
                                .info
                                ?.doubleEntryLoan
                                .format ??
                            "",
                      )
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}

class _MyWidget extends StatelessWidget {
  const _MyWidget(
      {required this.text,
      required this.icon,
      required this.size,
      required this.value,
      required this.color});
  final String text;
  final String value;
  final Color color;
  final String icon;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(BORDER_RADUIS)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size,
                  height: size,
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      width: size,
                      height: size,
                      // ignore: deprecated_member_use
                      color: appConfig.app == App.kostolog
                          ? Colors.white
                          : context.titleStyle.color,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  text,
                  style: context.style14W400B.copyWith(
                      color:
                          appConfig.app == App.kostolog ? Colors.white : null),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: context.style16W400B.copyWith(
                  color: appConfig.app == App.kostolog ? Colors.white : null),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

///
/*

Ramze Bazzaz - The Ultimate Shipping Management Solution

Ramze Bazzaz is your all-in-one mobile app for managing shipping logistics with ease and efficiency. Whether you're an individual or a business, Ramze Bazzaz simplifies the complexities of shipping with powerful features tailored to meet your needs.

Account Summary: with current and pay insteads  loans

Account Loans: Track your shipping expenses seamlessly with our integrated account loan feature. Stay on top of your financials and make informed decisions.

Double Entry System: Ensure accuracy and transparency in your financial records with our double entry bookkeeping system, designed to keep your accounts balanced and organized.

Payments: Easily track payments within the app.  including price, quantity, cmb, container and status.

Return Payments: You will be upto date with your return payment, viewing amount, expense, total and date.

Payments Instead: You will be upto date with your instead payment, viewing amount, expense, total and date.

Attachment Management: Keep all your shipping attachments organized,including documents and receipts .

Packages and Last Packages: Track your packages in real-time. Get updates on the status of your shipments to ensure timely deliveries with another details like price, quantity, cmb and etc.

Container Management: Easily search for your container.and monitor container movements and maintain an accurate inventory of your shipping assets.

Ability to change app language(English, Arabic and Kurdish) and theme (System, Dark and Light Mode)

Ramze Bazzaz is designed with user-friendly interfaces and robust features to make your shipping process smooth and hassle-free. Download now and take control of your shipping operations like never before!
 */
