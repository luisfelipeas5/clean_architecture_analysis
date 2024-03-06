part of '../component_graph_controller.dart';

void unselectComponentsWithNull(Node node) {
  (node as ComponentNode).selected = null;
}

void unselectComponentsWithFalse(Node node) {
  (node as ComponentNode).selected = false;
}
