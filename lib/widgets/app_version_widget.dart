import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == true &&
                snapshot.connectionState == ConnectionState.done) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "${snapshot.data.version}+${snapshot.data.buildNumber}",
                      style: context.style12W400B));
            }
            return const Text("");
          },
        ),
      ),
    );
  }
}
/*

1- double enrty loan => pay instead ( ) loan  add icons

2- container expense


 */