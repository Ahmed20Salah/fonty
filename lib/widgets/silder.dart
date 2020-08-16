import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/repository/home_repo.dart';
import 'package:fonty/utilits/constant.dart';

class CustomSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CutomSliderState();
  }
}

class _CutomSliderState extends State<CustomSlider> {
  HomeRepository homeRepository = HomeRepository();
  ConstantData constantData = ConstantData();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,

        child: CarouselSlider(
          viewportFraction: 1.0,
      height: 170.0,
      items: homeRepository.slider.map((item) {
        return _sliderItem(NetworkImage('${constantData.url}/public/slider/$item'));
      }).toList(),
    ));
  }

  Widget _sliderItem(NetworkImage img) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(image: img, fit: BoxFit.cover),
      ),
    );
  }
}
