import 'package:library_exercise/items/library_item.dart';

class Logistic {
  final inventory = <LibraryItem>[];

  void addLibraryItems(List<LibraryItem> libraryItems) {
    for (final i in libraryItems) {
      inventory.add(i);
    }
  }

  void removeLibraryItems(List<LibraryItem> libraryItems) {
    for (final item in libraryItems) {
      inventory.removeWhere((i) => i.publicationID == item.publicationID);
    }
  }
}
