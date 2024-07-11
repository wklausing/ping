import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping/src/repositories/ping_repository.dart';

class PingCubit extends Cubit<PingState> {
  List<Ping> pings = [];
  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();
  PingRepository pingRepo = PingRepository();

  PingCubit() : super(InitPingState(pings: [], animatedListKey: null)) {
    initPingStream('www.google.de');
  }

  void initPingStream(String url) {
    Stream streamFoo = pingRepo.initPingStream(url);
    streamFoo.listen((event) {
      print(event.toString());
      pings.insert(0, Ping(event.toString()));
      animatedListKey.currentState?.insertItem(0);
      emit(InitPingState(pings: pings, animatedListKey: animatedListKey));
    });
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
  late String status;

  Ping(this.status);
}
