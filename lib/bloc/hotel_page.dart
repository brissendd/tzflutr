// State
import 'package:flutter/material.dart';

@immutable
class BookingState {
  final String family;
  final String email;
  final String name;
  final String phoneNumber;
  final String birthday;
  final String citizenship;
  final String passportNumber;
  final String passportValidityPeriod;

  const BookingState({
    this.family = '',
    this.email = '',
    this.name = '',
    this.phoneNumber = '',
    this.birthday = '',
    this.citizenship = '',
    this.passportNumber = '',
    this.passportValidityPeriod = '',
  });

  BookingState copyWith({
    String? family,
    String? email,
    String? name,
    String? phoneNumber,
    String? birthday,
    String? citizenship,
    String? passportNumber,
    String? passportValidityPeriod,
  }) {
    return BookingState(
      family: family ?? this.family,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthday: birthday ?? this.birthday,
      citizenship: citizenship ?? this.citizenship,
      passportNumber: passportNumber ?? this.passportNumber,
      passportValidityPeriod:
      passportValidityPeriod ?? this.passportValidityPeriod,
    );
  }
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final BookingData data;

  const BookingLoaded({required this.data});
}

class BookingError extends BookingState {
  final String message;

  const BookingError({required this.message});
}

class BookingData {
  final int id;
  final String name;
  final String address;
  final int minimalPrice;
  final String priceForIt;
  final int rating;
  final String ratingName;
  final List<String> imageUrls;
  final Map<String, dynamic> aboutTheHotel;

  BookingData({
    required this.id,
    required this.name,
    required this.address,
    required this.minimalPrice,
    required this.priceForIt,
    required this.rating,
    required this.ratingName,
    required this.imageUrls,
    required this.aboutTheHotel,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      address: json['adress'] as String? ?? '',
      minimalPrice: json['minimal_price'] as int? ?? 0,
      priceForIt: json['price_for_it'] as String? ?? '',
      rating: json['rating'] as int? ?? 0,
      ratingName: json['rating_name'] as String? ?? '',
      imageUrls: (json['image_urls'] as List<dynamic>?)
          ?.map((url) => url as String)
          .toList() ??
          [],
      aboutTheHotel: json['about_the_hotel'] as Map<String, dynamic>? ?? {},
    );
  }
}
