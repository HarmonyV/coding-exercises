import 'package:library_exercise/users/user.dart';

enum Subject {
  math,
  geography,
  english,
  sport,
  biology,
  physics,
}

class Teacher extends User {
  final List<Subject> subjects;

  Teacher({
    required super.name,
    required this.subjects,
  }) : super(
          borrowLimit: 5,
        );
}
