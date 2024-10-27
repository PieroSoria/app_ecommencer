part of 'themes_bloc.dart';

sealed class ThemesState extends Equatable {
  const ThemesState();
  
  @override
  List<Object> get props => [];
}

final class ThemesInitial extends ThemesState {}
