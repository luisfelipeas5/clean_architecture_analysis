import 'package:clean_architecture_analysis/src/architecture_core/dependency_injector/app/app_dependency_injector.dart';
import 'package:clean_architecture_analysis/src/architecture_core/dependency_injector/app/get_it_app_dependency_injector.dart';
import 'package:clean_architecture_analysis/src/dependency_injectors/app/set_up_dependency_injections.dart';
import 'package:clean_architecture_analysis/src/presentation/pages/dependencies_graph_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final AppDependencyInjector appDependencyInjector =
    GetItAppDependencyInjector();

void main() {
  final setUpDependencyInjections = SetUpDependencyInjections(
    injector: appDependencyInjector,
    debugMode: kDebugMode,
    analysisConfigFilePath:
        "assets/inputs/analysis_configs/rider_flutter/rider_flutter_analysis_config.json",
  );
  setUpDependencyInjections();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DependenciesGraphPage(),
    );
  }
}
