import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/entities/order/order_circuference.dart';

class GetOrderCircuferences {
  Result<Map<int, OrderCircuference>> call({
    required List<ComponentWithDependencies> componentsWithDependencies,
  }) {
    final orders = <int, OrderCircuference>{};

    for (var componentWithDeps in componentsWithDependencies) {
      final order = componentWithDeps.component.type?.order ?? -1;
      final orderCircuference =
          orders[order] ?? OrderCircuference(order: order, ratio: 0);
      final newOrderCircuference = _incrementCircuference(orderCircuference);
      orders[order] = newOrderCircuference;
    }

    // TODO: adds sum order-1 ratio to order before return

    return Result.success(orders);
  }

  OrderCircuference _incrementCircuference(
    OrderCircuference orderCircuference,
  ) {
    final newRatio = orderCircuference.ratio + 10;
    return OrderCircuference(
      order: orderCircuference.order,
      ratio: newRatio,
    );
  }
}
