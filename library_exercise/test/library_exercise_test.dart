import 'package:collection/collection.dart';
import 'package:library_exercise/institutes/library.dart';
import 'package:library_exercise/items/book.dart';
import 'package:library_exercise/items/library_item.dart';
import 'package:library_exercise/items/magizine.dart';
import 'package:library_exercise/users/student.dart';
import 'package:library_exercise/users/teacher.dart';
import 'package:library_exercise/users/user.dart';
import 'package:test/test.dart';

void main() {
  final myLibrary = Library(libraryName: "Library of Alexandria");

  final mrSmith =
      Teacher(name: "Mr. Smith", subjects: [Subject.biology, Subject.english]);

  myLibrary.administration.addMember(mrSmith);

  User? alice;

  Map<String, dynamic> bookData = {
    'title': '1984',
    'author': 'George Orwell',
    'genre': Genre.dystopian,
    'publisher': 'Secker & Warburg',
    'isAvailable': false
  };

  final magazine = Magazine(
    title: "National Geographic",
    author: "Various",
    publisher: "National Geographic Society",
    genre: Genre.science,
  );

  myLibrary.logistic.addLibraryItems([magazine]);

  test("add item to library", () {
    myLibrary.logistic.addLibraryItems([magazine]);

    expect(myLibrary.logistic.inventory.contains(magazine), true);
  });

  test("Book from json", () {
    final book1 = Book.fromJson(bookData);

    expect(book1.isAvailable == true, false);
  });

  test("Create a user", () {
    myLibrary.administration
        .createStudentMember("Alice", GradeLvl.middleSchool);

    alice = myLibrary.administration.members
        .firstWhereOrNull((user) => user.name == "Alice");

    expect(alice != null && alice is Student, true);
  });

  test("Borrow item", () {
    mrSmith.borrowItems([magazine], myLibrary);

    expect(
        magazine.isAvailable == false &&
            myLibrary.checkAvailability(magazine) == false,
        true);
  });

  test("Return item", () {
    mrSmith.returnItems([magazine]);
    expect(
        magazine.isAvailable == true &&
            myLibrary.checkAvailability(magazine) == true,
        true);
  });
}
