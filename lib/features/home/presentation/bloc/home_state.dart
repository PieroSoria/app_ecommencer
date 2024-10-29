part of 'home_bloc.dart';

enum ProductStatus {
  addproduct,
  editproduct,
  deleteproduct,
  none,
}

class HomeState extends Equatable {
  final List<ProductsModel>? listproduct;
  final ProductStatus? productStatus;
  const HomeState({this.listproduct, this.productStatus});

  factory HomeState.initialState() => const HomeState(
        listproduct: [],
        productStatus: ProductStatus.none,
      );

  HomeState copyWith({
    List<ProductsModel>? listproduct,
    ProductStatus? productStatus,
  }) {
    return HomeState(
      listproduct: listproduct ?? this.listproduct,
      productStatus: productStatus ?? this.productStatus,
    );
  }

  @override
  List<Object?> get props => [listproduct, productStatus];
}

extension HomeStateX on HomeState {
  bool get saveProduct => productStatus == ProductStatus.addproduct;
  bool get editproduct => productStatus == ProductStatus.editproduct;
  bool get deleteproduct => productStatus == ProductStatus.deleteproduct;
}
