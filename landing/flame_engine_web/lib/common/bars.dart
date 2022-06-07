import 'package:flutter/material.dart';

import '../theme.dart';
import 'common.dart';

const topbarHeight = 100.0;
const bottombarHeight = 60.0;
const footerHeight = 80.0;

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cornerLogo = Image.asset('assets/cornerlogo.png');
    return ConditionalRendering(
      (size) => size.width > 800,
      child: Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: CentralizedContainer(
          maxWidth: 1300,
          child: Container(
            height: topbarHeight,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClickableRegion.button(
                  child: cornerLogo,
                  onPressed: LinkAction.opensSameTab.action('/'),
                ),
                HorzMenu(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConditionalRendering(
      (size) => size.width <= 800,
      child: Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          color: Colors.red,
          height: 70.0,
          child: HorzMenu(),
        ),
      ),
    );
  }
}

class HorzMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Link(
          label: 'Docs',
          url: 'https://docs.flame-engine.org',
          first: true,
        ),
        const Link(
            label: 'API', url: 'https://pub.dev/documentation/flame/latest/'),
        const Link(
            label: 'Examples', url: 'https://examples.flame-engine.org/'),
        const Link(
            label: 'Tutorials', url: 'https://tutorials.flame-engine.org/'),
        Link(
          label: 'Github',
          url: 'https://github.com/flame-engine/flame',
          linkAction: LinkAction.opensNewTab,
        ),
        Link(
          label: 'Discord',
          url: 'https://discord.com/invite/pxrBmy4',
          linkAction: LinkAction.opensNewTab,
          last: true,
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: context.flameTheme.textColor,
        );

    return Container(
      height: footerHeight,
      color: context.flameTheme.backgroundSurface,
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 32),
          children: [
            Link(
              label: 'MERCH',
              url: 'https://flame-engine.org/merch',
              linkAction: LinkAction.opensNewTab,
              style: textStyle,
            ),
            Link(
              label: 'AWESOME FLAME',
              url: 'https://github.com/flame-engine/awesome-flame',
              linkAction: LinkAction.opensNewTab,
              style: textStyle,
            ),
            Link(
              label: 'FIRESLIME',
              url: 'https://fireslime.xyz/',
              linkAction: LinkAction.opensNewTab,
              style: textStyle,
            ),
            Link(
              label: 'MEDIA',
              url: 'https://github.com/flame-engine/brand',
              linkAction: LinkAction.opensNewTab,
              style: textStyle,
            ),
            Link(
              label: 'CONTACT',
              url: 'https://fireslime.xyz/about.html',
              linkAction: LinkAction.opensNewTab,
              style: textStyle,
              last: true,
            ),
          ],
        ),
      ),
    );
  }
}
