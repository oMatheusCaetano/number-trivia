import 'dart:convert';

import 'package:number_trivia/core/Exceptions/cache_exception.dart';
import 'package:number_trivia/core/infra/local_storage.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/contracts/inumber_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDatasource implements INumberTriviaLocalDatasource {
  final LocalStorage storage;

  NumberTriviaLocalDatasource({required this.storage});

  Future<NumberTriviaModel> getLastCachedNumberTrivia() async {
    final jsonData = await this.storage.getItem(CACHED_NUMBER_TRIVIA);

    if (jsonData == null) {
      throw CacheException();
    }

    final mapData = json.decode(jsonData);
    return NumberTriviaModel.fromJson(mapData);
  }

  Future<bool> cacheNumberTrivia({
    required NumberTriviaModel numberTrivia,
  }) async {
    return this.storage.setItem(CACHED_NUMBER_TRIVIA, numberTrivia.toJson());
  }
}
