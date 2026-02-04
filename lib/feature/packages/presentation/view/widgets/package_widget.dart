import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/presentation/view/widgets/ribbon.dart';
import 'package:flutter/material.dart';

class PackageWidget extends StatelessWidget {
  final PackageModel package;
  final bool tracking;
  const PackageWidget({
    super.key,
    required this.package,
    this.tracking = false,
  });

  @override
  Widget build(BuildContext context) {
    bool hav = package.container.containerStatus == ContainerStatus.Arrived ||
        package.container.arrivalDate != null;
    return InkWell(
      child: Ribbon(
        color: hav ? Colors.red : context.cardColor,
        nearLength: 30,
        location: hav
            ? (context.isEn ? RibbonLocation.topEnd : RibbonLocation.topStart)
            : RibbonLocation.none,
        farLength: 60,
        titleStyle:
            TextStyle(inherit: true, color: Colors.white, fontSize: 20.sp),
        title: "  ",
        child: Container(
          decoration: BoxDecoration(
              color: appConfig.app == App.rbb ? context.cardColor : null,
              borderRadius: BorderRadius.circular(BORDER_RADUIS)),
          padding: EdgeInsets.all(kIndent / (appConfig.app != App.rbb ? 2 : 1)),
          child: Column(
            children: [
              _MyWidget(
                icon: Icons.attach_money_rounded,
                iconColor: Colors.green.shade700,
                title: Trans.price.trans(),
                value: package.totalPrice.formatUSD,
              ),
              _MyWidget(
                icon: Icons.monetization_on_outlined,
                iconColor: Colors.green.shade600,
                title: Trans.unitPrice.trans(),
                value: package.unitPrice.formatUSD,
              ),
              _MyWidget(
                icon: Icons.inventory_2_outlined,
                iconColor: Colors.blue.shade700,
                title: Trans.qty.trans(),
                value: package.qty.toString(),
              ),
              _MyWidget(
                icon: Icons.view_in_ar_outlined,
                iconColor: Colors.orange.shade700,
                title: Trans.cbm.trans(),
                value: (package.cbm.toString()),
              ),
              _MyWidget(
                icon: Icons.widgets_outlined,
                iconColor: Colors.purple.shade700,
                title: Trans.container.trans(),
                value: (package.container.number.toString()),
              ),
              if (tracking)
                _MyWidget(
                  icon: Icons.info_outline_rounded,
                  iconColor: Colors.blue.shade700,
                  title: Trans.status.trans(),
                  value: package.packageStatus.name.trans(),
                ),
              _MyWidget(
                icon: Icons.local_shipping_outlined,
                iconColor: Colors.teal.shade700,
                title: Trans.shippingDate.trans(),
                value: package.container.shippingDate?.onlyDate ?? "",
              ),
              _MyWidget(
                icon: Icons.event_available_outlined,
                iconColor: Colors.indigo.shade700,
                title: Trans.arrivalDate.trans(),
                value: package.container.arrivalDate?.onlyDate ?? "",
              ),
              if (package.container.shippingDate != null)
                _MyWidget(
                  icon: Icons.event_outlined,
                  iconColor: Colors.amber.shade700,
                  title: Trans.expectedDate.trans(),
                  value: package
                      .container.shippingDate!
                      .add(const Duration(days: 45))
                      .onlyDate,
                ),
              if (package.container.shippingDate != null &&
                  package.container.arrivalDate == null &&
                  appConfig.app.isRbb)
                Builder(builder: (context) {
                  final remanningDays = 45 -
                      DateTime.now()
                          .difference(package.container.shippingDate!)
                          .inDays;
                  if (remanningDays < 0) {
                    return SizedBox();
                  }

                  return _MyWidget(
                    icon: Icons.schedule_outlined,
                    iconColor: remanningDays <= 7
                        ? Colors.orange.shade700
                        : Colors.green.shade700,
                    title: Trans.expectedArrivalDays.trans(),
                    value: (remanningDays).toString(),
                  );
                }),
              if (!checkIsNull(package.description)) ...[
                _MyWidget(
                  icon: Icons.description_outlined,
                  iconColor: Colors.grey.shade700,
                  title: "",
                  value: package.description ?? "",
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _MyWidget extends StatelessWidget {
  const _MyWidget({
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
  });
  final String? title;
  final String value;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          if (icon != null)
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (iconColor ?? Colors.grey.shade700).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                size: 18,
                color: iconColor ?? Colors.grey.shade900,
              ),
            ),
          if (icon != null) const SizedBox(width: 10),
          if (!checkIsNull(title))
            Text(
              "$title: ",
              strutStyle: StrutStyle(forceStrutHeight: true, height: 1.1),
              style: context.style14W400B,
            ),
          Expanded(
            child: Text(
              value,
              strutStyle: StrutStyle(forceStrutHeight: true, height: 1.1),
              style: context.style14W400B.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:app/core/shared/imports.dart';
// import 'package:app/feature/packages/data/models/packages_model.dart';
// import 'package:app/feature/packages/presentation/view/widgets/ribbon.dart';
// import 'package:flutter/material.dart';

// class PackageWidget extends StatelessWidget {
//   final PackageModel package;
//   final bool tracking;
//   const PackageWidget({
//     super.key,
//     required this.package,
//     this.tracking = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool hav = package.container.containerStatus == ContainerStatus.Arrived ||
//         package.container.arrivalDate != null;
//     return InkWell(
//       child: Ribbon(
//         color: hav ? Colors.red : context.cardColor,
//         nearLength: 30,
//         location: hav
//             ? (context.isEn ? RibbonLocation.topEnd : RibbonLocation.topStart)
//             : RibbonLocation.none,
//         farLength: 60,
//         titleStyle:
//             TextStyle(inherit: true, color: Colors.white, fontSize: 20.sp),
//         title: "  ",
//         child: Container(
//           decoration: BoxDecoration(
//               color: appConfig.app == App.rbb ? context.cardColor : null,
//               borderRadius: BorderRadius.circular(BORDER_RADUIS)),
//           padding: EdgeInsets.all(kIndent / (appConfig.app != App.rbb ? 2 : 1)),
//           child: Column(
//             children: [
//               _MyWidget(
//                 icon: null,
//                 title: Trans.price.trans(),
//                 value: package.totalPrice.formatUSD,
//               ),
//               _MyWidget(
//                 icon: null,
//                 title: Trans.qty.trans(),
//                 value: package.qty.toString(),
//               ),
//               _MyWidget(
//                 icon: null,
//                 title: Trans.cbm.trans(),
//                 value: (package.cbm.toString()),
//               ),
//               _MyWidget(
//                 icon: null,
//                 title: Trans.container.trans(),
//                 value: (package.container.number.toString()),
//               ),
//               _MyWidget(
//                 icon: null,
//                 title: Trans.shippingDate.trans(),
//                 value: package.container.shippingDate?.onlyDate ?? "",
//               ),
//               _MyWidget(
//                 icon: null,
//                 title: Trans.arrivalDate.trans(),
//                 value: package.container.arrivalDate?.onlyDate ?? "",
//               ),
//               if (package.container.shippingDate != null &&
//                   package.container.arrivalDate == null &&
//                   appConfig.app.isRbb)
//                 Builder(builder: (context) {
//                   final remanningDays = 45 -
//                       DateTime.now()
//                           .difference(package.container.shippingDate!)
//                           .inDays;
//                   if (remanningDays < 0) {
//                     return SizedBox();
//                   }

//                   return _MyWidget(
//                     icon: null,
//                     title: Trans.expectedArrivalDays.trans(),
//                     value: (remanningDays).toString(),
//                   );
//                 }),
//               if (tracking) ...[
//                 _MyWidget(
//                   icon: null,
//                   title: Trans.status.trans(),
//                   value: package.packageStatus.name.trans(),
//                 ),
//               ],
//               if (!checkIsNull(package.description)) ...[
//                 _MyWidget(
//                   icon: null,
//                   title: Trans.description.trans(),
//                   value: package.description ?? "",
//                 ),
//               ]
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _MyWidget extends StatelessWidget {
//   const _MyWidget(
//       {required this.title, required this.value, required this.icon});
//   final String title;
//   final String value;
//   final IconData? icon;
//   @override

//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         children: [
//           if (icon != null) Icon(icon, size: 18, color: Colors.grey.shade900),
//           if (icon != null) const SizedBox(width: 6),
//           SizedBox(
//               // width: 80,
//               child: Text("$title: ",
//                   strutStyle: StrutStyle(forceStrutHeight: true, height: 1.1),
//                   style: context.style14W400B)),
//           Text(value,
//               strutStyle: StrutStyle(forceStrutHeight: true, height: 1.1),
//               style: context.style14W400B.copyWith(fontWeight: FontWeight.w500))
//         ],
//       ),
//     );
//   }
// }
