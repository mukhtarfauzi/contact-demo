import 'package:contact_demo/view/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatelessWidget {
  final Axis axis;
  final double? height;
  final double? radius;
  const ListShimmer({
    Key? key, this.axis = Axis.vertical, this.height, this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: axis,
      padding: const EdgeInsets.symmetric(horizontal: spacing2x),
      itemCount: 5,
      separatorBuilder: (context, index) => axis == Axis.vertical ? const SizedBox(
        height: spacing4x,
      ) : const SizedBox(
        width: spacing2x,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          highlightColor: Colors.grey.shade300,
          baseColor: Colors.grey.shade100,
          child: Container(
            height: height ?? 150,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(radius ?? spacing),
              ),
            ),
          ),
        );
      },
    );
  }
}
