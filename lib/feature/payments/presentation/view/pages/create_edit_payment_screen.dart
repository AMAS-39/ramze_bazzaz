// import 'package:app/core/shared/imports.dart';
// import 'package:app/core/utils/validations.dart';
// import 'package:app/feature/payments/data/models/create_payment_model.dart';
// import 'package:app/feature/payments/data/models/payments_model.dart';
// import 'package:app/feature/payments/data/models/update_payment_model.dart';
// import 'package:app/feature/payments/presentation/blocs/all/payments_bloc.dart';
// import 'package:app/widgets/button.dart';
// import 'package:app/widgets/form_widgets/form_widgets.dart';
// import 'package:flutter/material.dart';

// class CreateUpdatePaymentScreen extends StatefulWidget {
//   const CreateUpdatePaymentScreen({super.key, required this.payment});
//   final PaymentModel? payment;
//   @override
//   State<CreateUpdatePaymentScreen> createState() =>
//       _CreateUpdatePaymentScreenState();
// }

// class _CreateUpdatePaymentScreenState extends State<CreateUpdatePaymentScreen> {
//   late TextEditingController name;

//   @override
//   void initState() {
//     super.initState();
//     name = TextEditingController(text: widget.payment?.name);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: GeneralButton(
//             text: widget.payment == null
//                 ? Trans.createArgs.trans(args: [Trans.payments.trans()])
//                 : Trans.editArgs.trans(args: [Trans.payments.trans()]),
//             onTap: () async {
//               final res = await getUserConfirm(
//                   desc: Trans.areYouSureYouWantToSubmit.trans());
//               if (res != true) {
//                 return;
//               }
//               if (widget.payment == null) {
//                 CreatePaymentModel createPaymentModel =
//                     CreatePaymentModel(name: name.text.trim());

//                 sl<PaymentsBloc>()
//                     .add(PaymentCreateEvent(model: createPaymentModel));
//               } else {
//                 UpdatePaymentModel createPaymentModel = UpdatePaymentModel(
//                     id: widget.payment!.id, name: name.text.trim());
//                 sl<PaymentsBloc>()
//                     .add(PaymentUpdateEvent(model: createPaymentModel));
//               }
//             }),
//         appBar: AppBar(title: Text(Trans.payments.trans())),
//         body: ListView(
//           children: [
//             GeneralTextFiled(
//                 hintText: Trans.name.trans(),
//                 validate: validateName,
//                 controller: name)
//           ],
//         ));
//   }
// }
