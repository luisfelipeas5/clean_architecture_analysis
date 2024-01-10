import 'package:args/args.dart';
import 'package:clean_architecture_analysis/clean_architecture_analysis.dart';

const analysisConfigFilePathArgKey = "config";
const commandArgKey = "command";

void main(List<String> arguments) {
  final argResults = _getArgResults(arguments);
  print("Arguments:");

  final analysisConfigFilePath = argResults[analysisConfigFilePathArgKey];
  print("Analysis Config file path: $analysisConfigFilePath");

  final mainCommand = _getMainCommand(argResults);
  print("Main command: ${mainCommand.name}");

  final mainComponent = ScriptMainComponent();
  mainComponent(
    command: mainCommand,
    analysisConfigFilePath: analysisConfigFilePath,
    debugMode: true,
  );
}

MainCommand _getMainCommand(ArgResults argResults) {
  final commandString = argResults[commandArgKey];
  return MainCommand.values
      .firstWhere((element) => element.name == commandString);
}

ArgResults _getArgResults(List<String> arguments) {
  final parser = ArgParser()
    ..addOption(analysisConfigFilePathArgKey)
    ..addOption(commandArgKey);

  return parser.parse(arguments);
}
