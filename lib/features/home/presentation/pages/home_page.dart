import 'package:app_ecommencer/core/routes/app_routes.dart';
import 'package:app_ecommencer/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_ecommencer/features/home/presentation/pages/register_producto.dart';
import 'package:app_ecommencer/injector_dependency.dart';
import 'package:app_ecommencer/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    debugPrint("pasa por el init");
    // context.read<HomeBloc>().add(HomeEvent.onGetlistProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: const BodyListProduct(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppRoutes.addproducto);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BodyListProduct extends StatefulWidget {
  const BodyListProduct({super.key});

  @override
  State<BodyListProduct> createState() => _BodyListProductState();
}

class _BodyListProductState extends State<BodyListProduct> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeEvent.onGetlistProduct());
  }

  @override
  Widget build(BuildContext context) {
    final homebloc = context.read<HomeBloc>();
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        debugPrint("Estado del producto: ${state.productStatus}");

        if (state.deleteproduct) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("El producto fue eliminado"),
              ),
            );
        }

        // Asegúrate de que el widget está montado antes de agregar eventos
        if (mounted) {
          homebloc.add(HomeEvent.onGetlistProduct());
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state.listproductEmpy) {
          return const Center(
            child: Text("No se encontró ningún producto"),
          );
        }
        if (state.isloading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: state.listproduct?.length,
          itemBuilder: (context, index) {
            final data = state.listproduct![index];
            return Card(
              child: ListTile(
                onTap: () {},
                title: Text(data.name.toString()),
                subtitle: Text(data.description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.goNamed(
                          AppRoutes.editproducto,
                          extra: data.toJson(),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        homebloc.add(
                          HomeEvent.onDeleteProduct(id: data.id),
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
