import 'book.dart';

class Shelf {
  int id;
  String name;
List<int>?bookId;
  Shelf({required this.id, required this.name, this.bookId});
}
