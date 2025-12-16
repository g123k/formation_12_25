import 'package:flutter/material.dart';
import 'package:formation_flutter/res/app_theme_extension.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  static const double IMAGE_HEIGHT = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            PositionedDirectional(
              top: 0.0,
              start: 0.0,
              end: 0.0,
              height: IMAGE_HEIGHT,
              child: Image.network(
                'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?q=80&w=1310&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                fit: BoxFit.cover,
                cacheHeight:
                    (IMAGE_HEIGHT * MediaQuery.devicePixelRatioOf(context))
                        .toInt(),
              ),
            ),
            PositionedDirectional(
              top: IMAGE_HEIGHT - 16.0,
              start: 0.0,
              end: 0.0,
              bottom: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Petits pois et carottes',
                      style: context.theme.title1,
                    ),
                    Text('Cassegrain', style: context.theme.title2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
