import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/views/customer_info_view.dart';
import 'package:app/feature/containers/presentation/view/pages/search_container_screen.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/presentation/view/widgets/package_status_filter_bar.dart';
import 'package:app/feature/packages/presentation/view/pages/packages_screen.dart';
import 'package:app/feature/packages/presentation/view/pages/packages_tracking.dart';
import 'package:app/feature/slides/data/models/slides_filter.dart';
import 'package:app/feature/slides/presentation/view/pages/slides_screen.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({
    super.key,
  });

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  ScrollController scrollController = ScrollController();

  final trackKey = GlobalKey<PackagesTrackingState>();
  PackageStatusFilter latestPackagesFilter = PackageStatusFilter.all;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        return trackKey.currentState!.onNotification(notification);
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                decoration: BoxDecoration(color: context.primaryColor),
                child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                  child: const CustomerInfoView(),
                )),
          ),
          SliverToBoxAdapter(
              child: Container(
            padding: EdgeInsets.only(top: 0, bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // The gradient will go from top to bottom
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // Define the colors
                stops: [0.3, 0.9],
                colors: [
                  context.primaryColor,
                  Color(0xFF4C4D9A), // Lighter Blue/Indigo (End)
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SlidesScreen(filterController: SlidesFilterModel()),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        Trans.searchForYourContainer.trans(),
                        style:
                            context.style18W500B.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 4),
                      Text(
                        Trans.enterYourContainerNumberToFollowUp.trans(),
                        style:
                            context.style12W500B.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      GeneralTextFiled(
                        controller: null,
                        borderRadius: 4,
                        readOnly: true,
                        onTap: () {
                          context
                              .to(SearchForContainerScreen(viewAppBar: true));
                        },
                        hintText: Trans.findYourContainer.trans(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: appConfig.app == App.kostolog
                  ? const EdgeInsets.only(
                      left: 20, right: 20, top: 12, bottom: 12)
                  : const EdgeInsets.only(
                      left: 20, right: 20, top: 12, bottom: 16),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      context.to(const PackagesScreen(
                          filterController:
                              PackagesFilterModel(setNumber: firstSet)));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            Trans.latestPackages.trans(),
                            style: context.style18W500B,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  PackageStatusFilterBar(
                    selected: latestPackagesFilter,
                    padding: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() => latestPackagesFilter = value);
                    },
                  ),
                ],
              ),
            ),
          ),
          PackagesTracking(
              key: trackKey,
              scrollController: scrollController,
              filterController: PackagesFilterModel(setNumber: firstSet),
              statusFilter: latestPackagesFilter),
        ],
      ),
    );
  }
}
