import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class INumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getRandomNumberTrivia();
  Future<NumberTriviaModel> getConcreteNumberTrivia({required int number});
}
