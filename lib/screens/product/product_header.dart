import 'dart:math';

import 'package:flutter/material.dart';
import 'package:formation_flutter/res/app_colors.dart';
import 'package:formation_flutter/res/app_theme_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProductHeader extends StatelessWidget {
  const ProductHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: const <Widget>[ProductImageHeader(), ProductNameHeader()],
    );
  }
}

class ProductImageHeader extends StatelessWidget {
  const ProductImageHeader({super.key});

  static const double kImageHeight = 300.0;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: _ProductHeaderDelegate(
        maxHeight: kImageHeight,
        minHeight: MediaQuery.viewPaddingOf(context).top,
      ),
    );
  }
}

class _ProductHeaderDelegate extends SliverPersistentHeaderDelegate {
  _ProductHeaderDelegate({required this.maxHeight, required this.minHeight})
    : assert(maxHeight >= minHeight),
      assert(minHeight >= 0.0);

  final double maxHeight;
  final double minHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double progress = (shrinkOffset / (maxHeight - minHeight)).clamp(
      0.0,
      1.0,
    );

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        PositionedDirectional(
          top: 0.0,
          start: 0.0,
          end: 0.0,
          height: maxHeight - shrinkOffset,
          child: Image.network(
            'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?q=80&w=1310&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            width: double.infinity,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.srcATop,
          ),
        ),
        PositionedDirectional(
          top: 0.0,
          start: 0.0,
          child: BackButton(
            color: AppColors.white,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white12),
            ),
          ),
        ),
        PositionedDirectional(
          top: max(maxHeight - shrinkOffset - 16.0, 0.0),
          start: 0.0,
          end: 0.0,
          child: Container(
            constraints: BoxConstraints(minHeight: minHeight),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(16.0 * (1 - progress)),
              ),
            ),
            child: SizedBox(width: double.infinity, height: 16.0),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _ProductHeaderDelegate oldDelegate) =>
      maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight;
}

class ProductNameHeader extends StatelessWidget {
  const ProductNameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Petits pois et carottes', style: context.theme.title1),
              const SizedBox(height: 3.0),
              Text('Cassegrain', style: context.theme.title2),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
