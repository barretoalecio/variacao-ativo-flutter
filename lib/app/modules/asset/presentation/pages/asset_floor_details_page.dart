import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../../../../core/shared/presentation/pages/error_page.dart';
import '../../../../core/shared/presentation/widgets/app_bar/guide_app_bar.dart';
import '../../../../core/shared/presentation/widgets/guide_snack_bar.dart';
import '../../../../core/shared/presentation/widgets/loading_indicator.dart';
import '../../../../core/utils/mixins/no_internet_mixin.dart';
import '../controllers/blocs/asset_bloc.dart';
import '../controllers/events/search_asset_floor_data_event.dart';
import '../controllers/states/getting_asset_floor_data_by_code_state.dart';
import '../controllers/states/successfully_got_asset_floor_data_by_code_state.dart';
import '../widgets/asset_floor_data_table.dart';
import '../widgets/chart/asset_variation_line_chart.dart';

class AssetFloorDetailsPage extends StatefulWidget {
  const AssetFloorDetailsPage({
    super.key,
    required this.assetBloc,
    required this.assetCode,
  });

  final AssetBloc assetBloc;
  final String assetCode;

  @override
  State<AssetFloorDetailsPage> createState() => _AssetFloorDetailsPageState();
}

class _AssetFloorDetailsPageState extends State<AssetFloorDetailsPage>
    with NoInternetMixin {
  @override
  void initState() {
    widget.assetBloc.add(
      SearchAssetFloorDataByCodeEvent(
        code: widget.assetCode,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GuideAppBar(),
      body: BlocConsumer<AssetBloc, AppState>(
        bloc: widget.assetBloc,
        listener: (context, state) {
          GuideSnackBar.showSnackBar(context, state);
        },
        builder: (context, state) {
          if (state is GettingAssetFloorDataByCodeState || state is IdleState) {
            return const AssetFloorDetailsSkeleton(
              child: Center(
                key: ValueKey<int>(0),
                child: LoadingIndicator(),
              ),
            );
          }

          if (state is SuccessfullyGotFloorDataByCodeState) {
            return SafeArea(
              key: const ValueKey<int>(1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      AssetVariationLineChart(
                        floorEntity: state.assetEntity.floor,
                        assetCode: state.assetEntity.code,
                      ),
                      AssetFloorDataTable(
                        floorEntity: state.assetEntity.floor,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return AssetFloorDetailsSkeleton(
            child: Center(
              key: const ValueKey<int>(2),
              child: ErrorPage(
                message: state.message,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AssetFloorDetailsSkeleton extends StatelessWidget {
  const AssetFloorDetailsSkeleton({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
          child: child,
        ),
      ),
    );
  }
}
