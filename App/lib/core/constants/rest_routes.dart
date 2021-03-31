class RestRoutes {
  static final fetchStudentInCourse =
      (int courseId) => '/courses/$courseId/students';

  static final studentArrived =
      (int studentId) => '/students/$studentId/arrived';

  static final studentLeft = (int studentId) => '/students/$studentId/left';
}
