import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  final double? width;
  final double height;
  final Stream<bool> loadingStatus;
  final Widget? shape;
  final Widget? child;
  final EdgeInsets? margin;

  const LoadingShimmer({Key? key, this.width, this.height = 14, required this.loadingStatus, this.child,  this.shape, this.margin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: loadingStatus,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!){
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: shape ?? Container(
                  margin: margin  ?? const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(height / 8))
                  ),
                  height: height,
                  width: width ?? 100,
                )
            );
          }

          return child ?? const SizedBox();
        }
    );
  }
}
