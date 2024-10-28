import 'package:app_ecommencer/core/usecase/use_case.dart';
import 'package:app_ecommencer/features/home/data/models/products_model.dart';
import 'package:app_ecommencer/features/home/domain/repositories/products_repository.dart';

class UpdateProductoUsecase implements UseCase<ProductsModel?, ProductsModel?> {
  final ProductsRepository productsRepository;

  UpdateProductoUsecase({required this.productsRepository});
  @override
  Future<ProductsModel?> call({ProductsModel? params}) async {
    return await productsRepository.updateProducts(product: params!);
  }
}
