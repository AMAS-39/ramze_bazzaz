import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final ContainerModel container;
  const ContainerWidget({
    super.key,
    required this.container,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onLongPress:(){
      //       showOptionBottomSheet(options: [
      //                   Options.View,
      //                   Options.Edit,
      //                   Options.Delete,
      //                 ]).then((value) async {
      //                   if (value == Options.View) {
      //                     context.to(
      //                     ContainerDetailsScreen(id: container.id, name: container.name));
      //                   } else if (value == Options.Edit) {
      //                      context.to( CreateUpdateContainerScreen(container: container));
      //                   } else if (value == Options.Delete) {
      //                     final res = await getUserConfirm(
      //                         desc: Trans.areYouSureYouWantToDeleteSelectedItem
      //                             .trans());
      //                     if (res == true) {
      //                       sl<ContainersBloc>().add(ContainerDeleteEvent(container));
      //                     }
      //                   }
      //                 });
      // },
      // onTap: () {
      //   context.to(
      //       ContainerDetailsScreen(id: container.id, name: container.name));
      // },
      child: Container(
        padding: const EdgeInsets.all(kIndent),
        decoration: BoxDecoration(
            border: Border.all(width: 0.9, color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          container.id.toString(),
          style: context.titleStyle,
        ),
      ),
    );
  }
}
