import 'dart:ui';
import 'package:emobile_tz/pages/hotel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'bloc/bloc_emitter.dart';
import 'bloc/booking_page.dart';
import 'bloc/hotel_page.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final bookingBloc = BlocProvider.of<BookingBloc>(context);
    bookingBloc.add(FetchBookingData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Отель',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.2000000212,
            color: Color(0xff000000),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoaded) {
              final bookingData = state.data;
              final imageUrls = bookingData.imageUrls;
              final peculiarities =
              bookingData.aboutTheHotel['peculiarities'];
              return Container(
                color: const Color(0xffF6F6F9),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      aspectRatio: 16 / 9,
                                      viewportFraction: 1,
                                      pageSnapping: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                    ),
                                    items: bookingData.imageUrls.map((url) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return CachedNetworkImage(
                                            imageUrl: url,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                            errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      left: 135,
                                      right: 135,
                                      child: Container(
                                        width: 75.0,
                                        height: 17.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: imageUrls.asMap().entries.map((entry) {
                                        return Container(
                                          width: 7.0,
                                          height: 7.0,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 2.0,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _currentIndex == entry.key
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            // margin: const EdgeInsets.only(right: 232),
                            height: 29,
                            width: 149,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFC700).withOpacity(.20),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                                  child: SvgPicture.asset(
                                    'assets/Icons.svg',
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                                Text(
                                  '${bookingData.rating} ${bookingData.ratingName}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    height: 1.2,
                                    fontSize: 16,
                                    color: Color(0xFFFFA800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            bookingData.name,
                            style: const TextStyle(
                              fontSize: 22,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              bookingData.address,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.2,
                                fontFamily: 'SF Pro Display',
                                color: Color(0xff0D72FF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              // text: 'от ${bookingData.minimalPrice.toString()} ₽',
                              text: NumberFormat("от #,###", "ru")
                                  .format(bookingData.minimalPrice),
                              style: TextStyle(
                                fontSize: 28.sp,
                                height: 1.2,
                                fontFamily: 'SF Pro Display',
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                              children: [
                                const WidgetSpan(child: SizedBox(width: 8)),
                                TextSpan(
                                  text: bookingData.priceForIt,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    height: 1.1875,
                                    fontFamily: 'SF Pro Display',
                                    color: const Color(0xff828796),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 9),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Об отеле',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SF Pro Display',
                                height: 1.2),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffFBFBFC),
                                ),
                                child: Text(
                                  peculiarities[0],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff828796),
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xffFBFBFC),
                                    ),
                                    child: Text(
                                      peculiarities[1],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff828796),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xffFBFBFC),
                                    ),
                                    child: Text(
                                      peculiarities[2],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff828796),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffFBFBFC),
                                ),
                                child: Text(
                                  peculiarities[3],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff828796),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            bookingData.aboutTheHotel['description'],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'SF Pro Display',
                                height: 19.2 / 16),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xffFBFBFC),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: SvgPicture.asset(
                                    'assets/emoji-happy.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  title: const Text(
                                    'Удобства',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'SF Pro Display',
                                        color: Color(0xff2C3035),
                                        height: 19.2 / 16),
                                  ),
                                  subtitle: const Text(
                                    'Самое необходимое',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SF Pro Display',
                                        color: Color(0xff828796),
                                        height: 19.2 / 16),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xff2C3035),
                                  ),
                                  onTap: () {},
                                ),
                                Divider(
                                  thickness: 1,
                                  indent: 57,
                                  endIndent: 15,
                                  height: 0,
                                  color: const Color(0xff828796).withOpacity(0.15),
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(
                                    'assets/tick-square.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  title: const Text(
                                    'Что включено',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff2C3035),
                                        fontFamily: 'SF Pro Display',
                                        height: 19.2 / 16),
                                  ),
                                  subtitle: const Text(
                                    'Самое необходимое',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SF Pro Display',
                                        color: Color(0xff828796),
                                        height: 19.2 / 16),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xff2C3035),
                                  ),
                                  onTap: () {},
                                ),
                                Divider(
                                  thickness: 1,
                                  indent: 57,
                                  endIndent: 15,
                                  height: 0,
                                  color: const Color(0xff828796).withOpacity(0.15),
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(
                                    'assets/close-square.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  title: const Text(
                                    'Что не включено',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff2C3035),
                                        fontFamily: 'SF Pro Display',
                                        height: 19.2 / 16),
                                  ),
                                  subtitle: const Text(
                                    'Самое необходимое',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SF Pro Display',
                                        color: Color(0xff828796),
                                        height: 19.2 / 16),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xff2C3035),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: BlocProvider.of<BookingBloc>(context),
                                child:
                                ChoiceNumber(bookingData: bookingData),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 48.0,
                          padding: const EdgeInsets.only(top: 15.0, bottom: 14.0),
                          decoration: BoxDecoration(
                            color: Color(0xff0D72FF),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'К выбору номера',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFeatures: [
                                  FontFeature.disable('clig'),
                                  FontFeature.disable('liga'),
                                ],
                                fontFamily: 'SF Pro Display',
                                fontSize: 16.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else if (state is BookingLoading) {
              return const CircularProgressIndicator();
            } else if (state is BookingError) {
              return Text("Error: ${state.message}");
            } else {
              return const Text("No data available.");
            }
          },
        ),
      ),
    );
  }
}
