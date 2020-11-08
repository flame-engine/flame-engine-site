part of flamecon;

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  Future<FlameconInfo> loadFuture;

  @override
  void initState() {
    super.initState();
    loadFuture = FlameconInfo.load();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width <= 600;
    final contentRetract =
        mobile ? bottombarHeight : footerHeight + topbarHeight;
    final height = (MediaQuery.of(context).size.height - contentRetract).clamp(
      200.0,
      double.infinity,
    );

    return CentralizedContainer(
      height: height,
      child: FutureBuilder<FlameconInfo>(
        future: loadFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw (snapshot.error as Error);
          }
          if (snapshot.hasError || !snapshot.hasData)
            return Container(
              color: Colors.white,
              width: 100,
              height: 100,
            );
          return FlameconDisplay(
            info: snapshot.data,
          );
        },
      ),
    );
  }
}

enum FlameconDisplayMode { noevent, hasevent, happening }

class FlameconDisplay extends StatelessWidget {
  final FlameconInfo info;

  const FlameconDisplay({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final difference = today.difference(info.datetime);

    FlameconDisplayMode mode = FlameconDisplayMode.noevent;

    if (difference.inDays > -3) {
      mode = difference.inDays < 0
          ? FlameconDisplayMode.happening
          : FlameconDisplayMode.hasevent;
    }

    return Column(
      children: [
        Text(
          info.name,
          style: TextStyle(
            fontFamily: "Firealistic",
            fontSize: 60,
            fontWeight: FontWeight.w300,
            color: context.flameTheme.secondaryAccent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 13),
          child: Text(
            info.subtitle,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 19,
                  fontWeight: FontWeight.normal,
                  color: context.flameTheme.textColor,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ),
      ],
    );
  }
}

class FlameconDisplayContent extends StatelessWidget {
  final FlameconInfo info;
  final FlameconDisplayMode mode;

  const FlameconDisplayContent({
    Key key,
    this.info,
    this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mode == FlameconDisplayMode.noevent) {
      return Text(
        "Flamecon is a periodic online event in which people gather to talk about the possibilities of the Flame Engine, the Flutter Game Engine.",
        style: TextStyle(
          color: context.flameTheme.textColor
        ),
      );
    }
    return Container();
  }
}
