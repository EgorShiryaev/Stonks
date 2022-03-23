import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double height;
  const LoadingIndicator({Key? key, required this.height}) : super(key: key);

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
