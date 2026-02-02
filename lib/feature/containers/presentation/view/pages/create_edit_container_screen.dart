import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:app/feature/containers/data/models/create_container_model.dart';
import 'package:app/feature/containers/data/models/update_container_model.dart';
import 'package:app/feature/containers/presentation/blocs/all/containers_bloc.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/material.dart';

class CreateUpdateContainerScreen extends StatefulWidget {
  const CreateUpdateContainerScreen({super.key, required this.container});
  final ContainerModel? container;
  @override
  State<CreateUpdateContainerScreen> createState() =>
      _CreateUpdateContainerScreenState();
}

class _CreateUpdateContainerScreenState
    extends State<CreateUpdateContainerScreen> {
  late TextEditingController name;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.container?.awbNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GeneralButton(
            text: widget.container == null
                ? Trans.createArgs.trans(args: [Trans.containers.trans()])
                : Trans.editArgs.trans(args: [Trans.containers.trans()]),
            onTap: () async {
              final res = await getUserConfirm(
                  desc: Trans.areYouSureYouWantToSubmit.trans());
              if (res != true) {
                return;
              }
              if (widget.container == null) {
                CreateContainerModel createContainerModel =
                    CreateContainerModel(name: name.text.trim());

                sl<ContainersBloc>()
                    .add(ContainerCreateEvent(model: createContainerModel));
              } else {
                UpdateContainerModel createContainerModel =
                    UpdateContainerModel(
                        id: widget.container!.id, name: name.text.trim());
                sl<ContainersBloc>()
                    .add(ContainerUpdateEvent(model: createContainerModel));
              }
            }),
        appBar: AppBar(title: Text(Trans.containers.trans())),
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
