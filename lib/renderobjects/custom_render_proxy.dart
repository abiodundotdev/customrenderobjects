import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomPadding extends SingleChildRenderObjectWidget {
  final EdgeInsets padding;
  const CustomPadding({Key? key, required Widget child, required this.padding})
      : super(child: child, key: key);
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomPadding(padding: padding);
  }
}

class CustomRenderBox extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    final path = Path();
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;
    path.lineTo(offset.dx + 200, offset.dy + 200);
    context.canvas.drawPath(path, paint);
  }
}

class RenderCustomPadding extends RenderShiftedBox {
  final EdgeInsets padding;
  RenderCustomPadding({RenderBox? child, required this.padding}) : super(child);

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints.loosen());
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Offset(padding.left, padding.top);
      size = constraints.smallest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      context.paintChild(child!, childParentData.offset + offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return true;
  }

  // @override
  // Size computeDryLayout(BoxConstraints constraints) {
  //   return constraints.smallest;
  // }
}

class CustomParentData extends BoxParentData {}

class CustomColumn extends MultiChildRenderObjectWidget {
  CustomColumn({required List<Widget> children, Key? key})
      : super(children: children, key: key);
  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderColumn();
  }
}

class CustomRenderColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CustomCoulmnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomCoulmnParentData> {
  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = CustomCoulmnParentData();
  }

  @override
  void performLayout() {
    RenderBox? child = firstChild;
    double width = 0;
    double height = 0;
    while (child != null) {
      final CustomCoulmnParentData childParentData =
          child.parentData! as CustomCoulmnParentData;
      final _constraint = constraints.loosen();
      child.layout(_constraint, parentUsesSize: true);
      height += _constraint.maxHeight;
      width += constraints.maxWidth;
      childParentData.offset = Offset(0, child.size.height);
      child = childParentData.nextSibling;
    }
    size = constraints.tighten(width: width, height: height).smallest;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    print(result.path);
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final CustomCoulmnParentData childParentData =
          child.parentData! as CustomCoulmnParentData;
      child.paint(context, offset + childParentData.offset);
      child = childParentData.nextSibling;
    }
  }
}

class CustomCoulmnParentData extends ContainerBoxParentData<RenderBox> {}

class CustomRenderSliver extends RenderSliver with RenderObjectWithChildMixin {
  @override
  void performLayout() {
    geometry;
  }
}
