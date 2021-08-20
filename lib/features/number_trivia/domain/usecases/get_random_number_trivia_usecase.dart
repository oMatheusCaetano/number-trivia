import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:number_trivia/core/Error/failures.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/inumber_trivia_repository.dart';

class GetRandomNumberTriviaUsecase {
  final INumberTriviaRepository repository;

  GetRandomNumberTriviaUsecase({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call() async {
    return await this.repository.getRandomNumberTrivia();
  }
}

