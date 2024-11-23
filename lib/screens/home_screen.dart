import 'package:chessgame/widgets/banner.dart';
import 'package:chessgame/widgets/category.dart';
import 'package:chessgame/widgets/feature.dart';
import 'package:chessgame/widgets/header.dart';
import 'package:chessgame/widgets/navigation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              HeaderSection(),
              CategorySection(),
              BannerSection(),
              FeatureProducts(),
              CustomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }
}
