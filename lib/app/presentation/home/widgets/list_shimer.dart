import 'package:code_hero/app/core/widgets/data_shimmer.dart';
import 'package:flutter/material.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DataShimmer(height: 84),
        SizedBox(height: 4),
        DataShimmer(height: 84),
        SizedBox(height: 4),
        DataShimmer(height: 84),
        SizedBox(height: 4),
        DataShimmer(height: 84),
      ],
    );
  }
}
