import 'dart:async';

class Debouncer {
  Debouncer({required this.milliseconds});
  final int milliseconds;
  Timer? _timer;

  void run(void Function() action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
