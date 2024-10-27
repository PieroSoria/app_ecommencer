part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  factory HomeEvent.onGetlistProduct() => _OnGetlistProduct();
  factory HomeEvent.onGetProduct({int? id}) => _OnGetProduct(id: id);
  factory HomeEvent.onUpdatedProduct({ProductsModel? productmodel}) =>
      _OnUpdateProduct(productsModel: productmodel);
  factory HomeEvent.onDeleteProduct({int? id}) => _OnDeleteProduct(id: id);
  factory HomeEvent.onAddProduct({ProductsModel? product}) =>
      _OnAddProducto(productsModel: product);

  @override
  List<Object?> get props => [];
}

class _OnDeleteProduct implements HomeEvent {
  final int? id;

  _OnDeleteProduct({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnUpdateProduct implements HomeEvent {
  final ProductsModel? productsModel;

  _OnUpdateProduct({required this.productsModel});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnGetProduct implements HomeEvent {
  final int? id;

  _OnGetProduct({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnAddProducto implements HomeEvent {
  final ProductsModel? productsModel;

  _OnAddProducto({required this.productsModel});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnGetlistProduct implements HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
