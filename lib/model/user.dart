class User {
  final String name;
  final int age;

  User({
    required this.name,
    required this.age,
  });

  static User fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      age: map['age'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }
}
