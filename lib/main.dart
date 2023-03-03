import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  bool isFocused = false;
  final String title;
  List<String> filteredTexts = [
    'Sakarya',
    'Ankara',
    'Erzincan Binali Yildirim Universitesi',
    'Ankara yildirim Bayezit Universitesi',
    'Canakkale On Sekiz Mart Universitesi',
  ];
  final List<String> texts = [
    'Sakarya',
    'Ankara',
    'Erzincan Binali Yildirim Universitesi',
    'Ankara yildirim Bayezit Universitesi',
    'Canakkale On Sekiz Mart Universitesi',
  ];

  final TextEditingController textEditingController = TextEditingController();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          AnimatedContainer(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
            height: widget.isFocused ? 150 : 50,
            width: MediaQuery.of(context).size.width * .9,
            duration: Duration(milliseconds: 50),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(),
                  controller: widget.textEditingController,
                  onTap: () {
                    setState(
                      () {
                        widget.isFocused = true;
                      },
                    );
                  },
                  onChanged: (value) => setState(() => setFilteredTexts(value)),
                ),
                Expanded(
                  child: widget.filteredTexts.isEmpty
                      ? Center(
                          child: Text('Bulunamadi'),
                        )
                      : Container(
                          color: Colors.white,
                          child: ListView.separated(
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.isFocused = false;
                                });
                              },
                              child: SizedBox(
                                height: 20,
                                child: Center(
                                  child: Text(widget.filteredTexts[index]),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: widget.filteredTexts.length,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void setFilteredTexts(String entireText) {
    List<String> result = [];
    result.addAll(widget.texts.where((element) => element.toLowerCase().startsWith(entireText.toLowerCase())));
    result.addAll(widget.texts.where((element) => element.toLowerCase().contains(entireText.toLowerCase())));
    widget.filteredTexts = result.toSet().toList();
  }
}
