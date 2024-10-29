import 'package:app_ecommencer/core/routes/app_routes.dart';
import 'package:app_ecommencer/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_ecommencer/features/home/presentation/pages/register_producto.dart';
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
    context.read<HomeBloc>().add(HomeEvent.onGetlistProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homebloc = context.read<HomeBloc>();
    homebloc.add(HomeEvent.onGetlistProduct());
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.saveProduct) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Container(
                  child: Column(
                    children: [
                      Text("Message"),
                      Text("El producto fue cargado")
                    ],
                  ),
                ),
              ),
            );
          homebloc.add(HomeEvent.onGetlistProduct());
        }
        if (state.editproduct) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Container(
                  child: Column(
                    children: [
                      Text("Message"),
                      Text("El producto fue editado")
                    ],
                  ),
                ),
              ),
            );
          homebloc.add(HomeEvent.onGetlistProduct());
        }
        if (state.deleteproduct) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Container(
                  child: Column(
                    children: [
                      Text("Message"),
                      Text("El producto fue eliminado")
                    ],
                  ),
                ),
              ),
            );
          homebloc.add(HomeEvent.onGetlistProduct());
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(),
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: homebloc,
            builder: (context, state) {
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
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              homebloc.add(
                                HomeEvent.onDeleteProduct(id: data.id),
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.goNamed(AppRoutes.addproducto);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const RegisterProducto(),
            //   ),
            // );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
