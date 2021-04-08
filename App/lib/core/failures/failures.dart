abstract class Failure {
  final String? message;

  Failure({this.message});
}

class StudentMissingReasonReportFailure extends Failure {
  StudentMissingReasonReportFailure({String? message})
      : super(message: message);
}
