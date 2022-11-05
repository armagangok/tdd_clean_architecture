import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_architecture/core/error/failures.dart';
import 'package:tdd_clean_architecture/core/util/input_converter.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/domain/usecase/get_random_number_triva.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'SERVER FAILURE';
const String CACHE_FAILURE_MESSAGE = 'CACHE FAILURE';
const String INVALID_INPUT_FAILURE_MESSAGE =
    "INVALID INPUT - THE NUMBER MUST BE POSITIVE INTEGER NUMBER ";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) {});
  }

  NumberTriviaState get initialState => Empty();

  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield const Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureTrivia = await getConcreteNumberTrivia(integer);
          yield failureTrivia.fold(
            (failure) => Error(
              message: _getFailureMessage(failure),
            ),
            (trivia) => Loaded(trivia: trivia),
          );
        },
      );
    } else if (event is GetTriviaForConcreteNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield failureOrTrivia.fold(
        (failure) => Error(message: _getFailureMessage(failure)),
        (trivia) => Loaded(trivia: trivia),
      );
    }
  }

  String _getFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "UNEXPECTED ERROR";
    }
  }
}
