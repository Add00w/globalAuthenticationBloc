import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("login")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          debugPrint('===>login:' + state.toString());
          if (state is AuthenticatedState)
            Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          cubit: context.bloc<AuthBloc>(),
          builder: (context, state) {
            return GestureDetector(
              onTap: () => context.bloc<AuthBloc>()..add(Authenticate()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: state is AuthLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text('login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
