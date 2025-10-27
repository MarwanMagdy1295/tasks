import 'package:flutter/foundation.dart';

class Disposable {
  final VoidCallback? _onDispose;

  Disposable({VoidCallback? onDispose}) : _onDispose = onDispose;

  void dispose() {
    _onDispose?.call();
  }
}
