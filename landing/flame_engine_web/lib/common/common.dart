import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart' as html;
import '../theme.dart';

final emptyList = List.empty();

/// Background color and scrollable widgets
class BackgroundStuff extends StatelessWidget {
  final Widget child;
  final List<Widget>? stackableChildren;

  BackgroundStuff({
    Key? key,
    required this.child,
    required this.stackableChildren,
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
              ...stackableChildren!,
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
  final double? height;

  CentralizedContainer({
    Key? key,
    required this.child,
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
  final LinkAction? linkAction;
  final String label;
  final String? url;
  final bool first;
  final bool last;
  final TextStyle? style;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const Link({
    Key? key,
    required this.label,
    required this.url,
    this.linkAction,
    this.first = false,
    this.last = false,
    this.style,
    this.padding,
  })  : onPressed = null,
        super(key: key);

  const Link.internal({
    Key? key,
    required this.label,
    required this.onPressed,
    this.first = false,
    this.last = false,
    required this.style,
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

    final child = Padding(
      padding: finalPadding,
      child: Text(
        label,
        style: style,
      ),
    );

    if(onPressed!=null) {
      return ClickableRegion.button(onPressed: onPressed, child: child,);
    }

    return ClickableRegion.link(
      action: action,
      url: url,
      child: child,
    );
  }
}

class ClickableRegion extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final LinkAction? action;
  final String? url;

  const ClickableRegion.button({
    Key? key,
    required this.onPressed,
    required this.child,
  })  : this.action = null,
        this.url = null,
        super(key: key);

  const ClickableRegion.link({
    Key? key,
    required this.child,
    required this.action,
    this.url,
  })  : this.onPressed = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed ?? (url != null ? action!.action(url!) : null),
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
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final show = condition(MediaQuery.of(context).size);
    return show ? child : Container();
  }
}
