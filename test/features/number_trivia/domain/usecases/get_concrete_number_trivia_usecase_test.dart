import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/inumber_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';

class MockNumberTriviaRepository extends Mock
    implements INumberTriviaRepository {}

void main() {
  late GetConcreteNumberTriviaUsecase usecase;
  late MockNumberTriviaRepository repository;

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTriviaUsecase(repository: repository);
  });

  final number = 7;
  final numberTrivia = NumberTrivia(text: 'A test number trivia', number: 7);

  test('should get trivia for the number from the repository', () async {
    //! Arrange
    when(repository.getConcreteNumberTrivia(number: number))
        .thenAnswer((_) async => Right(numberTrivia));

    //! Act
    final result = await usecase(number: number);

    //! Assert
    expect(result, Right(numberTrivia));
    verify(repository.getConcreteNumberTrivia(number: number));
    verifyNoMoreInteractions(repository);
  });
}
