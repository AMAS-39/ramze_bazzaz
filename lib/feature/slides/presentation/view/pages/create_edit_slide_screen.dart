import 'package:flutter/material.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/slides/data/models/create_slide_model.dart';
import 'package:app/feature/slides/data/models/update_slide_model.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:app/feature/slides/presentation/blocs/all/slides_bloc.dart';
class CreateUpdateSlideScreen extends StatefulWidget {
  const CreateUpdateSlideScreen({super.key, required this.slide});
  final SlideModel? slide;
  @override
  State<CreateUpdateSlideScreen> createState() =>
      _CreateUpdateSlideScreenState();
}

class _CreateUpdateSlideScreenState
    extends State<CreateUpdateSlideScreen> {
  late TextEditingController name;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.slide?.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GeneralButton(
            text: widget.slide == null
                ? Trans.createArgs.trans(args: [Trans.slides.trans()])
                : Trans.editArgs.trans(args: [Trans.slides.trans()]),
            onTap: () async {
              final res = await getUserConfirm(
                  desc: Trans.areYouSureYouWantToSubmit.trans());
              if (res != true) {
                return;
              }
              if (widget.slide == null) {
                CreateSlideModel createSlideModel =
                    CreateSlideModel(name: name.text.trim());

                sl<SlidesBloc>().add(
                    SlideCreateEvent (model: createSlideModel));
              } else {
                UpdateSlideModel createSlideModel = UpdateSlideModel(
                    id: widget.slide!.id, name: name.text.trim());
                sl<SlidesBloc>().add(
                    SlideUpdateEvent (model: createSlideModel));
              }
            }),
        appBar: AppBar(title: Text(Trans.slides.trans())),
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
