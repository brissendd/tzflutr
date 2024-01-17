import 'package:emobile_tz/api_data/api.dart';
import 'package:emobile_tz/bloc/hotel_page.dart';
import 'package:emobile_tz/bloc/booking_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingApi _api;
  BookingBloc(this._api) : super(BookingInitial()) {
    on<FetchBookingData>(_fetchBookingData);
    on<UpdateFamilyEvent>(_updateFamily);
    on<UpdateEmailEvent>(_updateEmail);
    on<UpdateNameEvent>(_updateName);
    on<UpdatePhoneNumberEvent>(_updatePhoneNumber);
    on<UpdateBirthdayEvent>(_updateBirthday);
    on<UpdateCitizenshipEvent>(_updateCitizenship);
    on<UpdatePassportNumberEvent>(_updatePassportNumber);
    on<UpdatePassportValidityEvent>(_updatePassportValidity);
  }

  void _fetchBookingData(
      FetchBookingData event, Emitter<BookingState> emit) async {
    emit(BookingLoading()); // Emit loading state

    try {
      final bookingData =
      await _api.getBookingData(); // Fetch data from API

      if (bookingData != null) {
        emit(BookingLoaded(
            data: bookingData)); // Emit loaded state with data
      } else {
        emit(const BookingError(
            message: 'Failed to fetch data')); // Emit error state
      }
    } catch (e) {
      emit(const BookingError(message: 'An error occurred')); // Emit error state
    }
  }

  void _updateFamily(UpdateFamilyEvent event, Emitter<BookingState> emit) {
    emit(state.copyWith(family: event.family));
    print(event.family);
  }

  void _updateEmail(UpdateEmailEvent event, Emitter<BookingState> emit) {
    emit(state.copyWith(email: event.email));
    print(event.email);
  }

  void _updateName(UpdateNameEvent event, Emitter<BookingState> emit) {
    emit(state.copyWith(name: event.name));
    print(event.name);
  }

  void _updatePhoneNumber(
      UpdatePhoneNumberEvent event, Emitter<BookingState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
    print(event.phoneNumber);
  }

  void _updateBirthday(
      UpdateBirthdayEvent event, Emitter<BookingState> emit) {
    emit(state.copyWith(birthday: event.birthday));
    print(event.birthday);
  }

  void _updateCitizenship(
      UpdateCitizenshipEvent event, Emitter<BookingState> emit) {
    emit(state.copyWith(citizenship: event.citizenship));
    print(event.citizenship);
  }

  void _updatePassportNumber(
      UpdatePassportNumberEvent event, Emitter<BookingState> emit) {
    emit(state.copyWith(passportNumber: event.passportNumber));
    print(event.passportNumber);
  }

  void _updatePassportValidity(
      UpdatePassportValidityEvent event, Emitter<BookingState> emit) {
    emit(state.copyWith(passportValidityPeriod: event.passportValidityPeriod));
    print(event.passportValidityPeriod);
  }
}

// State
enum EmailValidationState { valid, invalid, empty }

class EmailValidationCubit extends Cubit<EmailValidationState> {
  EmailValidationCubit() : super(EmailValidationState.empty);

  void validateEmail(String email) {
    if (email.isEmpty) {
      emit(EmailValidationState.empty);
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      emit(EmailValidationState.invalid);
    } else {
      emit(EmailValidationState.valid);
    }
  }
}
