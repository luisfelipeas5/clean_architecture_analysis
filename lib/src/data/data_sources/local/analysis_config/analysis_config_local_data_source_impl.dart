import 'dart:convert';
import 'dart:io';

import 'package:clean_architecture_analysis/src/data/data_sources/local/analysis_config/analysis_config_local_data_source.dart';
import 'package:clean_architecture_analysis/src/data/models/analysis_config/analysis_config_model.dart';
import 'package:clean_architecture_analysis/src/domain/entities/analysis_config/analysis_config.dart';

class AnalysisConfigLocalDataSourceImpl
    implements AnalysisConfigLocalDataSource {
  final String analysisConfigFilePath;

  AnalysisConfigLocalDataSourceImpl({
    required this.analysisConfigFilePath,
  });

  @override
  Future<AnalysisConfig> getAnalysisConfig() async {
    final file = File(analysisConfigFilePath);
    final json = jsonDecode(await file.readAsString());
    return AnalysisConfigModel.fromJson(json);
  }
}
