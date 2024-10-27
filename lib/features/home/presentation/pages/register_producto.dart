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
    return Scaffold(
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
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    final product = ProductsModel(
                      id: 0,
                      name: homebloc.nameproduct.text,
                      description: homebloc.descriptionproduct.text,
                      precio: double.parse(homebloc.precioproduct.text),
                      imagen: null,
                      createdAt: DateTime.now(),
                    );
                    homebloc.add(
                      HomeEvent.onAddProduct(product: product),
                    );
                    context.pop();
                  }
                },
                child: Text("Guardar Producto"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
