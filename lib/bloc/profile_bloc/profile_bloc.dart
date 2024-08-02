import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_project_3/model/profile_model.dart';
import 'package:mini_project_3/services/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileLoadingState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final profile = await _profileRepository.getProfile();
        emit(ProfileLoadedState(profile));
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });
  }
}
