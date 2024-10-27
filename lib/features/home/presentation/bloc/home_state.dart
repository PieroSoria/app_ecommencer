part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<ProductsModel>? listproduct;
  const HomeState({this.listproduct});

  factory HomeState.initialState() => const HomeState(
        listproduct: [],
      );

  HomeState copyWith({List<ProductsModel>? listproduct}) {
    return HomeState(
      listproduct: listproduct ?? this.listproduct,
    );
  }

  @override
  List<Object?> get props => [listproduct];
}
