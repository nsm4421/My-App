import 'package:flutter/material.dart';
import 'package:my_app/presentation/bloc/auth/auth.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _View();
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  _handleSignOut() {
    context.read<AuthenticationBloc>().add(SignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(onPressed: _handleSignOut, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
