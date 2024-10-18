import 'package:library_exercise/users/student.dart';
import 'package:library_exercise/users/teacher.dart';
import 'package:library_exercise/users/user.dart';

class Administration {
  final members = <User>[];

  void addMember(User member) {
    members.add(member);
  }

  void createAnyMember(String name) {
    final user = User(name: name);
    members.add(user);
  }

  void createStudentMember(String name, GradeLvl gradeLvl) {
    final student = Student(name: name, gradeLvl: gradeLvl);
    members.add(student);
  }

  void createTeacherMember(String name, List<Subject> subjects) {
    final teacher = Teacher(name: name, subjects: subjects);
    members.add(teacher);
  }
}
