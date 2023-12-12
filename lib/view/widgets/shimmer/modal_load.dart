import 'package:flutter/material.dart';

/// Wrap around any widget that makes an async call to show a modal progress
/// indicator while the async call is in progress.
///
/// The progress indicator can be turned on or off using [loadingStatus]
///
/// The progress indicator defaults to a [CircularProgressIndicator] but can be
/// any kind of widget
///
/// The progress indicator can be positioned using [offset] otherwise it is
/// centered
///
/// The modal barrier can be dismissed using [dismissible]
///
/// The color of the modal barrier can be set using [color]
///
/// The opacity of the modal barrier can be set using [opacity]
///
/// HUD=Heads Up Display
///
class ModalLoad extends StatelessWidget {
  final Stream<bool> loadingStatus;
  final double opacity;
  final Color color;
  final Widget? progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget child;

  const ModalLoad({
    Key? key,
    required this.loadingStatus,
    required this.child,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.progressIndicator,
    this.offset,
    this.dismissible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var progressWidget = progressIndicator ?? CircularProgressIndicator(
      color: Theme.of(context).colorScheme.primary,
    );

    return StreamBuilder<bool>(
        stream: loadingStatus,
        builder: (context, snapshot) {
          List<Widget> widgetList = [];
          widgetList.add(child);
          if (snapshot.hasData && snapshot.data!) {
            FocusScope.of(context).requestFocus(FocusNode());
            Widget layOutProgressIndicator;
            if (offset == null) {
              layOutProgressIndicator = Center(child: progressWidget);
            } else {
              layOutProgressIndicator = Positioned(
                child: progressWidget,
                left: offset!.dx,
                top: offset!.dy,
              );
            }
            final modal = [
              Opacity(
                opacity: opacity,
                child: ModalBarrier(dismissible: dismissible, color: color),
              ),
              layOutProgressIndicator
            ];
            widgetList += modal;
          }

          return Stack(
            children: widgetList,
          );
        }
    );
  }
}
