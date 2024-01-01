import 'package:expense_tracker/data/models/user_model.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:expense_tracker/business logic/cubits/auth/auth_cubit.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthCubit', () {
    late AuthCubit authCubit;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authCubit = AuthCubit();
    });

    tearDown(() {
      authCubit.close();
    });

    test('initial state is AuthInitial', () {
      expect(authCubit.state, AuthInitial());
    });

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthSuccess] when emailPasswordSignUp is called',
      build: () {
        when(mockAuthRepository.emailPasswordSignUp(
                "test@example.com", 'password'))
            .thenAnswer((_) async => UserModel(
                email: '',
                password: '',
                monthlyBudget: 0,
                monthlySpending: 0,
                entries: [])); // replace UserModel with your actual model
        return authCubit;
      },
      act: (cubit) => cubit.emailPasswordSignUp('test@example.com', 'password'),
      expect: () => [
        AuthLoading(),
        AuthSuccess(UserModel(
            email: 'test@example.com',
            password: 'password',
            monthlyBudget: 0,
            monthlySpending: 0,
            entries: [])), // replace UserModel with your actual model
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthFailed] when emailPasswordSignUp fails',
      build: () {
        when(mockAuthRepository.emailPasswordSignUp("", 'password'))
            .thenThrow(Exception('Failed to sign up'));
        return authCubit;
      },
      act: (cubit) => cubit.emailPasswordSignUp('test@example.com', 'password'),
      expect: () => [
        AuthLoading(),
        AuthFailed('Failed to sign up'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthSuccess] when emailPasswordSignIn is called',
      build: () {
        when(mockAuthRepository.emailPasswordSignIn(
                'test@example.com', 'password'))
            .thenAnswer((_) async => UserModel(
                email: '',
                password: '',
                monthlyBudget: 0,
                monthlySpending: 0,
                entries: [])); // replace UserModel with your actual model
        return authCubit;
      },
      act: (cubit) => cubit.emailPasswordSignIn('test@example.com', 'password'),
      expect: () => [
        AuthLoading(),
        AuthSuccess(UserModel(
            email: '',
            password: '',
            monthlyBudget: 0,
            monthlySpending: 0,
            entries: [])), // replace UserModel with your actual model
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthFailed] when emailPasswordSignIn fails',
      build: () {
        when(mockAuthRepository.emailPasswordSignIn(
                'test@example.com', 'password'))
            .thenThrow(Exception('Failed to sign in'));
        return authCubit;
      },
      act: (cubit) => cubit.emailPasswordSignIn('test@example.com', 'password'),
      expect: () => [
        AuthLoading(),
        AuthFailed('Failed to sign in'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthInitial] when emailPasswordSignOut is called',
      build: () {
        when(mockAuthRepository.emailPasswordSignOut())
            .thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.emailPasswordSignOut(),
      expect: () => [
        AuthLoading(),
        AuthInitial(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthFailed] when emailPasswordSignOut fails',
      build: () {
        when(mockAuthRepository.emailPasswordSignOut())
            .thenThrow(Exception('Failed to sign out'));
        return authCubit;
      },
      act: (cubit) => cubit.emailPasswordSignOut(),
      expect: () => [
        AuthLoading(),
        AuthFailed('Failed to sign out'),
      ],
    );
  });
}
