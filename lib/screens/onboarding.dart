import 'package:flutter/material.dart';
import 'package:on_boarding_ui/model/slider.dart' as SliderModel;
import 'package:on_boarding_ui/on_boarding_ui.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({Key key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: OnBoardingUi(
          slides: [
            SliderModel.Slider(
              sliderHeading: "Book Flights Faster",
              sliderSubHeading: "Get latest and cheapest fares on the fly",
              sliderImageUrl: "assets/logo.png",
            ),
            SliderModel.Slider(
              sliderHeading: "Pay right there",
              sliderSubHeading: "Pay for cheaper flights here",
              sliderImageUrl: "assets/logo.png",
            ),
            SliderModel.Slider(
              sliderHeading: "Seek help instantly",
              sliderSubHeading: "Our team will be happy to help you if you run into any problems",
              sliderImageUrl: "assets/logo.png",
            )
          ],
          onFinish: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          }),
    );
  }
}
