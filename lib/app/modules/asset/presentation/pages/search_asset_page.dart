import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/shared/presentation/widgets/buttons/filled_buttons.dart';
import '../../../../core/shared/presentation/widgets/disable_splash.dart';
import '../../../../core/shared/presentation/widgets/input_text.dart';
import '../../../../core/shared/presentation/widgets/main_logo.dart';
import '../../../../core/utils/app_routes/asset_module_routes.dart';
import '../../../../core/utils/app_routes/help_module_routes.dart';
import '../../../../core/utils/configuration/app_configuration.dart';
import '../../../../core/utils/configuration/flavors.dart';
import '../../../../core/utils/mixins/no_internet_mixin.dart';

class SearchAssetPage extends StatefulWidget {
  const SearchAssetPage({super.key});

  @override
  State<SearchAssetPage> createState() => _SearchAssetPageState();
}

class _SearchAssetPageState extends State<SearchAssetPage>
    with NoInternetMixin {
  @override
  void initState() {
    assetTextEditingController = TextEditingController();
    super.initState();
  }

  late final assetTextEditingController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              alignment: Alignment.center,
              child: DisableSplash(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      onLongPress: () async {
                        // This piece of code is used to add a development asset to the app
                        if (AppConfiguration.of(context)!.flavorOption ==
                            FlavorOption.development) {
                          Modular.to.pushNamed(
                            '${AssetModuleRoutes.moduleName}${AssetModuleRoutes.detailsRoute}/PETR4.SA',
                          );
                        }
                      },
                      child: const MainLogo(
                        height: 35,
                        width: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: InputText(
                        borderColor: const Color(0xFFE0E0E0),
                        labelColor: const Color(0xFF212121),
                        hint: 'Informe o nome do Ativo',
                        isAutoCorrect: false,
                        controller: assetTextEditingController,
                      ),
                    ),
                    MediumButton(
                      text: 'Acessar',
                      onPressed: () => Modular.to.pushNamed(
                        '${AssetModuleRoutes.moduleName}${AssetModuleRoutes.detailsRoute}/${assetTextEditingController.text.toUpperCase()}',
                      ),
                    ),
                    TextButton(
                      onPressed: () => Modular.to.pushNamed(
                        '${HelpModuleRoutes.moduleName}${HelpModuleRoutes.initialRoute}',
                      ),
                      child: const Text(
                        'Primeiro acesso? Clique aqui.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
