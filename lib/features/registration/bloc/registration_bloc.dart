import 'package:bloc/bloc.dart';
import 'package:commet_chat/core/services/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  String? selectedGender;
  String? selecteEmploymentIn;
  String? selectedProfileImage;

  final List<String> images = [];
  final ImagePicker picker = ImagePicker();

  RegistrationBloc() : super(RegistrationInitial()) {
    on<SelectGenderEvent>(_selectGenderEvent);
    on<SelectEmployedInEvent>(_selectEmployedInEvent);
    on<PickImageEvent>(_pickImageEvent);
    on<DeleteImageEvent>(_deleteImageEvent);
    on<SelectProfileImageEvent>(_selectProfileImageEvent);
  }

  _selectGenderEvent(SelectGenderEvent event, Emitter<RegistrationState> emit) {
    selectedGender = event.gender;
    emit(SelectGenderState(gender: selectedGender!));
  }

  _selectEmployedInEvent(
    SelectEmployedInEvent event,
    Emitter<RegistrationState> emit,
  ) {
    selecteEmploymentIn = event.selecteEmploymentIn;
    emit(SelecteEmploymentInState(selecteEmploymentIn: selecteEmploymentIn!));
  }

  _pickImageEvent(PickImageEvent event, Emitter<RegistrationState> emit) async {
    emit(PickImageLoadingState());

    try {
      final List<XFile> picked = await picker.pickMultiImage();

      for (var img in picked) {
        if (images.length < 6) images.add(img.path);
      }

      // Always send a NEW COPY of the list
      emit(PickImageSuccessState(image: List.from(images)));
    } catch (e) {
      logger.e("Pick Image Event", error: e.toString());
      emit(PickImageErrorState(error: e.toString()));
    }
  }

  // FIX: DELETE EVENT (YOU DIDN’T ADD THIS)
  _deleteImageEvent(DeleteImageEvent event, emit) async {
    if (event.index < images.length) {
      images.removeAt(event.index);

      emit(PickImageSuccessState(image: List.from(images)));
    }
  }

  _selectProfileImageEvent(
    SelectProfileImageEvent event,
    Emitter<RegistrationState> emit,
  ) {
    selectedProfileImage = event.url;
    emit(ProfileImageSelectedState(selectedProfileImage!));
  }
}
