import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:renderobjecttut/renderobjects/custom_render_proxy.dart';

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
      home: const SliverHomePage(),
    );
  }
}

class BoxHomePage extends StatefulWidget {
  const BoxHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<BoxHomePage> createState() => _BoxHomePageState();
}

class _BoxHomePageState extends State<BoxHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("AASASSKJKJ"),
          const Text("AAAA"),
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
          //SliverPadding(padding: padding),
        ],
      ),
    );
  }
}

class SliverHomePage extends StatefulWidget {
  const SliverHomePage({Key, key}) : super(key: key);

  @override
  State<SliverHomePage> createState() => _SliverHomePageState();
}

class _SliverHomePageState extends State<SliverHomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: CustomHeaderDelegate(),
        ),
        SliverFillRemaining(
          child: Container(
            color: Colors.green,
            child: const Text("Fill remainingggg"),
          ),
        ),
        //SliverPadding(padding: padding),
      ],
    );
  }
}

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _maxExtent = kToolbarHeight * 5;
  final double _minExtent = kToolbarHeight;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var _currentExtent = _maxExtent - shrinkOffset;
    var allowableSrollextent = _maxExtent - _minExtent;

    print(_currentExtent);

    bool isShinkedToToolbar = _currentExtent <= _minExtent;
    final _intValue =
        interpolationCalulator(0, allowableSrollextent, 0, 1, _currentExtent);

    print(_intValue);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: _currentExtent,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Align(
        alignment: Alignment(0, 0),
        child: Text("data"),
      ),
    );
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant CustomHeaderDelegate oldDelegate) {
    return true;
  }
}

double interpolationCalulator(
    double x1, double y1, double x2, double y2, double value) {
  final _intValue = y1 + ((value - x1) / (x2 - x1)) * (y2 - y1);
  return _intValue;
}
