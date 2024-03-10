import 'dart:ui';

import 'package:clean_architecture_analysis/src/domain/entities/components/component_type.dart';

extension ComponentTypePresentationExtensions on ComponentType {
  Color get backgroundColor {
    return switch (order) {
      0 => Color(0xffff9feaf),
      1 => Color(0xfffff9d99),
      2 => Color(0xfff83ffb3),
      _ => Color(0xfff9adaff),
    };
  }
}
