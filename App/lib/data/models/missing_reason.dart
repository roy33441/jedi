import 'package:equatable/equatable.dart';

class MissingReason extends Equatable {
  final int id;
  final String text;

  MissingReason({
    required this.id,
    required this.text,
  });

  @override
  List<Object?> get props => [id, text];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }

  factory MissingReason.fromJson(Map<String, dynamic> map) {
    return MissingReason(
      id: map['id'],
      text: map['text'],
    );
  }
}
