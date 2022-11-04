import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(
    number: 1,
    text: "test text",
  );

  test(
    "should be a subclass of NumberTriviaEntity",
    () async {
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test(
      "should return a valid model when the JSON number is an integer",
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('trivia.json'),
        );

        final result = NumberTriviaModel.fromJson(jsonMap);

        expect(result, tNumberTriviaModel);
      },
    );

    test(
      "should return a valid model when the JSON number is an integer",
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('trivia_double.json'),
        );

        final result = NumberTriviaModel.fromJson(jsonMap);

        expect(result, tNumberTriviaModel);
      },
    );
  });
}