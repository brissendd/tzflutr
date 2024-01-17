import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc_emitter.dart';
import '../bloc/hotel_page.dart';
import 'booking.dart';


class ChoiceNumber extends StatefulWidget {
  final BookingData bookingData;

  const ChoiceNumber({super.key, required this.bookingData});

  @override
  State<ChoiceNumber> createState() => _ChoiceNumberState();
}

class _ChoiceNumberState extends State<ChoiceNumber> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = 257.0;
    double width = 343.0;

    double aspectRatio = width / height;
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 16,
        ),
        centerTitle: true,
        title: Text(
          widget.bookingData.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.2000000212,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 375,
                  height: 560,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                                    aspectRatio: aspectRatio,
                                    viewportFraction: 1,
                                    pageSnapping: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  ),
                                  items:
                                  ["https://www.atorus.ru/sites/default/files/upload/image/News/56871/%D1%80%D0%B8%D0%BA%D1%81%D0%BE%D1%81% 20%D1%81%D0%B8%D0%B3%D0%B5%D0%B9%D1%82.jpg",
                                    "https://gogolhotel.ru/images/r4.jpg",
                                    "https://worlds-trip.ru/wp-content/uploads/2022/10/white-hills-resort-5.jpeg"].map((url) {
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
                                    children: widget.bookingData.imageUrls
                                        .asMap()
                                        .entries
                                        .map((entry) {
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
                        const SizedBox(height: 8),
                        const Text(
                          'Стандартный с видом на бассейн или сад',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                            height: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffFBFBFC),
                              ),
                              child: const Text(
                                'Включен только завтрак',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff828796),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SF Pro Display',
                                    height: 1.2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffFBFBFC),
                              ),
                              child: const Text(
                                'Кондиционер',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff828796),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SF Pro Display',
                                    height: 1.2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                        Container(
                          height: 29,
                          width: 192,
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff0D72FF).withOpacity(.10)),
                          child: Row(
                            children: [
                              const Text(
                                'Подробнее о номере',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff0D72FF),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SF Pro Display',
                                    height: 19.2 / 16),
                              ),
                              const SizedBox(width: 2),
                              Container(
                                margin: const EdgeInsets.fromLTRB(7, 1, 0, 0),
                                child: SvgPicture.asset(
                                  'assets/blue_arrow_forward_ios.svg',
                                  width: 6,
                                  height: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: const TextSpan(
                          text: '186 600 ₽',
                            style: TextStyle(
                              fontSize: 30,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.0,
                            ),
                            children: [
                              WidgetSpan(
                                child: SizedBox(width: 8),
                              ),
                              TextSpan(
                                text: 'за 7 ночей с перелётом',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.1875,
                                  fontFamily: 'SF Pro Display',
                                  color: Color(0xff828796),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, '/booking-screen');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: BlocProvider.of<BookingBloc>(context),
                                  child: BookingScreen(
                                      bookingData: widget.bookingData),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 48.0,
                            padding: const EdgeInsets.only(top: 15.0, bottom: 14.0),
                            decoration: BoxDecoration(
                              color: const Color(0xff0D72FF),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                'Выбрать номер',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'SF Pro Display',
                                  fontSize:
                                  16.0, // Font size in logical pixels (sp)
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  height:
                                  1.1, // Line height equivalent to 110% (16px * 1.1 = 17.6px)
                                  letterSpacing:
                                  0.1, // Letter spacing in logical pixels (sp)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 375,
                  height: 566,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                                    aspectRatio: aspectRatio,
                                    viewportFraction: 1,
                                    pageSnapping: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  ),
                                  items:
                                  ["https://mmf5angy.twic.pics/ahstatic/www.ahstatic.com/photos/b1j0_roskdc_00_p_1024x768.jpg?ritok=65&twic=v1/cover=800x600",
                                    "https://idei.club/raznoe/uploads/posts/2022-12/thumbs/1671660872_idei-club-p-eksterer-i-interer-gostinitsi-dizain-oboi-88.jpg",
                                    "https://tour-find.ru/thumb/2/bsb2EIEFA8nm22MvHqMLlw/r/d/screenshot_3_94.png"].map((url) {
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
                                    children: widget.bookingData.imageUrls
                                        .asMap()
                                        .entries
                                        .map((entry) {
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
                        const SizedBox(height: 8),
                        const Text(
                          'Люкс номер с видом на море',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                            height: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffFBFBFC),
                              ),
                              child: const Text(
                                'Все включено',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff828796),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SF Pro Display',
                                    height: 1.2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffFBFBFC),
                              ),
                              child: const Text(
                                'Кондиционер',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff828796),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SF Pro Display',
                                    height: 1.2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffFBFBFC),
                          ),
                          child: const Text(
                            'Собственный бассейн',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff828796),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SF Pro Display',
                                height: 1.2),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Container(
                          height: 29,
                          width: 192,
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff0D72FF).withOpacity(.10)),
                          child: Row(
                            children: [
                              const Text(
                                'Подробнее о номере',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff0D72FF),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SF Pro Display',
                                    height: 19.2 / 16),
                              ),
                              const SizedBox(width: 2),
                              Container(
                                margin: const EdgeInsets.fromLTRB(7, 1, 0, 0),
                                child: SvgPicture.asset(
                                  'assets/blue_arrow_forward_ios.svg',
                                  width: 6,
                                  height: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: const TextSpan(
                            text: '289 400 ₽',
                            style: TextStyle(
                              fontSize: 30,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.0,
                            ),
                            children: [
                              WidgetSpan(
                                child: SizedBox(width: 8),
                              ),
                              TextSpan(
                                text: 'за 7 ночей с перелётом',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.1875,
                                  fontFamily: 'SF Pro Display',
                                  color: Colors.grey,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, '/booking-screen');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: BlocProvider.of<BookingBloc>(context),
                                  child: BookingScreen(
                                      bookingData: widget.bookingData),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 48.0,
                            padding: const EdgeInsets.only(top: 15.0, bottom: 14.0),
                            decoration: BoxDecoration(
                              color: const Color(0xff0D72FF),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                'Выбрать номер',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'SF Pro Display',
                                  fontSize:
                                  16.0, // Font size in logical pixels (sp)
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  height:
                                  1.1, // Line height equivalent to 110% (16px * 1.1 = 17.6px)
                                  letterSpacing:
                                  0.1, // Letter spacing in logical pixels (sp)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
