import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String senha;
  final String categoria;

  const User(
      {required this.categoria,
      required this.name,
      required this.email,
      required this.senha});

  Map<String, dynamic> toJson() => {
        'nome': name,
        'email': email,
        'senha': senha,
        'categoria': categoria,
      };
}

Future createUser(user) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  final json = user.toJson();
  await docUser.set(json);
}
