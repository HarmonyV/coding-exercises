import 'package:library_exercise/library.dart';
import 'package:library_exercise/items/book.dart';
import 'package:library_exercise/items/library_item.dart';
import 'package:library_exercise/items/magizine.dart';
import 'package:library_exercise/users/teacher.dart';

import 'package:collection/collection.dart';
import 'package:library_exercise/users/user.dart';

void main() {
  Library myLibrary = Library(libraryName: "My Awesome Library");

  Map<String, dynamic> bookData = {
    'title': '1984',
    'author': 'George Orwell',
    'genre': Genre.dystopian,
    'publisher': 'Secker & Warburg',
    'isAvailable': true
  };
  Map<String, dynamic> bookData2 = {
    'title': 'To Kill a Mockingbird',
    'author': 'Harper Lee',
    'genre': Genre.southernGothic,
    'publisher': 'J.B. Lippincott & Co.',
    'isAvailable': true
  };

  final book1 = Book.fromJson(bookData);
  final book2 = Book.fromJson(bookData2);

  final magazine = Magazine(
    title: "National Geographic",
    author: "Various",
    publisher: "National Geographic Society",
    genre: Genre.science,
  );

  myLibrary.addLibraryItems([magazine, book1, book2]);
  myLibrary.sortBy(Acces.isAvailable);

  myLibrary.createTeacherMember("Mr. Smith", [Subject.english, Subject.sport]);

  User? mrSmith =
      myLibrary.members.firstWhereOrNull((user) => user.name == "Mr. Smith");

  if (mrSmith != null && mrSmith is Teacher) {
    mrSmith.borrowItems([book1], myLibrary);
  }

  myLibrary.generateReport(Reports.borrowedBooksByUsers);
  myLibrary.generateReport(Reports.overdueItems);
  myLibrary.generateReport(Reports.lastBorrowedBookByUser, mrSmith);
}
