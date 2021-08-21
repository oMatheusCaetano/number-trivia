import 'package:dartz/dartz.dart';

import 'package:number_trivia/core/Failures/failure.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

abstract class INumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia({
    required int number
  });
}
