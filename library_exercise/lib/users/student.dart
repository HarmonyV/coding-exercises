import 'package:library_exercise/users/user.dart';

enum GradeLvl {
  primarySchool(string: "Primary School"),
  elementarySchool(string: "Elementary School"),
  middleSchool(string: "Middle School"),
  highSchool(string: "High School"),
  higherEducation(string: "Higher Education"),
  ;

  const GradeLvl({required this.string});
  final String string;
}

class Student extends User {
  GradeLvl gradeLvl;

  Student({
    required super.name,
    required this.gradeLvl,
  }) : super(
          borrowLimit: 3,
        );
}
