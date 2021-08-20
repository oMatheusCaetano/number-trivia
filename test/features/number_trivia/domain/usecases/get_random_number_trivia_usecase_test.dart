import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/inumber_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';

class MockNumberTriviaRepository extends Mock
    implements INumberTriviaRepository {}

void main() {
  late GetRandomNumberTriviaUsecase usecase;
  late MockNumberTriviaRepository repository;

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTriviaUsecase(repository: repository);
  });

  final numberTrivia = NumberTrivia(text: 'A test number trivia', number: 7);

  test('should get a random trivia from the repository', () async {
    //! Arrange
    when(repository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(numberTrivia));
        
    //! Act
    final result = await usecase();

    //! Assert
    expect(result, Right(numberTrivia));
    verify(repository.getRandomNumberTrivia());
    verifyNoMoreInteractions(repository);
  });
}
