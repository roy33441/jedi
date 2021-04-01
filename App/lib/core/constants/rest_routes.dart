class RestRoutes {
  // Student
  static final fetchStudentInCourse =
      (int courseId) => '/courses/$courseId/students';

  static final studentArrived =
      (int studentId) => '/students/$studentId/arrived';

  static final studentLeft = (int studentId) => '/students/$studentId/left';

  // Report Type
  static final reportTypes = '/reportTypes';
  static final studentReportsByDate =
      (int studentId, String date) => '/students/$studentId/reportTypes/$date';
}
