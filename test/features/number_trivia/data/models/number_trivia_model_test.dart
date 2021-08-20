import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final numberTriviaModel = NumberTriviaModel(text: 'Test text', number: 7);

  test('should be a subclass of NumberTrivia', () async {
    //! Assert
    expect(numberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer', () {
      //! Arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      //! Act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //! Assert
      expect(result, numberTriviaModel);
    });

    test('should return a valid model when the JSON number is an double', () {
      //! Arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));

      //! Act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //! Assert
      expect(result, numberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      //! Act
      final result = numberTriviaModel.toJson();

      //! Assert
      expect(result, {
        'text': 'Test Text',
        'number': 1,
      });
    });
  });
}
