import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/Failures/cache_failure.dart';
import 'package:number_trivia/core/Failures/failure.dart';
import 'package:number_trivia/core/Failures/server_failure.dart';
import 'package:number_trivia/core/util/type_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSSAGE = 'Server Failure.';
const String CACHE_FAILURE_MESSSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSSAGE =
    'Invalid Input - The number cannot be lower than 0.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUsecase getConcreteNumberTriviaUsecase;
  final GetRandomNumberTriviaUsecase getRandomNumberTriviaUsecase;
  final TypeConverter typeConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTriviaUsecase,
    required this.getRandomNumberTriviaUsecase,
    required this.typeConverter,
  }) : super(Initial());

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if (event is GetTriviaForConcreteNumber) {
      yield* this.typeConverter.stringToUnsignedInt(event.numberString).fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSSAGE);
        },
        (unsignedInt) async* {
          yield Loading();
          final result =
              await this.getConcreteNumberTriviaUsecase(number: unsignedInt);
          yield result.fold(
              (failure) => Error(message: this._mapFailureToMessage(failure)),
              (numberTrivia) => Loaded(numberTrivia: numberTrivia));
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final result = await this.getRandomNumberTriviaUsecase();
      yield result.fold(
          (failure) => Error(message: this._mapFailureToMessage(failure)),
          (numberTrivia) => Loaded(numberTrivia: numberTrivia));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
