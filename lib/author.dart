class Author {
  int id;
  String firstName;
  String? lastName;

  Author({required this.id, required this.firstName, this.lastName});
  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "firstName":firstName,
      "lastName":lastName,
    };
  }
}
