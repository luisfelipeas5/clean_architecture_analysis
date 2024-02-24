import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/entities/order/order_circuference.dart';

class GetOrderCircuferences {
  Result<Map<int, OrderCircuference>> call({
    required List<ComponentWithDependencies> componentsWithDependencies,
  }) {
    final orders = <int, OrderCircuference>{};

    double biggestRatio = 0;

    componentsWithDependencies.sort(_sortComponents);
    for (var componentWithDeps in componentsWithDependencies) {
      final order = componentWithDeps.component.type?.order ?? -1;
      final orderCircuference = orders[order] ??
          OrderCircuference(
            order: order,
            ratio: orders[order - 1]?.ratio ?? 0,
            center: (0, 0),
            componentsCount: 0,
          );
      final newOrderCircuference = _incrementCircuference(orderCircuference);
      if (newOrderCircuference.ratio > biggestRatio) {
        biggestRatio = newOrderCircuference.ratio;
      }
      orders[order] = newOrderCircuference;
    }

    final center = (biggestRatio, biggestRatio);
    final keys = orders.keys.toList()..sort();
    for (var key in keys) {
      final orderCircuference = orders[key]!;
      orders[key] = orderCircuference.copyWith(
        center: center,
      );
    }

    return Result.success(orders);
  }

  int _sortComponents(
    ComponentWithDependencies a,
    ComponentWithDependencies b,
  ) {
    final aOrder = a.component.type?.order ?? -1;
    final bOrder = b.component.type?.order ?? -1;
    return aOrder - bOrder;
  }

  OrderCircuference _incrementCircuference(
    OrderCircuference orderCircuference,
  ) {
    final newRatio = orderCircuference.ratio + 40;
    final newComponentsCount = orderCircuference.componentsCount + 1;
    return OrderCircuference(
      order: orderCircuference.order,
      ratio: newRatio,
      center: (0, 0),
      componentsCount: newComponentsCount,
    );
  }
}
