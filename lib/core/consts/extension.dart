import 'package:flutter/widgets.dart';

extension SizedBoxExtention on num {
  SizedBox get heightBox => SizedBox(height: toDouble());
  SizedBox get widthBox => SizedBox(width: toDouble());
}
