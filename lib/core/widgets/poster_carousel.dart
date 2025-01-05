import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PosterCarousel extends StatelessWidget {
  const PosterCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    return   Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 3.0,
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayInterval: Duration(seconds: 10),
          viewportFraction: 0.9,
        ),
        items: list
            .map((item) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Color(0xFFD9D9D9),
          ),
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(child: Text(item.toString())),
        ))
            .toList(),
      ),
    );
  }
}
