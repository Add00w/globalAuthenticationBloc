import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_repo/src/bloc/auth/auth_bloc.dart';
import 'package:learning_repo/src/bloc/favorites/favorites_bloc.dart';
import 'package:learning_repo/src/ui/pages/account.dart';
import 'package:learning_repo/src/ui/pages/favorites.dart';

import 'src/ui/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc()..add(IsAuthenticated()),
      child: MaterialApp(
        home: App(),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////
/// DIY NAVIGATOR SOLUTION
////////////////////////////////////////////////////////////////////////////
class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Favorites", "Account"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Favorites": GlobalKey<NavigatorState>(),
    "Account": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Home") {
            _selectTab("Home", 0);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Home"),
          _buildOffstageNavigator("Favorites"),
          _buildOffstageNavigator("Account"),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.looks_one),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.looks_two),
              title: new Text('Favorites'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.looks_3),
              title: new Text('Account'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
        onTap: () => _selectTab('Home', 0),
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.onTap});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final VoidCallback onTap;
  // final _authBloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Home")
      child = Home();
    else if (tabItem == "Favorites")
      child = BlocProvider<FavoritesBloc>(
        create: (_) =>
            FavoritesBloc(context.bloc<AuthBloc>())..add(GetFavorites()),
        child: Favorites(),
      );
    else if (tabItem == "Account") child = Account(onTap: () => onTap());
    //     BlocProvider<AuthBloc>(
    //   create: (_) => _authBloc..add(IsAuthenticated()),
    //   child: Account(onTap: () => onTap()),
    // );

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
