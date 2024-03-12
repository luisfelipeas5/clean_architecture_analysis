import 'package:clean_architecture_analysis/src/domain/entities/components/component_dependency.dart';
import 'package:clean_architecture_analysis/src/domain/entities/components/component_with_dependencies.dart';
import 'package:clean_architecture_analysis/src/domain/entities/files/app_file.dart';
import 'package:clean_architecture_analysis/src/presentation/controllers/which_files_import_dependency/which_files_import_dependency_controller.dart';
import 'package:flutter/material.dart';

class WhichFilesImportDependencyContainer extends StatefulWidget {
  final ComponentWithDependencies componentWithDependencies;
  final ComponentDependency componentDependency;
  final VoidCallback onCloseTap;

  const WhichFilesImportDependencyContainer({
    required this.componentWithDependencies,
    required this.componentDependency,
    required this.onCloseTap,
    super.key,
  });

  @override
  State<WhichFilesImportDependencyContainer> createState() =>
      _WhichFilesImportDependencyContainerState();
}

class _WhichFilesImportDependencyContainerState
    extends State<WhichFilesImportDependencyContainer> {
  late WhichFilesImportDependencyController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WhichFilesImportDependencyController(
      componentWithDependencies: widget.componentWithDependencies,
      componentDependency: widget.componentDependency,
    );
    _loadFiles();
  }

  void _loadFiles() async {
    await _controller.loadFiles();
    setState(() {});
  }

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
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: _buildCloseButton(),
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return GestureDetector(
      onTap: widget.onCloseTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Icon(
          Icons.close,
          size: 48,
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      itemCount: _controller.files.length,
      itemBuilder: (context, index) {
        final file = _controller.files[index];
        return _buildItem(file);
      },
    );
  }

  Widget _buildItem(AppFile file) {
    return Text(
      "${file.rootPath}/${file.relativePath}",
    );
  }
}
