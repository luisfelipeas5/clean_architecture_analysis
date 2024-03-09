import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:flutter/material.dart';

class ComponentsSelectedFileTree extends StatelessWidget {
  final List<ComponentWithDependencies> components;

  const ComponentsSelectedFileTree({
    required this.components,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemCount: components.length,
            itemBuilder: (context, index) {
              final component = components[index];
              return _buildItem(component);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 16);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(ComponentWithDependencies componentWithDependencies) {
    final component = componentWithDependencies.component;
    final dependencies = componentWithDependencies.dependencies;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(component.name),
        Text("Dependencies: "),
        SliverList.separated(
          itemCount: dependencies.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
          itemBuilder: (context, index) {
            final dependency = dependencies[index];
            return Text(dependency.component.name);
          },
        ),
      ],
    );
    return SliverList.list(
      children: [
        SliverToBoxAdapter(
          child: Text(component.name),
        ),
        // SliverToBoxAdapter(
        //   child: Text("Dependencies: "),
        // ),
        // SliverList.builder(
        //   itemCount: dependencies.length,
        //   itemBuilder: (context, index) {
        //     final dependency = dependencies[index];
        //     return SliverToBoxAdapter(
        //       child: Container(
        //         margin: EdgeInsets.only(left: 16),
        //         child: Text(dependency.component.name),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
