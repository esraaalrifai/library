import 'author.dart';

class Book {
  int id;
  String name;
  int? authorId;

  Book({required this.name, required this.id, this.authorId});
  @override
  String toString() {
    return '$name : $id \n';
  }

  Map<String, dynamic> toJson({Author? author}) {
    return {"id": id, "name": name, "authorId": authorId,
      if (author != null) "author": author.toJson(),};
  }
}
