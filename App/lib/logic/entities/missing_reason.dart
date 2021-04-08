import 'package:equatable/equatable.dart';

import '../../data/models/missing_reason.dart';

class MissingReasonEntity extends Equatable {
  final int id;
  final String text;

  MissingReasonEntity({
    required this.id,
    required this.text,
  });

  @override
  List<Object?> get props => [id, text];

  MissingReason toModel() => MissingReason(id: id, text: text);

  factory MissingReasonEntity.fromModel(MissingReason missingReasonModel) {
    return MissingReasonEntity(
      id: missingReasonModel.id,
      text: missingReasonModel.text,
    );
  }
}

class NoReasonReported {}
