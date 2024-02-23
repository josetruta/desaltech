import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage), 
            image: const AssetImage('assets/images/sunny.png'),
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
              child: const  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sunny,
                    size: 50,
                    color: Colors.white
                  ),
                  SizedBox(width: 20),
                  Text(
                      '27°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 55,
                        letterSpacing: -5
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}