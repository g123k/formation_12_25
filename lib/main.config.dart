// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'api/openfoodfacts_api.dart' as _i409;
import 'repositories/i_product_repository.dart' as _i48;
import 'repositories/product_repository.dart' as _i106;

const String _test = 'test';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i409.IAPIManager>(
      () => _i409.MockAPIManager(),
      registerFor: {_test},
    );
    gh.singleton<_i409.IAPIManager>(
      () => _i409.OpenFoodFactsAPIManager(),
      registerFor: {_prod},
    );
    gh.singleton<_i48.IProductRepository>(
      () => _i106.ProductRepository(apiManager: gh<_i409.IAPIManager>()),
    );
    return this;
  }
}
