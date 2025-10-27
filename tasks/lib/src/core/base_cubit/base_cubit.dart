// ignore_for_file: use_super_parameters

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/app/di_service.dart';
import 'package:tasks/src/core/disposable/disposable.dart';

class BaseCubit<State> extends Cubit<State> {
  BaseCubit(initialState) : super(initialState) {
    initState();
  }

  void initState() {}
}

mixin AdaptiveCubit<State> on BaseCubit<State> {
  static final List<void Function(dynamic change)> _listeners = [];

  @override
  void initState() {
    _listeners.add(onGlobalChange);
    super.initState();
  }

  @override
  Future<void> close() {
    _listeners.remove(onGlobalChange);
    return super.close();
  }

  @override
  void onChange(Change<State> change) {
    super.onChange(change);
    _dispatch(change.nextState);
  }

  void _dispatch(change) {
    for (final listener in _listeners) {
      listener(change);
    }
  }

  void onGlobalChange(change) {}
}

mixin ResetLazySingleton<_Cubit extends Object, State> on Cubit<State> {
  @override
  Future<void> close() {
    di.resetLazySingleton<_Cubit>();
    return super.close();
  }
}

mixin DisposableCubit<State> on Cubit<State> {
  List<Disposable> get disposables => [];

  @override
  Future<void> close() {
    for (final element in disposables) {
      element.dispose();
    }
    return super.close();
  }
}
