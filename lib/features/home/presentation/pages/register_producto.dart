import 'package:app_ecommencer/core/constants/app_constants.dart';
import 'package:app_ecommencer/core/constants/app_images.dart';
import 'package:app_ecommencer/core/routes/app_routes.dart';
import 'package:app_ecommencer/features/home/data/models/products_model.dart';
import 'package:app_ecommencer/features/home/domain/entities/products.dart';
import 'package:app_ecommencer/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_ecommencer/features/home/presentation/pages/home_page.dart';
import 'package:app_ecommencer/features/home/presentation/widgets/input_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProducto extends StatefulWidget {
  const RegisterProducto({super.key});

  @override
  State<RegisterProducto> createState() => _RegisterProductoState();
}

class _RegisterProductoState extends State<RegisterProducto> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final homebloc = context.read<HomeBloc>();
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        homebloc.cleantextEdit();
        context.pop();
      },
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.saveProduct) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("El producto fue cargado"),
                ),
              );
            context.pop();
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputCustom(
                      controller: homebloc.nameproduct,
                      title: 'Nombre de Producto',
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "No puede ser vacio";
                        }
                        return null;
                      },
                    ),
                    InputCustom(
                      controller: homebloc.descriptionproduct,
                      title: 'Descripcion de producto',
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "No puede ser vacio";
                        }
                        return null;
                      },
                    ),
                    InputCustom(
                      controller: homebloc.precioproduct,
                      title: 'Precio del Producto',
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "No puede ser vacio";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () async {
                            homebloc.add(HomeEvent.onSelectImage());
                          },
                          child: Container(
                            width: 300,
                            height: 200,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: homebloc.imagen != null
                                    ? FileImage(homebloc.imagen!)
                                    : const AssetImage(AppImages.logo),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          final product = ProductsModel(
                            id: null,
                            name: homebloc.nameproduct.text,
                            description: homebloc.descriptionproduct.text,
                            precio: double.parse(homebloc.precioproduct.text),
                            imagen: null,
                            createdAt: DateTime.now(),
                          );
                          homebloc
                              .add(HomeEvent.onAddProduct(product: product));
                        }
                      },
                      child: const Text("Guardar Producto"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
