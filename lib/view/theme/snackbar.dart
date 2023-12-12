import 'package:flutter/material.dart';

class SnackBarExtend extends SnackBar {
  SnackBarExtend.error(BuildContext context,
      {Key? key, required Widget content})
      : super(
          key: key,
          content: content,
          backgroundColor: Theme.of(context).colorScheme.error,
        );

  SnackBarExtend.success(BuildContext context,
      {Key? key, required Widget content})
      : super(
          key: key,
          content: content,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        );
}
