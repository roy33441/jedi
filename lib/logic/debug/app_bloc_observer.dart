import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase base, Change change) {
    print(change);
    super.onChange(base, change);
  }

  @override
  void onClose(BlocBase base) {
    super.onClose(base);
  }

  @override
  void onCreate(BlocBase base) {
    print(base);
    super.onCreate(base);
  }

  @override
  void onError(BlocBase base, Object error, StackTrace stackTrace) {
    super.onError(base, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}
