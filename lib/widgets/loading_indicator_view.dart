import 'package:flutter/material.dart';

class LoadingIndicatorView extends StatelessWidget {
  final double height;
  const LoadingIndicatorView({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
