class RestRoutes {
  // Student
  static final fetchStudentInCourse =
      (int courseId) => '/course/courseId/$courseId/students';

  static final studentArrived = (int cardId, int courseId) =>
      '/students/card/$cardId/arrived/course/$courseId';

  static final studentLeft = (int cardId, int courseId) =>
      '/students/card/$cardId/left/course/$courseId';

  // Report Type
  static final reportTypes = '/reportTypes';

  // Student Report
  static final studentReportsByDate = (int studentId, String date) =>
      '/students/studentId/$studentId/reportTypes/$date';

  // StudentMissing
  static final missingStudentsByDate =
      (String date) => '/students/missings/$date';

  // Missing reasons
  static final missingReason = '/missingReasons';

  static final repostMissingStudentByDate = (int studentId, String date) =>
      '/students/studentId/$studentId/missings/$date';

  static final removeMissingStudentByDate = (int studentId, String date) =>
      '/students/studentId/$studentId/missings/$date/cancel';
}
