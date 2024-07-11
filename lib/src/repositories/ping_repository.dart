import 'package:dart_ping/dart_ping.dart';

class PingRepository {
  String foo = 'Wilke';
  final ping = Ping('google.com', count: 5);

  void pinging() async {
    ping.stream.listen((event) {
      print(event);
    });
  }

  Stream<PingData> initPingStream(String url) async* {
    Ping ping = Ping(url);
    await for (final response in ping.stream) {
      print('pingURL');
      yield response;
    }
  }
}
