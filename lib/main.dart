import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_repo/src/bloc/auth/auth_bloc.dart';
import 'package:learning_repo/src/bloc/favorites/favorites_bloc.dart';
import 'package:learning_repo/src/ui/pages/account.dart';
import 'package:learning_repo/src/ui/pages/favorites.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
  // String _currentPage = "Home";
  // List<String> pageKeys = ["Home", "Favorites", "Account"];
  // Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
  //   "Home": GlobalKey<NavigatorState>(),
  //   "Favorites": GlobalKey<NavigatorState>(),
  //   "Account": GlobalKey<NavigatorState>(),
  // };
  PersistentTabController _controller;
  bool _hideNavBar;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }
  // void _selectTab(String tabItem, int index) {
  //   if (tabItem == _currentPage) {
  //     if (tabItem != pageKeys[1])
  //       _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
  //   } else {
  //     setState(() {
  //       _currentPage = pageKeys[index];
  //       _selectedIndex = index;
  //     });
  //   }
  // }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: "Home",
        activeColor: Color(0xffab7c39),
        inactiveColor: Color(0xffb5b5b5),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.favorite_border,
        ),
        title: "Favorites",
        activeColor: Color(0xffab7c39),
        inactiveColor: Color(0xffb5b5b5),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.more_horiz,
        ),
        title: "More",
        activeColor: Color(0xffab7c39),
        inactiveColor: Color(0xffb5b5b5),
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      Home(),
      BlocProvider<FavoritesBloc>(
        create: (_) =>
            FavoritesBloc(context.bloc<AuthBloc>())..add(GetFavorites()),
        child: Favorites(),
      ),
      Account(onTap: () {
        debugPrint('go home');
        _controller.jumpToTab(0);
        setState(() {});
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: _controller,
        screens: _buildScreens(),
        confineInSafeArea: true,
        items: _navBarsItems(),
        // hideNavigationBar:
        //     MediaQuery.of(context).viewInsets.bottom > 0 ? true : false,
        // itemCount: 3,
        // backgroundColor: Colors.white,
        // handleAndroidBackButtonPress: true,
        // resizeToAvoidBottomInset: true,
        // stateManagement: true,
        // hideNavigationBarWhenKeyboardShows: true,
        // hideNavigationBar: _hideNavBar,
        // decoration: NavBarDecoration(
        //     colorBehindNavBar: Colors.indigo,
        //     borderRadius: BorderRadius.circular(20.0)),
        // popAllScreensOnTapOfSelectedTab: true,
        // itemAnimationProperties: ItemAnimationProperties(
        //   duration: Duration(milliseconds: 400),
        //   curve: Curves.ease,
        // ),
        // screenTransitionAnimation: ScreenTransitionAnimation(
        //   animateTabTransition: true,
        //   curve: Curves.ease,
        //   duration: Duration(milliseconds: 200),
        // ),
        onItemSelected: (int) {
          setState(
              () {}); // This is required to update the nav bar if Android back button is pressed
        },
        // customWidget: CustomNavBarWidget(
        //   items: _navBarsItems(),
        //   onItemSelected: (index) {
        //     setState(() {
        //       _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
        //     });
        //   },
        //   selectedIndex: _controller.index,
        // ),
        navBarStyle:
            NavBarStyle.style8, // Choose the nav bar style with this property
      ),
      //   body: Stack(children: <Widget>[
      //     _buildOffstageNavigator("Home"),
      //     _buildOffstageNavigator("Favorites"),
      //     _buildOffstageNavigator("Account"),
      //   ]),
      //   bottomNavigationBar: BottomNavigationBar(
      //     selectedItemColor: Colors.blueAccent,
      //     onTap: (int index) {
      //       _selectTab(pageKeys[index], index);
      //     },
      //     currentIndex: _selectedIndex,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: new Icon(Icons.looks_one),
      //         title: new Text('Home'),
      //       ),
      //       BottomNavigationBarItem(
      //         icon: new Icon(Icons.looks_two),
      //         title: new Text('Favorites'),
      //       ),
      //       BottomNavigationBarItem(
      //         icon: new Icon(Icons.looks_3),
      //         title: new Text('Account'),
      //       ),
      //     ],
      //     type: BottomNavigationBarType.fixed,
      //   ),
    );
  }

//   Widget _buildOffstageNavigator(String tabItem) {
//     return Offstage(
//       offstage: _currentPage != tabItem,
//       child: TabNavigator(
//         navigatorKey: _navigatorKeys[tabItem],
//         tabItem: tabItem,
//         onTap: () => _selectTab('Home', 0),
//       ),
//     );
//   }
// }

// class TabNavigator extends StatelessWidget {
//   TabNavigator({this.navigatorKey, this.tabItem, this.onTap});
//   final GlobalKey<NavigatorState> navigatorKey;
//   final String tabItem;
//   final VoidCallback onTap;
//   // final _authBloc = AuthBloc();
//   @override
//   Widget build(BuildContext context) {
//     Widget child;
//     if (tabItem == "Home")
//       child = Home();
//     else if (tabItem == "Favorites")
//       child = BlocProvider<FavoritesBloc>(
//         create: (_) =>
//             FavoritesBloc(context.bloc<AuthBloc>())..add(GetFavorites()),
//         child: Favorites(),
//       );
//     else if (tabItem == "Account") child = Account(onTap: () => onTap());
//     //     BlocProvider<AuthBloc>(
//     //   create: (_) => _authBloc..add(IsAuthenticated()),
//     //   child: Account(onTap: () => onTap()),
//     // );
//
//     return Navigator(
//       key: navigatorKey,
//       onGenerateRoute: (routeSettings) {
//         return MaterialPageRoute(builder: (context) => child);
//       },
//     );
//   }
}

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  CustomNavBarWidget({
    Key key,
    this.selectedIndex,
    @required this.items,
    this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                size: 26.0,
                color: isSelected ? item.activeColor : item.inactiveColor,
              ),
              child: item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                item.title,
                style: TextStyle(
                  color: isSelected ? item.activeColor : item.inactiveColor,
                  fontFamily: 'HelveticaNeueLTArabic-Roman',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
              color: Color(0x1f000000),
              offset: Offset(0, 0),
              blurRadius: 20,
              spreadRadius: 0)
        ],
      ),
      child: Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            var index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  this.onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
