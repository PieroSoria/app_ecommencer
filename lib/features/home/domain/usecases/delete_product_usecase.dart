import 'package:app_ecommencer/core/usecase/use_case.dart';
import 'package:app_ecommencer/features/home/domain/repositories/products_repository.dart';

class DeleteProductUsecase implements UseCase<bool, int> {
  final ProductsRepository productsRepository;

  DeleteProductUsecase({required this.productsRepository});
  @override
  Future<bool> call({int? params}) async {
    return await productsRepository.deleteProducts(id: params!);
  }
}
