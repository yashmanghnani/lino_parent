class ChatHistoryRes {
    ChatHistoryRes({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final List<Datum> data;

    factory ChatHistoryRes.fromJson(Map<String, dynamic> json){ 
        return ChatHistoryRes(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
    };

}

class Datum {
    Datum({
        required this.id,
        required this.sessions,
        required this.dateObj,
    });

    final DateTime? id;
    final List<Session> sessions;
    final DateTime? dateObj;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: DateTime.tryParse(json["_id"] ?? ""),
            sessions: json["sessions"] == null ? [] : List<Session>.from(json["sessions"]!.map((x) => Session.fromJson(x))),
            dateObj: DateTime.tryParse(json["dateObj"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
      "_id": "${id!.year.toString().padLeft(4,'0')}-${id!.month.toString().padLeft(2,'0')}-${id!.day.toString().padLeft(2,'0')}",
        "sessions": sessions.map((x) => x.toJson()).toList(),
        "dateObj": dateObj?.toIso8601String(),
    };

}

class Session {
    Session({
        required this.id,
        required this.userId,
        required this.date,
        required this.time,
        required this.endTime,
        required this.chats,
        required this.v,
        required this.dateObj,
        required this.summary,
    });

    final String? id;
    final String? userId;
    final DateTime? date;
    final String? time;
    final String? endTime;
    final List<Chat> chats;
    final int? v;
    final DateTime? dateObj;
    final String? summary;

    factory Session.fromJson(Map<String, dynamic> json){ 
        return Session(
            id: json["_id"],
            userId: json["userId"],
            date: DateTime.tryParse(json["date"] ?? ""),
            time: json["time"],
            endTime: json["endTime"],
            chats: json["chats"] == null ? [] : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
            v: json["__v"],
            dateObj: DateTime.tryParse(json["dateObj"] ?? ""),
            summary: json["summary"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "date": "${date!.year.toString().padLeft(4,'0')}-${date!.month.toString().padLeft(2,'0')}-${date!.day.toString().padLeft(2,'0')}",
        "time": time,
        "endTime": endTime,
        "chats": chats.map((x) => x.toJson()).toList(),
        "__v": v,
        "dateObj": dateObj?.toIso8601String(),
        "summary": summary,
    };

}

class Chat {
    Chat({
        required this.role,
        required this.message,
        required this.id,
        required this.time,
    });

    final String? role;
    final String? message;
    final String? id;
    final DateTime? time;

    factory Chat.fromJson(Map<String, dynamic> json){ 
        return Chat(
            role: json["role"],
            message: json["message"],
            id: json["_id"],
            time: DateTime.tryParse(json["time"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "role": role,
        "message": message,
        "_id": id,
        "time": time?.toIso8601String(),
    };
}
