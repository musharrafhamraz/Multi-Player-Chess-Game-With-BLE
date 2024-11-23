import 'package:chessgame/widgets/product.dart';
import 'package:flutter/material.dart';

class FeatureProducts extends StatelessWidget {
  const FeatureProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Feature Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 83),
              Text(
                'Show all',
                style: TextStyle(
                  color: Color(0xFF9B9B9B),
                  fontSize: 13,
                  letterSpacing: -0.13,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 20, left: 25),
          child: Row(
            children: const [
              ProductCard(
                image: 'assets/pic.jpeg',
                name: 'Turtleneck Sweater',
                price: '39.99',
              ),
              SizedBox(width: 20),
              ProductCard(
                image: 'assets/pic.jpeg',
                name: 'Long Sleeve Dress',
                price: '45.00',
              ),
              SizedBox(width: 20),
              ProductCard(
                image: 'assets/pic.jpeg',
                name: 'Sportwear Set',
                price: '80.00',
              ),
              SizedBox(width: 20),
              ProductCard(
                image: 'assets/pic.jpeg',
                name: 'Elegant Dress',
                price: '75.00',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
