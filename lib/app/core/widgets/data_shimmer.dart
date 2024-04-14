import 'package:code_hero/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DataShimmer extends StatelessWidget {
  final double? height;

  const DataShimmer({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 900),
      baseColor: AppColors.grey7,
      highlightColor: AppColors.grey8,
      child: Container(
        height: height ?? double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
