class AppFile {
  final String rootPath;
  final String path;

  const AppFile({
    required this.rootPath,
    required this.path,
  });

  String get relativePath {
    return relativePaths.join("/");
  }

  List<String> get relativePaths {
    return path.replaceFirst(rootPath, "").split("/");
  }

  List<String> get paths => path.split("/");
}
