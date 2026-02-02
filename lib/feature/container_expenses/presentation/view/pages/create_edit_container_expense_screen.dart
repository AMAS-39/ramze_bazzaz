import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:app/feature/container_expenses/data/models/create_container_expense_model.dart';
import 'package:app/feature/container_expenses/data/models/update_container_expense_model.dart';
import 'package:app/feature/container_expenses/presentation/blocs/all/container_expenses_bloc.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/material.dart';

class CreateUpdateContainerExpenseScreen extends StatefulWidget {
  const CreateUpdateContainerExpenseScreen(
      {super.key, required this.containerExpense});
  final ContainerExpenseModel? containerExpense;
  @override
  State<CreateUpdateContainerExpenseScreen> createState() =>
      _CreateUpdateContainerExpenseScreenState();
}

class _CreateUpdateContainerExpenseScreenState
    extends State<CreateUpdateContainerExpenseScreen> {
  late TextEditingController name;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.containerExpense?.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GeneralButton(
            text: widget.containerExpense == null
                ? Trans.createArgs
                    .trans(args: [Trans.containerExpenses.trans()])
                : Trans.editArgs.trans(args: [Trans.containerExpenses.trans()]),
            onTap: () async {
              final res = await getUserConfirm(
                  desc: Trans.areYouSureYouWantToSubmit.trans());
              if (res != true) {
                return;
              }
              if (widget.containerExpense == null) {
                CreateContainerExpenseModel createContainerExpenseModel =
                    CreateContainerExpenseModel(name: name.text.trim());

                sl<ContainerExpensesBloc>().add(ContainerExpenseCreateEvent(
                    model: createContainerExpenseModel));
              } else {
                UpdateContainerExpenseModel createContainerExpenseModel =
                    UpdateContainerExpenseModel(
                        id: widget.containerExpense!.id,
                        name: name.text.trim());
                sl<ContainerExpensesBloc>().add(ContainerExpenseUpdateEvent(
                    model: createContainerExpenseModel));
              }
            }),
        appBar: AppBar(title: Text(Trans.containerExpenses.trans())),
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
