import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class GameBoardEntity {
  final String? gameId;
  final String? type;
  final String? owner;
  final Timestamp? time;
  final Map<String, dynamic>? content;
  GameBoardEntity({
    this.gameId,
    this.type,
    this.owner,
    this.time,
    this.content,
  });

  GameBoardEntity copyWith({
    String? gameId,
    String? type,
    String? owner,
    Timestamp? time,
    Map<String, dynamic>? content,
  }) {
    return GameBoardEntity(
      gameId: gameId ?? this.gameId,
      type: type ?? this.type,
      owner: owner ?? this.owner,
      time: time ?? this.time,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (gameId != null) {
      result.addAll({'gameId': gameId});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (owner != null) {
      result.addAll({'owner': owner});
    }
    if (time != null) {
      result.addAll({'time': time});
    }
    if (content != null) {
      result.addAll({'content': content});
    }

    return result;
  }

  factory GameBoardEntity.fromMap(Map<String, dynamic> map) {
    return GameBoardEntity(
      gameId: map['gameId'],
      type: map['type'],
      owner: map['owner'],
      time: map['time'] != null ? Timestamp.fromDate(map['time']) : null,
      content: Map<String, dynamic>.from(map['content']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GameBoardEntity.fromJson(String source) =>
      GameBoardEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GameBoardEntity(gameId: $gameId, type: $type, owner: $owner, time: $time, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GameBoardEntity &&
        other.gameId == gameId &&
        other.type == type &&
        other.owner == owner &&
        other.time == time &&
        mapEquals(other.content, content);
  }

  @override
  int get hashCode {
    return gameId.hashCode ^
        type.hashCode ^
        owner.hashCode ^
        time.hashCode ^
        content.hashCode;
  }
}
