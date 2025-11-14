import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension SizedBoxExtension on num {
  SizedBox get heightBox => SizedBox(height: toDouble());
  SizedBox get widthBox => SizedBox(width: toDouble());
}

