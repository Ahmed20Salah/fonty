class User {
  String name;
  String email;
  String password;
  int id;
  String token;
  User.fromMap(map) {
    this.name = map['name'];
    this.email = map['email'];
    this.id = map['id'];
    this.token = map['token'];
  }
}
