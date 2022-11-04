import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture/core/network/network_info.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/data/repository/number_trivia_repository_imp.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/data/source/local.dart';
import 'package:tdd_clean_architecture/feature/number_trivia/data/source/remote.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

class MockLocalDataSource extends Mock implements LocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NumberTriviaRepositoryImp repositoryImp;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    repositoryImp = NumberTriviaRepositoryImp(
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockRemoteDataSource,
    );
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
  });

  group("getConcreteNumberTrivia", () {
    const tNumber = 1;
    const tNumberTriviaModel = NumberTriviaModel(
      text: "test trivia",
      number: tNumber,
    );
    const tNumberTrivia = tNumberTriviaModel;
    test(
      "should check if the device is online",
      () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        repositoryImp.getConcreteNumberTrivia(1);
        verify(mockNetworkInfo.isConnected);
      },
    );
  });

  group("device is online", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    
  });

  group("device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
  });
}
