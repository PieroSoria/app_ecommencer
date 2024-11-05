import 'dart:async';
import 'dart:io';

import 'package:app_ecommencer/features/home/data/models/products_model.dart';
import 'package:app_ecommencer/features/home/domain/usecases/add_producto_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/delete_product_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/get_list_product_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/update_producto_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    on<_OnSelectImage>(_onSelectImage);
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
    try {
      final data = await addProductoUsecase(params: event.productsModel);
      if (data != null) {
        cleantextEdit();
        emit(state.copyWith(productStatus: ProductStatus.addproduct));
        final listData = await getListProductUsecase();
        emit(state.copyWith(
            listproduct: listData, productStatus: ProductStatus.none));
      }
    } catch (e) {
      debugPrint("el error es $e");
    }
  }

  File? imagen;

  void cleantextEdit() {
    nameproduct.clear();
    descriptionproduct.clear();
    precioproduct.clear();
    imagen = null;
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

      // Obtener la lista actualizada
      final listData = await getListProductUsecase();
      emit(state.copyWith(
          listproduct: listData, productStatus: ProductStatus.none));
    }
  }

  void _onSelectImage(_OnSelectImage event, Emitter<HomeState> emit) async {
    final data = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (data != null) {
      final result = File(data.path);
      imagen = File(data.path);
      emit(state.copyWith(imageurl: result));
    }
  }
}
