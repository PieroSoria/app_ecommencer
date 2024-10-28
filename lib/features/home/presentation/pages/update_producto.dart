import 'package:app_ecommencer/core/routes/app_routes.dart';
import 'package:app_ecommencer/features/home/data/models/products_model.dart';
import 'package:app_ecommencer/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_ecommencer/features/home/presentation/widgets/input_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateProducto extends StatefulWidget {
  final Map<String, dynamic> data;
  const UpdateProducto({super.key, required this.data});

  @override
  State<UpdateProducto> createState() => _UpdateProductoState();
}

class _UpdateProductoState extends State<UpdateProducto> {
  @override
  void initState() {
    debugPrint("el dato que pasamos es ${widget.data}");
    context.read<HomeBloc>().nameproduct.text = widget.data['name'].toString();
    context.read<HomeBloc>().descriptionproduct.text =
        widget.data['description'].toString();
    context.read<HomeBloc>().precioproduct.text =
        widget.data['precio'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homebloc = context.read<HomeBloc>();

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        context.read<HomeBloc>().cleantextEdit();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputCustom(
                controller: homebloc.nameproduct,
                title: "el nombre del producto",
              ),
              InputCustom(
                controller: homebloc.descriptionproduct,
                title: "el nombre del producto",
              ),
              InputCustom(
                controller: homebloc.precioproduct,
                title: "el nombre del producto",
              ),
              ElevatedButton(
                onPressed: () {
                  homebloc.add(
                    HomeEvent.onUpdatedProduct(
                      productmodel: ProductsModel(
                        id: int.parse(widget.data['id'].toString()),
                        name: homebloc.nameproduct.text,
                        description: homebloc.descriptionproduct.text,
                        precio: double.parse(homebloc.precioproduct.text),
                        imagen: null,
                        createdAt: null,
                      ),
                    ),
                  );
                  context.pop();
                },
                child: Text(
                  "Actualizar Datos",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
