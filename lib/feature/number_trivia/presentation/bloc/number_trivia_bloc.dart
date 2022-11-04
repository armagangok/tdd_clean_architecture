import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc() : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;
  int get number => int.parse(numberString);
  const GetTriviaForConcreteNumber({
    required this.numberString,
  });
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
