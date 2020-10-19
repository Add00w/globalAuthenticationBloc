import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_repo/src/ui/pages/login.dart';

import '../../bloc/auth/auth_bloc.dart';

class Account extends StatelessWidget {
  const Account({Key key, this.onTap}) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Account"), actions: <Widget>[
          IconButton(icon: Icon(Icons.ac_unit), onPressed: () {}),
        ]),
        body: BlocBuilder<AuthBloc, AuthState>(
          cubit: context.bloc<AuthBloc>(),
          builder: (context, state) {
            debugPrint(state.toString());
            if (state is UnAuthenticatedState)
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Login(),
                  ),
                );
              });
            if (state is AuthenticatedState)
              return Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () => onTap(),
                      child: Text("Switch tab to home"),
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app_sharp),
                      onPressed: () => context.bloc<AuthBloc>().add(
                            SignOut(),
                          ),
                    ),
                  ],
                ),
              );

            return Center(
              child: Text('looding...'),
            );
          },
        ),
      ),
    );
  }
}
