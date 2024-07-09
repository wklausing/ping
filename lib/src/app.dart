import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping/src/ping/cubit/ping_cubit.dart';

import 'ping/view/ping_view.dart';

class PingApp extends MaterialApp {
  const PingApp({super.key}) : super(home: const PingPage());
}

class PingPage extends StatelessWidget {
  const PingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PingCubit(),
      child: const PingView(),
    );
  }
}
