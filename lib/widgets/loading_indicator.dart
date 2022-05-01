import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:news_application/constants/colors.dart';

class ScreenProgressIndicator extends StatelessWidget {
  const ScreenProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoadingIndicator(
      indicatorType: Indicator.ballClipRotateMultiple,
      colors: [
        AppColors.primary,
        AppColors.secoundary,
        AppColors.tertiary,
      ],
    );
  }
}
