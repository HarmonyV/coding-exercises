import 'package:library_exercise/institutes/accounting.dart';
import 'package:library_exercise/institutes/administration.dart';
import 'package:library_exercise/institutes/logistic.dart';
import 'package:library_exercise/items/library_item.dart';
import 'package:library_exercise/utils.dart';

enum Acces {
  title,
  author,
  publisher,
  isAvailable,
  publicationID,
  genre,
}

class Library {
  Library({required this.libraryName});

  final String libraryName;
  final administration = Administration();
  final logistic = Logistic();
  late final accounting = Accounting(
    logistic: logistic,
    members: administration.members,
  );

  List<LibraryItem> get _inventory => logistic.inventory;

  void listAvailableItems() {
    final availableItems = _inventory.where((i) => i.isAvailable).toList();
    print(
        "These are all the available Items you can borrow: ${getTitles(availableItems)}");
  }

  bool checkAvailability(LibraryItem item) {
    return _inventory
        .firstWhere((i) => i.publicationID == item.publicationID)
        .isAvailable;
  }

  void sortBy(Acces acces, String searchTerm) {
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
          return item.isAvailable.toString() == searchTerm;
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

    print(
        "These are all item in ${acces.name} that fit '$searchTerm': $sortedList");
  }
}
