import 'package:flutter_bloc/flutter_bloc.dart';

class PingCubit extends Cubit<int> {
  PingCubit() : super(0);

  void foo() {
    print('Well');
    emit(state + 1);
  }
}
