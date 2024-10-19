import 'dart:collection';

import 'package:library_exercise/items/library_item.dart';
import 'package:library_exercise/users/student.dart';
import 'package:library_exercise/users/teacher.dart';
import 'package:library_exercise/users/user.dart';

enum Acces {
  title,
  author,
  publisher,
  isAvailable,
  publicationID,
  genre,
}

enum Reports {
  borrowedBooksByUsers,
  overdueItems,
  lastBorrowedBookByUser,
}

class Library {
  Library({required this.libraryName});

  final String libraryName;
  final _inventory = <LibraryItem>[];
  final _members = <User>[];

  UnmodifiableListView<LibraryItem> get inventory =>
      UnmodifiableListView(_inventory);

  UnmodifiableListView<User> get members => UnmodifiableListView(_members);

  void addLibraryItems(List<LibraryItem> libraryItems) =>
      _inventory.addAll(libraryItems);

  void removeLibraryItems(List<LibraryItem> libraryItems) {
    for (final item in libraryItems) {
      _inventory.removeWhere((i) => i.publicationID == item.publicationID);
    }
  }

  void sortBy(Acces acces, [String searchTerm = ""]) {
    final sortedList = _inventory.where((item) {
      switch (acces) {
        case Acces.title:
          return item.title == searchTerm;
        case Acces.author:
          return item.author == searchTerm;
        case Acces.publisher:
          return item.publisher == searchTerm;
        case Acces.genre:
          return item.genre.string == searchTerm;
        case Acces.isAvailable:
          return item.isAvailable == true;
        case Acces.publicationID:
          return item.publicationID == searchTerm;
        default:
          return false;
      }
    }).toList();

    if (sortedList.isEmpty) {
      print("These are no item in ${acces.name} that fit '$searchTerm'");
      return;
    }
    if (searchTerm.isEmpty) {
      print("These are all the available Items you can borrow: $sortedList");
    }
    print(
        "These are all item in ${acces.name} that fit '$searchTerm': $sortedList");
  }

  void addMember(User member) => _members.add(member);
  void removeMember(User member) => _members.remove(member);

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

  void generateReport(Reports reportType, [User? user]) {
    switch (reportType) {
      case Reports.borrowedBooksByUsers:
        for (final member in members) {
          print(
              "${member.name} currently has these items: ${member.borrowedItems}");
        }

      case Reports.overdueItems:
        final overdueItems =
            _inventory.where((i) => !i.isAvailable && i.isOverdue()).toList();
        print("Here are all the overdue items: $overdueItems");

      case Reports.lastBorrowedBookByUser:
        if (user == null) {
          print("Please provide a user");
          return;
        }
        if (user.borrowedHistory.isNotEmpty) {
          print("${user.name} has last borrowed ${user.borrowedHistory.last}");
        } else {
          print("${user.name} has no borrowing history.");
        }

      default:
        print("Invalid report type");
    }
  }
}
