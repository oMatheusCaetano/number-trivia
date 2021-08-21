import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class INumberTriviaLocalDatasource {
  Future<NumberTriviaModel> getLastCachedNumberTrivia();
  Future<bool> cacheNumberTrivia({NumberTriviaModel numberTrivia});
}
