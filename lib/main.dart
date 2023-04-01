import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("AASASSKJKJ"),
          // Padding(padding: padding),
          CustomPadding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .2,
            ),
          ),
          const Text("AASASSKJKJ"),
        ],
      ),
    );
  }
}

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

class CustomRenderColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CustomCoulmnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomCoulmnParentData> {
  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = CustomCoulmnParentData();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final CustomCoulmnParentData childParentData =
          child.parentData! as CustomCoulmnParentData;
      child.paint(context, offset + childParentData.offset);
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
  }
}

class CustomCoulmnParentData extends ContainerBoxParentData<RenderBox> {}
