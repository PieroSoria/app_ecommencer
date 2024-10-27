import 'dart:async';

import 'package:app_ecommencer/features/home/data/models/products_model.dart';
import 'package:app_ecommencer/features/home/domain/usecases/add_producto_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/get_list_product_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetListProductUsecase getListProductUsecase;
  final AddProductoUsecase addProductoUsecase;
  HomeBloc(this.getListProductUsecase, this.addProductoUsecase)
      : super(HomeState.initialState()) {
    on<_OnGetlistProduct>(_ongetlistProduct);
    on<_OnAddProducto>(_onAddProduct);
  }

  void _ongetlistProduct(
      _OnGetlistProduct event, Emitter<HomeState> emit) async {
    final data = await getListProductUsecase();
    emit(state.copyWith(listproduct: data));
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
      final list = await getListProductUsecase();
      emit(state.copyWith(listproduct: list));
    }
  }
}
