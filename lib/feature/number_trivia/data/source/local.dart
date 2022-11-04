// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_architecture/core/error/exceptions.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/domain/entities/number_trivia.dart';

abstract class LocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class LocalDataSourceImp implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache) async {
    sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(triviaToCache),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw (CacheException());
    }
  }
}
