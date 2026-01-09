class Book {
  String name;
  String author;

  Book({required this.name, required this.author});
  @override
  String toString() {
    return '$name : $author \n';
  }
}
