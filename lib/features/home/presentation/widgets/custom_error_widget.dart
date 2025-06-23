import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorPicture,
    required this.reason,
  });

  final String errorPicture;
  final String reason;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          errorPicture,
          fit: BoxFit.cover,
        ),
        Text("Ooops.. its seems like something went wrong"),
        Text("Reason: ")
      ],
    );
  }
}
