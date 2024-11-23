import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF3A2C27)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Image.asset('assets/pic.jpeg', width: 38),
                  const SizedBox(width: 20),
                  Image.asset('assets/pic.jpeg', width: 36),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Text(
                    'Women',
                    style: TextStyle(
                      color: Color(0xFF3A2C27),
                      fontSize: 10,
                      letterSpacing: 0.06,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Men',
                    style: TextStyle(
                      color: Color(0xFF9D9D9D),
                      fontSize: 10,
                      letterSpacing: 0.06,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Accessories',
                    style: TextStyle(
                      color: Color(0xFF9D9D9D),
                      fontSize: 10,
                      letterSpacing: 0.06,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Image.asset('assets/pic.jpeg', width: 36),
              const SizedBox(height: 9),
              const Text(
                'Beauty',
                style: TextStyle(
                  color: Color(0xFF9D9D9D),
                  fontSize: 10,
                  letterSpacing: 0.06,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
