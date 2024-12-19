class Group {
  String? avatar;
  String? name;
  String? creationDate;
  String? description;
  int? unreads = 0;
  Lastmessage? lastmessage;

  Group({
    this.avatar,
    this.name,
    this.creationDate,
    this.description,
    this.lastmessage,
    this.unreads
  });

  factory Group.fromJson(Map<dynamic, dynamic> json, int num) {
    return Group(
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      creationDate: json['creation_date'] as String?,
      description: json['description'] as String?,
      unreads : num.toInt(),
      lastmessage: json['lastmessage'] != null
          ? Lastmessage.fromJson(json['lastmessage'] as Map<dynamic, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['name'] = name;
    data['creation_date'] = creationDate;
    data['description'] = description;
    if (lastmessage != null) {
      data['lastmessage'] = lastmessage!.toJson();
    }
    return data;
  }
}

class Lastmessage {
  String? date;
  String? time;
  String? message;

  Lastmessage({this.date, this.time, this.message});

  factory Lastmessage.fromJson(Map<dynamic, dynamic> json) {
    return Lastmessage(
      date: json['date'] as String?,
      time: json['time'] as String?, // Ensure time is a double
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['message'] = message;
    return data;
  }
}

// Function to fetch data from Firebase
