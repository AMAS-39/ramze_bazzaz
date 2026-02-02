import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/pay_insteads/data/models/create_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:app/feature/pay_insteads/data/models/update_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/presentation/blocs/all/pay_insteads_bloc.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/material.dart';

class CreateUpdatePayInsteadScreen extends StatefulWidget {
  const CreateUpdatePayInsteadScreen({super.key, required this.payInstead});
  final PayInsteadModel? payInstead;
  @override
  State<CreateUpdatePayInsteadScreen> createState() =>
      _CreateUpdatePayInsteadScreenState();
}

class _CreateUpdatePayInsteadScreenState
    extends State<CreateUpdatePayInsteadScreen> {
  late TextEditingController name;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.payInstead?.invoiceNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GeneralButton(
            text: widget.payInstead == null
                ? Trans.createArgs.trans(args: [Trans.payInsteads.trans()])
                : Trans.editArgs.trans(args: [Trans.payInsteads.trans()]),
            onTap: () async {
              final res = await getUserConfirm(
                  desc: Trans.areYouSureYouWantToSubmit.trans());
              if (res != true) {
                return;
              }
              if (widget.payInstead == null) {
                CreatePayInsteadModel createPayInsteadModel =
                    CreatePayInsteadModel(name: name.text.trim());

                sl<PayInsteadsBloc>()
                    .add(PayInsteadCreateEvent(model: createPayInsteadModel));
              } else {
                UpdatePayInsteadModel createPayInsteadModel =
                    UpdatePayInsteadModel(
                        id: widget.payInstead!.id, name: name.text.trim());
                sl<PayInsteadsBloc>()
                    .add(PayInsteadUpdateEvent(model: createPayInsteadModel));
              }
            }),
        appBar: AppBar(title: Text(Trans.payInsteads.trans())),
        body: ListView(
          children: [
            GeneralTextFiled(
                hintText: Trans.name.trans(),
                validate: validateName,
                controller: name)
          ],
        ));
  }
}
