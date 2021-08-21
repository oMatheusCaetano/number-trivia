import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/Exceptions/cache_exception.dart';
import 'package:number_trivia/core/Exceptions/server_exception.dart';
import 'package:number_trivia/core/Failures/cache_failure.dart';

import 'package:number_trivia/core/Failures/failure.dart';
import 'package:number_trivia/core/Failures/server_failure.dart';
import 'package:number_trivia/core/platform/contracts/inetwork_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/contracts/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/contracts/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/inumber_trivia_repository.dart';

typedef Future<NumberTrivia> _RemoteTriviaGetter();

class NumberTriviaRepository implements INumberTriviaRepository {
  final INumberTriviaRemoteDatasource remoteDatasource;
  final INumberTriviaLocalDatasource localDatasource;
  final INetworkInfo networkInfo;

  NumberTriviaRepository({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia({
    required int number,
  }) async {
    return await this._getTrivia(() {
      return remoteDatasource.getConcreteNumberTrivia(number: number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await this._getTrivia(() {
      return remoteDatasource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _RemoteTriviaGetter getRemoteTrivia,
  ) async {
    return await networkInfo.isConnected
      ? this._getRemoteTrivia(getRemoteTrivia)
      : this._getLocalTrivia();

  }

  Future<Either<ServerFailure, NumberTrivia>> _getRemoteTrivia(
    _RemoteTriviaGetter getRemoteTrivia,
  ) async {
    try {
      final remoteTrivia = await getRemoteTrivia();
      return Right(remoteTrivia);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<CacheFailure, NumberTrivia>> _getLocalTrivia() async {
    try {
      final localTrivia = await localDatasource.getLastCachedNumberTrivia();
      return Right(localTrivia);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
