import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_repo/src/ui/pages/list_page.dart';
import 'package:learning_repo/src/ui/pages/login.dart';

import '../../bloc/favorites/favorites_bloc.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Favorites"), actions: <Widget>[
          IconButton(icon: Icon(Icons.ac_unit), onPressed: () {})
        ]),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
          if (state is AuthenticateToGetYourFavorites) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Login(),
                ),
              );
            });
          }
          if (state is FavoritesLoaded)
            return Align(
              alignment: Alignment.center,
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ListViewPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text("go to list page " + state.data),
                ),
              ),
            );
          return Center(
            child: Text('loading'),
          );
        }),
      ),
    );
  }
}
