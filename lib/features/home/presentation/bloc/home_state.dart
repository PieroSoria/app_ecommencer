part of 'home_bloc.dart';

enum ProductStatus {
  addproduct,
  editproduct,
  deleteproduct,
  loading,
  none,
}

class HomeState extends Equatable {
  final List<ProductsModel>? listproduct;
  final ProductStatus? productStatus;
  final File? imageurl;
  const HomeState({this.listproduct, this.productStatus, this.imageurl});

  factory HomeState.initialState() => const HomeState(
        listproduct: [],
        productStatus: ProductStatus.none,
        imageurl: null,
      );

  HomeState copyWith({
    List<ProductsModel>? listproduct,
    ProductStatus? productStatus,
    File? imageurl,
  }) {
    return HomeState(
      listproduct: listproduct ?? this.listproduct,
      productStatus: productStatus ?? this.productStatus,
      imageurl: imageurl ?? this.imageurl,
    );
  }

  @override
  List<Object?> get props => [listproduct, productStatus, imageurl];
}

extension HomeStateX on HomeState {
  bool get saveProduct => productStatus == ProductStatus.addproduct;
  bool get editproduct => productStatus == ProductStatus.editproduct;
  bool get deleteproduct => productStatus == ProductStatus.deleteproduct;
  bool get isloading => productStatus == ProductStatus.loading;
  bool get listproductEmpy => listproduct!.firstOrNull == null;
}
