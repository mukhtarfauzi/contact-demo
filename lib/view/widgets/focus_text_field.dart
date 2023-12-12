import 'package:contact_demo/view/theme/spacing.dart';
import 'package:flutter/material.dart';

class FocusTextField extends StatefulWidget {
  final Widget fieldWidget;
  final IconData? icon;
  final Widget? action;
  final String? labelText;
  const FocusTextField(
      {Key? key,
      required this.fieldWidget,
      this.icon,
      this.labelText, this.action})
      : super(key: key);

  @override
  State<FocusTextField> createState() => _FocusTextFieldState();
}

class _FocusTextFieldState extends State<FocusTextField> {
  bool isFocus = false;
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) => setState(() => isFocus = focus),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(widget.icon != null || widget.labelText != null)Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if(widget.icon != null)Icon(
                        widget.icon,
                        color: isFocus
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).unselectedWidgetColor,
                      ),
                      const SizedBox(
                        width: spacing,
                      ),
                      if(widget.labelText != null)Flexible(
                        child: Text(
                          widget.labelText!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: isFocus
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).unselectedWidgetColor),
                        ),
                      ),
                    ],
                  ),
                ),
                if(widget.action != null) widget.action!,
              ],
            ),
            const SizedBox(
              height: spacingHalf,
            ),
            widget.fieldWidget,
          ],
        ),
      ),
    );
  }
}
