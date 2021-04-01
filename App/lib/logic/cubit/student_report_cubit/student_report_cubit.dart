import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_report_state.dart';

class StudentReportCubit extends Cubit<StudentReportState> {
  StudentReportCubit() : super(StudentReportInitial());
}
