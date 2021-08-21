import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/Failures/failure.dart';

import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/inumber_trivia_repository.dart';

class GetConcreteNumberTriviaUsecase {
  final INumberTriviaRepository repository;

  GetConcreteNumberTriviaUsecase({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call({required int number}) async {
    return await this.repository.getConcreteNumberTrivia(number: number);
  }
}
