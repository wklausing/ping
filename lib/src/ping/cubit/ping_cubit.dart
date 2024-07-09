import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PingCubit extends Cubit<PingState> {
  List<Ping> pings = [];
  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();

  PingCubit() : super(InitPingState(pings: [], animatedListKey: null));

  void addPing() {
    pings.add(Ping(6.0));
    animatedListKey.currentState?.insertItem(0);
    emit(InitPingState(pings: pings, animatedListKey: animatedListKey));
  }
}

abstract class PingState {
  List<Ping> pings = [];

  PingState(this.pings);
}

class InitPingState extends PingState {
  final GlobalKey<AnimatedListState>? _animatedListKey;

  InitPingState({
    required List<Ping> pings,
    GlobalKey<AnimatedListState>? animatedListKey,
  })  : _animatedListKey = animatedListKey,
        super(pings);

  get animatedListKey => _animatedListKey;
}

class ActivePingState extends PingState {
  ActivePingState(super.pings);
}

class InactivePingState extends PingState {
  InactivePingState(super.pings);
}

class Ping {
  late double latency;

  Ping(this.latency);
}
