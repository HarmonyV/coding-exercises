import 'dart:collection';

import 'package:library_exercise/items/library_item.dart';
import 'package:library_exercise/users/user.dart';

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

  // asuming you have a form for each user type, this is enought.
  void addMember(User member) => _members.add(member);
  void removeMember(User member) => _members.remove(member);

  void listBorrowedBooksByAllUsers() {
    for (final member in members) {
      print(
          "${member.name} currently has these items: ${member.borrowedItems}");
    }
  }

  void listOverdueItems() {
    final overdueItems =
        _inventory.where((i) => !i.isAvailable && i.isOverdue()).toList();
    print("Here are all the overdue items: $overdueItems");
  }
}
