import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final ScrollController _scrollControllerLeft = ScrollController();
  final ScrollController _scrollControllerFixed = ScrollController();
  final ScrollController _scrollControllerRight = ScrollController();
  final ScrollController _scrollController = ScrollController();
  bool isLeft = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollControllerFixed.jumpTo(_scrollController.offset);
    });
    _scrollControllerLeft.addListener(
      () {
        if (!isLeft) {
          isLeft = true;
          return;
        }
        print(_scrollControllerLeft.offset);
        print(_scrollControllerRight.offset);
        // Scroll the right listview in the reverse direction
        if (_scrollControllerRight.hasClients) {
          _scrollControllerRight.jumpTo(
              _scrollControllerLeft.position.maxScrollExtent - _scrollControllerLeft.offset);
        }
      },
    );
    _scrollControllerRight.addListener(() {
      if (isLeft) {
        isLeft = false;
        return;
      }
      print(_scrollControllerLeft.offset);
      print(_scrollControllerRight.offset);
      if (_scrollControllerLeft.hasClients) {
        _scrollControllerLeft.jumpTo(
            _scrollControllerRight.position.maxScrollExtent - _scrollControllerRight.offset);
      }
    });
  }

  @override
  void dispose() {
    _scrollControllerLeft.dispose();
    _scrollControllerRight.dispose();
    _scrollController.dispose();
    _scrollControllerFixed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(width);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Container(
                width: (width - 120) / 2,
                child: ListView.builder(
                  controller: _scrollControllerLeft,
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return _buildColumn(index);
                  },
                ),
              ),
              Container(
                width: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return _buildFixedColumn('CF ${index + 8}');
                  },
                ),
              ),
              Container(
                width: (width - 120) / 2,
                child: ListView.builder(
                  controller: _scrollControllerRight,
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    index = 7 - index;

                    return _buildColumn(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumn(int text) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: List.generate(20, (index) {
            return Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text('$text - $index'),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildFixedColumn(String text) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: SingleChildScrollView(
        controller: _scrollControllerFixed,
        child: Column(
          children: List.generate(
            20,
            (index) => Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text('$text -  $index'),
            ),
          ),
        ),
      ),
    );
  }
}
