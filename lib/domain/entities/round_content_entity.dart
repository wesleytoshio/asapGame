import 'dart:convert';

class RoundContentEntity {
  final String uuid;
  final String question;
  final List<RoundContentQuestionEntity> options;
  final String? answerFeedback;
  final String marketType;
  RoundContentEntity({
    required this.uuid,
    required this.question,
    required this.options,
    required this.marketType,
    this.answerFeedback,
  });

  RoundContentEntity copyWith({
    String? uuid,
    String? question,
    List<RoundContentQuestionEntity>? options,
    String? answerFeedback,
    String? marketType,
  }) {
    return RoundContentEntity(
      uuid: uuid ?? this.uuid,
      question: question ?? this.question,
      options: options ?? this.options,
      answerFeedback: answerFeedback ?? this.answerFeedback,
      marketType: marketType ?? this.marketType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uuid': uuid});
    result.addAll({'question': question});
    result.addAll({'options': options.map((x) => x.toMap()).toList()});
    if (answerFeedback != null) {
      result.addAll({'answerFeedback': answerFeedback});
    }
    result.addAll({'marketType': marketType});

    return result;
  }

  factory RoundContentEntity.fromMap(Map<String, dynamic> map) {
    return RoundContentEntity(
      uuid: map['uuid'] ?? '',
      question: map['question'] ?? '',
      options: List<RoundContentQuestionEntity>.from(
        map['options']?.map((o) => RoundContentQuestionEntity.fromMap(o)),
      ),
      answerFeedback: map['answer_feedback'],
      marketType: map['marketType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RoundContentEntity.fromJson(String source) =>
      RoundContentEntity.fromMap(json.decode(source));
}

class RoundContentQuestionEntity {
  final String uuuid;
  final String option;
  final bool correct;
  final bool select;
  RoundContentQuestionEntity({
    required this.uuuid,
    required this.option,
    required this.correct,
    required this.select,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uuuid': uuuid});
    result.addAll({'option': option});
    result.addAll({'correct': correct});
    result.addAll({'select': select});

    return result;
  }

  factory RoundContentQuestionEntity.fromMap(Map<String, dynamic> map) {
    return RoundContentQuestionEntity(
      uuuid: map['uuuid'] ?? '',
      option: map['option'] ?? '',
      correct: map['correct'] ?? false,
      select: map['select'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoundContentQuestionEntity.fromJson(String source) =>
      RoundContentQuestionEntity.fromMap(json.decode(source));
}
