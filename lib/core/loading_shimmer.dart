import 'package:flutter/material.dart';

import 'package:pantest/lib.dart';


class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    super.key,
    this.radius = 0,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}