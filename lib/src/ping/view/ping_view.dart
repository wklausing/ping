import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping/src/ping/cubit/ping_cubit.dart';

class PingView extends StatelessWidget {
  const PingView();

  @override
  Widget build(BuildContext context) {
    //final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<PingCubit, int>(builder: (context, state) {
          return Text('Foo');
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Inside BlocBuilder')),
            ElevatedButton(
                onPressed: () => {
                      context.read<PingCubit>().foo(),
                    },
                child: Text('Ping')),
          ],
        )
      ],
    ));
  }
}
