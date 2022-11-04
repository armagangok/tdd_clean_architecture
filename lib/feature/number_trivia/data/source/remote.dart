import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/number_trivia.dart';
import '../model/number_trivia_model.dart';

abstract class RemoteDataSource {
  Future<NumberTrivia> getConcreteNumberTrivia(int number);
  Future<NumberTrivia> getRandomNumberTrivia();
}

class RemoteDataSoureImp implements RemoteDataSource {
  final http.Client client;

  RemoteDataSoureImp({required this.client});

  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl("http://numbersapi/{$number}");

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromUrl("http://numbersapi/random");

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    var response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application.json',
      },
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
