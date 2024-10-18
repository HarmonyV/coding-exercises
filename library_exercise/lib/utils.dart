import 'package:library_exercise/items/library_item.dart';

List<String> getTitles(List<LibraryItem> libraryItems) {
  return [for (var item in libraryItems) item.title];
}
