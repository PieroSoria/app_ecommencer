import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'themes_event.dart';
part 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc() : super(ThemesInitial()) {
    on<ThemesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
