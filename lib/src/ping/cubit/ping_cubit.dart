import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping/src/repositories/ping_repository.dart';

class PingCubit extends Cubit<PingState> {
  List<Ping> pings = [];
  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();
  PingRepository pingRepo = PingRepository();
  StreamSubscription? streamSubscription;
  String lastURL = 'www.google.de';

  PingCubit() : super(InitPingState(pings: [], animatedListKey: null)) {
    initPingStream(lastURL);
  }

  void initPingStream(String? url) {
    url ??= lastURL;

    if (streamSubscription != null) {
      streamSubscription!.cancel();
      streamSubscription = null;
    }

    Stream streamFoo = pingRepo.initPingStream(url);
    streamSubscription = streamFoo.listen((event) {
      print(event.toString());
      pings.insert(0, Ping(event.toString()));
      animatedListKey.currentState?.insertItem(0);
      emit(ActivePingState(pings: pings, animatedListKey: animatedListKey));
    });
  }

  void pausePingStream() {
    if (streamSubscription != null) {
      streamSubscription!.pause();
    }
    emit(InactivePingState(pings: pings, animatedListKey: animatedListKey));
  }
}

abstract class PingState {
  List<Ping> pings;
  final GlobalKey<AnimatedListState>? animatedListKey;

  PingState({
    required this.pings,
    this.animatedListKey,
  });
}

class InitPingState extends PingState {
  InitPingState({required super.pings, super.animatedListKey});
}

class ActivePingState extends PingState {
  ActivePingState({required super.pings, super.animatedListKey});
}

class InactivePingState extends PingState {
  InactivePingState({required super.pings, super.animatedListKey});
}

class Ping {
  late String status;

  Ping(this.status);
}
