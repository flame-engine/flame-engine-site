part of flamecon;

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late Future<FlameconInfo> loadFuture = FlameconInfo.load();

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width <= 600;
    final contentRetract =
        mobile ? bottombarHeight : footerHeight + topbarHeight;
    final height = (MediaQuery.of(context).size.height - contentRetract)
        .clamp(200.0, double.infinity);

    return CentralizedContainer(
      height: height,
      maxWidth: 600,
      child: FutureBuilder<FlameconInfo>(
        future: loadFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading config',
                style: TextStyle(
                  fontSize: 20,
                  color: context.flameTheme.primaryAccent,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Loading',
                style: TextStyle(
                  fontSize: 20,
                  color: context.flameTheme.textColor,
                ),
              ),
            );
          }

          return FlameconDisplay(
            info: snapshot.data!,
          );
        },
      ),
    );
  }
}

enum FlameconDisplayMode { noEvent, hasEvent, happening }

class FlameconDisplay extends StatelessWidget {
  final FlameconInfo info;

  const FlameconDisplay({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final difference = today.difference(info.datetime);

    var mode = FlameconDisplayMode.noEvent;

    if (difference.inDays <= 5) {
      mode = difference.inDays >= 0
          ? FlameconDisplayMode.happening
          : FlameconDisplayMode.hasEvent;
    }
    final mobile = MediaQuery.of(context).size.width <= 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        final innerConstraints = constraints.copyWith(
          maxHeight: MediaQuery.of(context).size.height,
        );
        return Padding(
          padding: EdgeInsets.only(top: mobile ? 40 : 0),
          child: ConstrainedBox(
            constraints: innerConstraints,
            child: Center(
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      info.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Firealistic',
                        fontSize: mobile ? 40 : 60,
                        fontWeight: FontWeight.w300,
                        color: context.flameTheme.secondaryAccent,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: mobile ? 6 : 13),
                      child: Text(
                        info.subtitle,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: mobile ? 14 : 19,
                              fontWeight: FontWeight.normal,
                              color: context.flameTheme.textColor,
                              fontStyle: FontStyle.italic,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: mobile ? 10 : 20),
                    FlameconDisplayContent(
                      info: info,
                      mode: mode,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: mobile ? 40 : 60,
                        bottom: mobile ? 30 : 50,
                        left: 14,
                        right: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Link(
                            label: 'Watch previous editions',
                            url:
                                'https://www.youtube.com/playlist?list=PL1sAA7o4TIZoAAea6FluJbqE9U6IeA7w9',
                            linkAction: LinkAction.opensNewTab,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: context.flameTheme.textColor,
                                      decoration: TextDecoration.underline,
                                    ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String formatDate(DateTime dateTime) {
  final day = dateTime.day;
  final lastDigit = day % 10;
  final isElligible = lastDigit > 0 && lastDigit < 4 && (day < 10 || day > 13);
  final suffix =
      isElligible ? const ['st', 'nd', 'rd'].elementAt(lastDigit - 1) : 'th';

  final formatter = DateFormat("MMMM dd'$suffix', H:mm");

  return formatter.format(dateTime);
}

class FlameconDisplayContent extends StatelessWidget {
  final FlameconInfo info;
  final FlameconDisplayMode mode;

  const FlameconDisplayContent({
    Key? key,
    required this.info,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mode == FlameconDisplayMode.noEvent) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SizedBox(
          width: 470,
          child: Text(
            'Flamecon is a periodic online event in which people gather to talk about the possibilities of the Flame Engine.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.flameTheme.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
    }

    final talksWidgets = info.talks.map((final FlameconTalk talk) {
      return TalkDescription(
        talk: talk,
      );
    }).toList(growable: false);
    final mobile = MediaQuery.of(context).size.width <= 600;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: mobile ? 20 : 30,
            horizontal: mobile ? 10 : 20,
          ),
          color: context.flameTheme.secondaryAccent,
          child: Center(
            child: Text(
              '${formatDate(info.datetime)} UTC',
              style: TextStyle(
                fontSize: mobile ? 20 : 30,
              ),
            ),
          ),
        ),
        ...talksWidgets,
        SizedBox(
          width: 200,
          child: ElevatedButton(
            child: Text(info.actionLabel),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              backgroundColor: MaterialStateProperty.all(
                context.flameTheme.secondaryAccent,
              ),
              foregroundColor: MaterialStateProperty.all(
                context.flameTheme.textColor,
              ),
            ),
            onPressed: LinkAction.opensNewTab.action(info.actionLink),
          ),
        ),
      ],
    );
  }
}

class TalkDescription extends StatelessWidget {
  final FlameconTalk talk;

  const TalkDescription({
    Key? key,
    required this.talk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width <= 600;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: mobile ? 20 : 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '"${talk.name}"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mobile ? 20 : 30,
              fontWeight: FontWeight.w400,
              height: 1.8,
            ),
          ),
          ClickableRegion.link(
            child: Text(
              '- ${talk.authorName}',
              style: TextStyle(
                fontSize: mobile ? 15 : 18,
                fontWeight: FontWeight.w200,
                decoration: TextDecoration.underline,
              ),
            ),
            url: talk.authorLink,
            action: LinkAction.opensNewTab,
          ),
        ],
      ),
    );
  }
}
