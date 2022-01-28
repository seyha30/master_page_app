import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          var pageData = PageData();
          return pageData;
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Set required page same as list length in left of VerticalSplitView
  List<Widget> pages = const [
    Text('Page1'),
    Text('Page2'),
    Text('Page3'),
    Text('Page4'),
    Text('Page5'),
    Text('Page6'),
    Text('Page7'),
    Text('Page8'),
    Text('Page9'),
    Text('Page10'),
    Text('Page11'),
    Text('Page12'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: VerticalSplitView(
          left: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      // Set the current page for change page on the right side.
                      Provider.of<PageData>(context, listen: false)
                          .setCurrentTab(index);
                    },
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //Center Column contents vertically,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                  leading: Image.network(
                                      "https://picsum.photos/200/300"),
                                  title: Text("Title"),
                                  subtitle: Text("Subtitle")),
                            ),
                            //Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
          right: Consumer<PageData>(
            builder: (context, pageData, child) {
              return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: IndexedStack(
                    children: pages,
                    index: pageData.currentPage,
                  ));
            },
          ),
          key: null,
        ),
      ),
    );
  }
}

class VerticalSplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double ratio;

  const VerticalSplitView(
      {Key? key, required this.left, required this.right, this.ratio = 0.5})
      : assert(left != null),
        assert(right != null),
        assert(ratio >= 0),
        assert(ratio <= 1),
        super(key: key);

  @override
  _VerticalSplitViewState createState() => _VerticalSplitViewState();
}

class _VerticalSplitViewState extends State<VerticalSplitView> {
  final _dividerWidth = 16.0;
  //from 0-1
  late double _ratio;
  late double _maxWidth = 10000;

  get _width1 => _ratio * _maxWidth;

  get _width2 => (1 - _ratio) * _maxWidth;

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio <= 1);
      assert(_ratio >= 0);
      if (_maxWidth == null) _maxWidth = constraints.maxWidth - _dividerWidth;
      if (_maxWidth != constraints.maxWidth) {
        _maxWidth = constraints.maxWidth - _dividerWidth;
      }

      return SizedBox(
        width: constraints.maxWidth,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: _width1,
              child: widget.left,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: SizedBox(
                width: _dividerWidth,
                height: constraints.maxHeight,
                child: RotationTransition(
                  child: Icon(Icons.drag_handle),
                  turns: AlwaysStoppedAnimation(0.25),
                ),
              ),
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  _ratio += details.delta.dx / _maxWidth;
                  if (_ratio > 1)
                    _ratio = 1;
                  else if (_ratio < 0.0) _ratio = 0.0;
                });
              },
            ),
            SizedBox(
              width: _width2,
              child: widget.right,
            ),
          ],
        ),
      );
    });
  }
}
