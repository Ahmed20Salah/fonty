import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CutomSliderState();
  }
}

class _CutomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,

        child: CarouselSlider(
          viewportFraction: 1.0,
      height: 250.0,
      items: <Widget>[_sliderItem(AssetImage('assets/photo.jpg'))],
    ));
  }

  Widget _sliderItem(AssetImage img) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(image: img, fit: BoxFit.cover),
      ),
    );
  }
}
