// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../domain/repositories/product_repository.dart' as _i933;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/use_cases/check_user_auth_status_use_case.dart' as _i369;
import '../../domain/use_cases/create_user_use_case.dart' as _i852;
import '../../domain/use_cases/get_product_by_barcode_use_case.dart' as _i1039;
import '../../domain/use_cases/get_user_use_case.dart' as _i347;
import '../../domain/use_cases/search_product_use_case.dart' as _i202;
import '../../infrastructure/repositories/product_repository_impl.dart'
    as _i961;
import '../../infrastructure/repositories/user_repository_impl.dart' as _i632;
import '../../presentation/view_models/auth_view_model.dart' as _i237;
import '../../presentation/view_models/product_query_view_model.dart' as _i41;
import '../../presentation/view_models/product_search_view_model.dart' as _i871;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i271.UserRepository>(() => _i632.UserRepositoryImpl());
    gh.lazySingleton<_i933.ProductRepository>(
        () => _i961.ProductRepositoryImpl());
    gh.factory<_i369.CheckUserAuthStatusUseCase>(
        () => _i369.CheckUserAuthStatusUseCase(gh<_i271.UserRepository>()));
    gh.factory<_i852.CreateUserUseCase>(
        () => _i852.CreateUserUseCase(gh<_i271.UserRepository>()));
    gh.factory<_i347.GetUserUseCase>(
        () => _i347.GetUserUseCase(gh<_i271.UserRepository>()));
    gh.factory<_i1039.GetProductByBarcodeUseCase>(
        () => _i1039.GetProductByBarcodeUseCase(gh<_i933.ProductRepository>()));
    gh.factory<_i202.SearchProductsUseCase>(
        () => _i202.SearchProductsUseCase(gh<_i933.ProductRepository>()));
    gh.factory<_i871.ProductSearchViewModel>(
        () => _i871.ProductSearchViewModel(gh<_i202.SearchProductsUseCase>()));
    gh.lazySingleton<_i237.AuthViewModel>(() => _i237.AuthViewModel(
          gh<_i369.CheckUserAuthStatusUseCase>(),
          gh<_i852.CreateUserUseCase>(),
        ));
    gh.factory<_i41.ProductQueryViewModel>(() =>
        _i41.ProductQueryViewModel(gh<_i1039.GetProductByBarcodeUseCase>()));
    return this;
  }
}
