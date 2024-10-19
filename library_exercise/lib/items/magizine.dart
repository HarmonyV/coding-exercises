import 'dart:collection';

import 'package:library_exercise/items/library_item.dart';

class Magazine extends LibraryItem {
  Magazine({
    required super.title,
    required super.author,
    required super.publisher,
    required super.genre,
    super.myAvailability,
    super.newId,
  }) : super(
          baseFee: 0.2,
          interestRate: 0.2,
        );

  @override
  UnmodifiableMapView<String, dynamic> get details => UnmodifiableMapView({
        "Title": title,
        "Publisher": publisher,
        "Type": genre,
      });
}
