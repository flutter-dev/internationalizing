import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: DemoLocalizations.of(context).taskTitle,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: DemoLocalizations.of(context).titleBarTitle),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DemoLocalizationsDelegate.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 30)),
        lastDate: new DateTime.now().add(new Duration(days: 30))).then((v) {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              DemoLocalizations.of(context).clickTop,
            ),
            new Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: DemoLocalizations.of(context).inc,
        child: new Icon(Icons.add),
      ),
    );
  }
}

class DemoLocalizations {

  final Locale locale;

  DemoLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'task title': 'Flutter Demo',
      'titlebar title': 'Flutter Demo Home Page',
      'click tip': 'You have pushed the button this many times:',
      'inc':'Increment'
    },
    'zh': {
      'task title': 'Flutter 示例',
      'titlebar title': 'Flutter 示例主页面',
      'click tip': '你一共点击了这么多次按钮：',
      'inc':'增加'
    }
  };

  get taskTitle{
    return _localizedValues[locale.languageCode]['task title'];
  }

  get titleBarTitle{
    return _localizedValues[locale.languageCode]['titlebar title'];
  }

  get clickTop{
    return _localizedValues[locale.languageCode]['click tip'];
  }

  get inc{
    return _localizedValues[locale.languageCode]['inc'];
  }

  static DemoLocalizations of(BuildContext context){
    return Localizations.of(context, DemoLocalizations);
  }
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations>{

  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','zh'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return new SynchronousFuture<DemoLocalizations>(new DemoLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) {
    return false;
  }

  static DemoLocalizationsDelegate delegate = const DemoLocalizationsDelegate();
}