import 'package:commet_chat/core/consts/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CometChat());
}

class CometChat extends StatelessWidget {
  const CometChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: goRouter);
  }
}
