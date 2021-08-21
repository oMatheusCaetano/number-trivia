import 'dart:convert';

import 'package:number_trivia/core/Exceptions/server_exception.dart';
import 'package:number_trivia/core/infra/contracts/ihttp.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/contracts/inumber_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

class NumberTriviaRemoteDatasource implements INumberTriviaRemoteDatasource {
  final IHttp http;
  final baseUrl = 'https://numberapi.com';

  NumberTriviaRemoteDatasource({required this.http});

  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return this._getTrivia('${this.http}/random');
  }

  Future<NumberTriviaModel> getConcreteNumberTrivia({
    required int number,
  }) async {
    return this._getTrivia('${this.http}/$number?json');
  }

  Future<NumberTriviaModel> _getTrivia(String url) async {
    final response = await http.get(url, {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return NumberTriviaModel.fromJson(jsonDecode(response));
  }
}
