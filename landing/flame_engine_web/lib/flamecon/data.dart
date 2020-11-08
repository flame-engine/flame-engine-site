part of flamecon;

class ErrorMeu extends Error {
  final String messsage;

  ErrorMeu(this.messsage);

  @override
  String toString() {
    return messsage;
  }
}

class FlameconInfo {
  static Future<FlameconInfo> load() async {
    final content = await rootBundle.loadString("assets/flamecon.json");
    final Map<String, dynamic> rootMap = jsonDecode(content);

    final dateTimeString = rootMap['datetime'] as String;
    final dateTime = DateTime.parse(dateTimeString);

    final talksMapList = rootMap['talks'] as List<dynamic>;
    final talks = talksMapList.map<FlameconTalk>((talkMap) {
      return FlameconTalk(
        talkMap['name'],
        talkMap['authorName'],
        talkMap['authorLink'],
      );
    }).toList();

    return FlameconInfo(
      rootMap['name'],
      rootMap['subtitle'],
      dateTime,
      talks,
      rootMap['actionLabel'],
      rootMap['actionLink'],
    );
  }

  const FlameconInfo(
    this.name,
    this.subtitle,
    this.datetime,
    this.talks,
    this.actionLabel,
    this.actionLink,
  );

  final String name;
  final String subtitle;
  final DateTime datetime;
  final List<FlameconTalk> talks;
  final String actionLabel;
  final String actionLink;
}

class FlameconTalk {
  final String name;
  final String authorName;
  final String authorLink;

  FlameconTalk(
    this.name,
    this.authorName,
    this.authorLink,
  );
}
