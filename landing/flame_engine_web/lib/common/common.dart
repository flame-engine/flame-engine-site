import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart' as html;
import '../theme.dart';

final emptyList = List.empty();

/// Background color and scrollable widgets
class BackgroundStuff extends StatelessWidget {
  final Widget child;
  final List<Widget> stackableChildren;

  BackgroundStuff({
    Key key,
    this.child,
    this.stackableChildren,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.flameTheme;

    final scrollView = SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: child,
    );

    final bg = stackableChildren == null
        ? scrollView
        : Stack(
            children: [
              scrollView,
              ...stackableChildren,
            ],
          );

    return Container(
      color: theme.background,
      constraints: BoxConstraints.expand(),
      child: bg,
    );
  }
}

class CentralizedContainer extends StatelessWidget {
  final Widget child;
  final BoxConstraints constraints;
  final double height;

  CentralizedContainer({
    Key key,
    this.child,
    double maxWidth = 1200,
    double minWidth = 200,
    this.height,
  })  : this.constraints = BoxConstraints(
          maxWidth: maxWidth,
          minWidth: minWidth,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints localConstraints) {
        final width = constraints.constrainWidth(
          localConstraints.biggest.width,
        );
        return Center(
          child: Container(
            width: width,
            height: height,
            child: child,
          ),
        );
      },
    );
  }
}

/// Basic text link
class Link extends StatelessWidget {
  final LinkAction linkAction;
  final String label;
  final String url;
  final bool first;
  final bool last;
  final TextStyle style;
  final EdgeInsets padding;
  final VoidCallback onPressed;

  const Link({
    Key key,
    @required this.label,
    @required this.url,
    this.linkAction,
    this.first = false,
    this.last = false,
    this.style,
    this.padding,
  })  : onPressed = null,
        super(key: key);

  const Link.internal({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.first = false,
    this.last = false,
    this.style,
    this.padding,
  })  : linkAction = null,
        url = null,
        super(key: key);

  LinkAction get action => linkAction ?? LinkAction.opensSameTab;

  @override
  Widget build(BuildContext context) {
    EdgeInsets finalPadding =
        padding ?? EdgeInsets.symmetric(horizontal: 30, vertical: 0);
    if (first) {
      finalPadding = finalPadding.copyWith(left: 0);
    }
    if (last) {
      finalPadding = finalPadding.copyWith(right: 0);
    }
    return ClickableRegion(
      onPressed: onPressed,
      action: action,
      url: url,
      child: Padding(
        padding: finalPadding,
        child: Text(
          label,
          style: style,
        ),
      ),
    );
  }
}

class ClickableRegion extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final LinkAction action;
  final String url;

  const ClickableRegion({
    Key key,
    this.onPressed,
    this.action,
    this.child,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed ?? action.action(url),
        child: child,
      ),
    );
  }
}

typedef LinkActionCallback = VoidCallback Function(String url);

class LinkAction {
  final LinkActionCallback action;

  LinkAction._(this.action);

  static final opensSameTab = LinkAction._((url) => () {
        html.window.location.assign(url);
      });

  static final opensNewTab = LinkAction._((url) => () {
        html.window.open(url, '_blank');
      });
}

class ConditionalRendering extends StatelessWidget {
  final Widget child;
  final bool Function(Size size) condition;

  const ConditionalRendering(
    this.condition, {
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final show = condition(MediaQuery.of(context).size);
    return show ? child : Container();
  }
}
