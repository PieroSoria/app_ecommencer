import 'package:app_ecommencer/core/usecase/use_case.dart';
import 'package:app_ecommencer/features/home/data/models/products_model.dart';
import 'package:app_ecommencer/features/home/domain/repositories/products_repository.dart';

class GetListProductUsecase implements UseCase<List<ProductsModel>, void> {
  final ProductsRepository productsRepository;

  GetListProductUsecase({required this.productsRepository});
  @override
  Future<List<ProductsModel>> call({void params}) async {
    return await productsRepository.getListProducts();
  }
}
