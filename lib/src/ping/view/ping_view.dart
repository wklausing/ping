import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping/src/ping/cubit/ping_cubit.dart';

class PingView extends StatelessWidget {
  const PingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<PingCubit, PingState>(
            builder: (context, state) {
              if (state is InitPingState) {
                return listOfLearningCardsAnimated(context, state);
              } else if (state is ActivePingState) {
                return Center(
                  child: Text('ActivePingState'),
                );
              } else if (state is InactivePingState) {
                return Center(
                  child: Text('InactivePingState'),
                );
              } else {
                return Center(
                  child: Text('Error z45424326'),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Rückseite',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<PingCubit>().addPing();
                  },
                  child: Text('Ping'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget listOfLearningCardsAnimated(BuildContext context, InitPingState state) {
  print(state.pings.length.toString());
  return Expanded(
    child: AnimatedList(
      reverse: true,
      key: state.animatedListKey,
      initialItemCount: state.pings.length,
      padding: EdgeInsets.all(4),
      itemBuilder: (context, index, animation) {
        Ping ping = state.pings[index];
        return SizeTransition(
          sizeFactor: animation,
          child: FractionallySizedBox(
            widthFactor: 0.99,
            child: Card(
              shape: Border(),
              margin: EdgeInsets.all(4.0),
              child: Text(ping.latency.toString()),
            ),
          ),
        );
      },
    ),
  );
}
