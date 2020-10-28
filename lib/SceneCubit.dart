import 'package:bloc/bloc.dart';

/// {@template counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class SceneCubit extends Cubit<String> {
  /// {@macro counter_cubit}
  SceneCubit() : super("Coming Home");

  // Add 1 to the current state.
  void scenetoggle(String mode) => emit(mode);

  void changeState() {
    emit("state");
  }

  /// Subtract 1 from the current state.
 // void decrement() => emit(state);
}