import 'dart:async';

import 'package:app_ecommencer/features/home/data/models/products_model.dart';
import 'package:app_ecommencer/features/home/domain/usecases/add_producto_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/delete_product_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/get_list_product_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/update_producto_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetListProductUsecase getListProductUsecase;
  final AddProductoUsecase addProductoUsecase;
  final UpdateProductoUsecase updateProductoUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  HomeBloc(
    this.getListProductUsecase,
    this.addProductoUsecase,
    this.updateProductoUsecase,
    this.deleteProductUsecase,
  ) : super(HomeState.initialState()) {
    on<_OnGetlistProduct>(_ongetlistProduct);
    on<_OnAddProducto>(_onAddProduct);
    on<_OnUpdateProduct>(_onUpdateProduct);
    on<_OnDeleteProduct>(_onDeleteProduct);
  }

  void _ongetlistProduct(
    _OnGetlistProduct event,
    Emitter<HomeState> emit,
  ) async {
    final data = await getListProductUsecase();
    emit(state.copyWith(listproduct: data, productStatus: ProductStatus.none));
  }

  final nameproduct = TextEditingController();
  final descriptionproduct = TextEditingController();
  final precioproduct = TextEditingController();

  void _onAddProduct(_OnAddProducto event, Emitter<HomeState> emit) async {
    final data = await addProductoUsecase(params: event.productsModel);
    if (data != null) {
      nameproduct.clear();
      descriptionproduct.clear();
      precioproduct.clear();
      emit(state.copyWith(productStatus: ProductStatus.addproduct));
    }
  }

  void cleantextEdit() { 
    nameproduct.clear();
    descriptionproduct.clear();
    precioproduct.clear();
  }

  void _onUpdateProduct(
    _OnUpdateProduct event,
    Emitter<HomeState> emit,
  ) async {
    final update = await updateProductoUsecase(params: event.productsModel);
    if (update != null) {
      emit(state.copyWith(productStatus: ProductStatus.editproduct));
    }
  }

  void _onDeleteProduct(_OnDeleteProduct event, Emitter<HomeState> emit) async {
    final delete = await deleteProductUsecase(params: event.id);
    if (delete) {
      emit(state.copyWith(productStatus: ProductStatus.deleteproduct));
    }
  }
}
