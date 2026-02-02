import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/customer_double_entrys/data/models/create_customer_double_entry_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/update_customer_double_entry_model.dart';
import 'package:app/feature/customer_double_entrys/presentation/blocs/all/customer_double_entrys_bloc.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/material.dart';

class CreateUpdateCustomerDoubleEntryScreen extends StatefulWidget {
  const CreateUpdateCustomerDoubleEntryScreen(
      {super.key, required this.customerDoubleEntry});
  final CustomerDoubleEntryModel? customerDoubleEntry;
  @override
  State<CreateUpdateCustomerDoubleEntryScreen> createState() =>
      _CreateUpdateCustomerDoubleEntryScreenState();
}

class _CreateUpdateCustomerDoubleEntryScreenState
    extends State<CreateUpdateCustomerDoubleEntryScreen> {
  late TextEditingController name;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.customerDoubleEntry?.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GeneralButton(
            text: widget.customerDoubleEntry == null
                ? Trans.createArgs
                    .trans(args: [Trans.customerDoubleEntries.trans()])
                : Trans.editArgs
                    .trans(args: [Trans.customerDoubleEntries.trans()]),
            onTap: () async {
              final res = await getUserConfirm(
                  desc: Trans.areYouSureYouWantToSubmit.trans());
              if (res != true) {
                return;
              }
              if (widget.customerDoubleEntry == null) {
                CreateCustomerDoubleEntryModel createCustomerDoubleEntryModel =
                    CreateCustomerDoubleEntryModel(name: name.text.trim());

                sl<CustomerDoubleEntrysBloc>().add(
                    CustomerDoubleEntryCreateEvent(
                        model: createCustomerDoubleEntryModel));
              } else {
                UpdateCustomerDoubleEntryModel createCustomerDoubleEntryModel =
                    UpdateCustomerDoubleEntryModel(
                        id: widget.customerDoubleEntry!.id,
                        name: name.text.trim());
                sl<CustomerDoubleEntrysBloc>().add(
                    CustomerDoubleEntryUpdateEvent(
                        model: createCustomerDoubleEntryModel));
              }
            }),
        appBar: AppBar(title: Text(Trans.customerDoubleEntries.trans())),
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
