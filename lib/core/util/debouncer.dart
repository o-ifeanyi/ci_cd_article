import 'dart:async';

class Debouncer {
  final int delayInMilliseconds;
  Timer? _timer;

  Debouncer({this.delayInMilliseconds = 500});

  call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delayInMilliseconds), action);
  }
}
