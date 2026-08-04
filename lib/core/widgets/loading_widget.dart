import 'package:flutter/material.dart';
import 'package:tanseiq/core/helpers/extentions.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: circular);
  }
}
