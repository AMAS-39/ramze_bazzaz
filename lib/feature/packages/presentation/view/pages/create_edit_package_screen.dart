import 'package:flutter/material.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/packages/data/models/create_package_model.dart';
import 'package:app/feature/packages/data/models/update_package_model.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:app/feature/packages/presentation/blocs/all/packages_bloc.dart';
class CreateUpdatePackageScreen extends StatefulWidget {
  const CreateUpdatePackageScreen({super.key, required this.package});
  final PackageModel? package;
  @override
  State<CreateUpdatePackageScreen> createState() =>
      _CreateUpdatePackageScreenState();
}

class _CreateUpdatePackageScreenState
    extends State<CreateUpdatePackageScreen> {
  late TextEditingController name;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.package?.customerName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GeneralButton(
            text: widget.package == null
                ? Trans.createArgs.trans(args: [Trans.packages.trans()])
                : Trans.editArgs.trans(args: [Trans.packages.trans()]),
            onTap: () async {
              final res = await getUserConfirm(
                  desc: Trans.areYouSureYouWantToSubmit.trans());
              if (res != true) {
                return;
              }
              if (widget.package == null) {
                CreatePackageModel createPackageModel =
                    CreatePackageModel(name: name.text.trim());

                sl<PackagesBloc>().add(
                    PackageCreateEvent (model: createPackageModel));
              } else {
                UpdatePackageModel createPackageModel = UpdatePackageModel(
                    id: widget.package!.id, name: name.text.trim());
                sl<PackagesBloc>().add(
                    PackageUpdateEvent (model: createPackageModel));
              }
            }),
        appBar: AppBar(title: Text(Trans.packages.trans())),
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
