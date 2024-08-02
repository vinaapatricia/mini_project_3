part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadedState extends ProfileState {
  final Profile profile;

  ProfileLoadedState(this.profile);

  @override
  List<Object> get props => [profile];
}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState(this.error);

  @override
  List<Object> get props => [error];
}
