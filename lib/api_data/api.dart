import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:emobile_tz/bloc/hotel_page.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'https://run.mocky.io/v3')
abstract class BookingApi {
  factory BookingApi(Dio dio, {String baseUrl}) =
  _BookingApi; // No underscore prefix

  @GET('/63866c74-d593-432c-af8e-f279d1a8d2ff')
  Future<BookingData> getBookingData();

}
