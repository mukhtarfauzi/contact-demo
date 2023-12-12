import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmer extends StatelessWidget {
  final Size? size;
  const CardShimmer({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = size?.width;
    return Shimmer.fromColors(
      highlightColor: Colors.grey.shade300,
      baseColor: Colors.grey.shade100,
      child: Card(
        child: SizedBox(
          width: width,
          height: size?.height ?? 110,
        ),
      ),
    );
  }
}
