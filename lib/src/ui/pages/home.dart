import 'package:flutter/material.dart';
import 'package:learning_repo/src/ui/pages/list_page.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Home"), actions: <Widget>[
          IconButton(icon: Icon(Icons.ac_unit), onPressed: () {})
        ]),
        body: Align(
          alignment: Alignment.center,
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new ListViewPage()));
            },
            child: Text("Switch Page list"),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
