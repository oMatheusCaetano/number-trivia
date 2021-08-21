import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/Failures/invalid_input_failure.dart';

class TypeConverter {
  Either<InvalidInputFailure, int> stringToUnsignedInt(String string) {
    try {
      int integer = int.parse(string);

      if (integer < 0) {
        throw FormatException();
      }

      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
