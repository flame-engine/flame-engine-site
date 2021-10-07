part of home;

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width <= 600;
    final contentRetract =
        mobile ? bottombarHeight : footerHeight + topbarHeight;
    final height = (MediaQuery.of(context).size.height - contentRetract).clamp(
      200.0,
      double.infinity,
    );

    final compact = MediaQuery.of(context).size.width <= 900;

    final direction = compact ? Axis.vertical : Axis.horizontal;

    return CentralizedContainer(
      height: height,
      child: Flex(
        direction: direction,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlamingLogo(compact: compact),
          Tagline(
            compact: compact,
            mobile: mobile,
          )
        ],
      ),
    );
  }
}

class FlamingLogo extends StatelessWidget {
  final bool compact;

  const FlamingLogo({
    Key? key,
    required this.compact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flamingLogo = Image.asset(
      "assets/mainlogo.png",
    );

    final width = MediaQuery.of(context).size.width.clamp(0.0, 420.0);
    final height = compact ? 350.0 : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: width,
        height: height,
        child: flamingLogo,
      ),
    );
  }
}

class Tagline extends StatelessWidget {
  final bool compact;
  final bool mobile;

  const Tagline({
    Key? key,
    required this.compact,
    required this.mobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width.clamp(0.0, 440.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              compact ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/gradiented.png',
              width: mobile ? 220 : null,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: Text(
                "2D game engine made on top of Flutter",
                textAlign: compact ? TextAlign.center : TextAlign.start,
                style: GoogleFonts.exo2(
                  fontWeight: FontWeight.w100,
                  color: context.flameTheme.textColor,
                  fontSize: 25,
                ),
              ),
            ),
            TaglineButtons(
              compact: compact,
            ),
          ],
        ),
      ),
    );
  }
}

class TaglineButtons extends StatelessWidget {
  final bool compact;

  const TaglineButtons({
    Key? key,
    required this.compact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          compact ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        ElevatedButton(
          child: Text("GET STARTED"),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
            backgroundColor: MaterialStateProperty.all(
              context.flameTheme.primaryAccent,
            ),
            foregroundColor: MaterialStateProperty.all(
              context.flameTheme.textColor,
            ),
          ),
          onPressed: LinkAction.opensSameTab.action("https://docs.flame-engine.org"),
        ),
        TextButton(
          child: Text(
            "FLAMECON",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.only(left: 40)),
            foregroundColor: MaterialStateProperty.all(
              context.flameTheme.primaryAccent,
            ),
          ),
          onPressed: LinkAction.opensSameTab.action("/flamecon"),
        ),
      ],
    );
  }
}
