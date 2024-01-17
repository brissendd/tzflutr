// Event
abstract class BookingEvent {}

class UpdateFamilyEvent extends BookingEvent {
  final String family;

  UpdateFamilyEvent(this.family);
}

class UpdateEmailEvent extends BookingEvent {
  final String email;

  UpdateEmailEvent(this.email);
}

class UpdateNameEvent extends BookingEvent {
  final String name;

  UpdateNameEvent(this.name);
}

class UpdatePhoneNumberEvent extends BookingEvent {
  final String phoneNumber;

  UpdatePhoneNumberEvent(this.phoneNumber);
}

class UpdateBirthdayEvent extends BookingEvent {
  final String birthday;

  UpdateBirthdayEvent(this.birthday);
}

class UpdateCitizenshipEvent extends BookingEvent {
  final String citizenship;

  UpdateCitizenshipEvent(this.citizenship);
}

class UpdatePassportNumberEvent extends BookingEvent {
  final String passportNumber;

  UpdatePassportNumberEvent(this.passportNumber);
}

class UpdatePassportValidityEvent extends BookingEvent {
  final String passportValidityPeriod;

  UpdatePassportValidityEvent(this.passportValidityPeriod);
}

class FetchBookingData extends BookingEvent {}
