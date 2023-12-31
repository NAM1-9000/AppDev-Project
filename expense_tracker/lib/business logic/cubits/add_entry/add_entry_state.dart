part of 'add_entry_cubit.dart';

sealed class AddEntryState extends Equatable {
  const AddEntryState();

  @override
  List<Object> get props => [];
}

final class AddEntryInitial extends AddEntryState {}

final class AddEntryLoading extends AddEntryState {}

final class AddEntrySuccess extends AddEntryState {
  final UserModel userModel;

  const AddEntrySuccess({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

final class AddEntryFailed extends AddEntryState {
  final String message;

  const AddEntryFailed({required this.message});

  @override
  List<Object> get props => [message];
}
