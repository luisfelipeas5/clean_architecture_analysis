class ComponentType {
  final String name;
  final List<String> patterns;

  const ComponentType({
    required this.name,
    required this.patterns,
  });

  String get pattern {
    return "(${patterns.join("|")})";
  }
}
