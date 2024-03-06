import 'dart:convert';

import 'package:clean_architecture_analysis/src/data/data_sources/local/analysis_config/analysis_config_local_data_source.dart';
import 'package:clean_architecture_analysis/src/data/models/analysis_config/analysis_config_model.dart';
import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';
import 'package:flutter/services.dart';

class AppAnalysisConfigLocalDataSource
    implements AnalysisConfigLocalDataSource {
  final String analysisConfigFilePath;

  AppAnalysisConfigLocalDataSource({
    required this.analysisConfigFilePath,
  });

  @override
  Future<AnalysisConfig> getAnalysisConfig() async {
    final fileContent = await rootBundle.loadString(analysisConfigFilePath);
    final json = jsonDecode(fileContent);
    return AnalysisConfigModel.fromJson(json);
  }
}
