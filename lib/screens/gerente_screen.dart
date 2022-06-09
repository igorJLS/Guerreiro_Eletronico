import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GerenteScreen extends StatelessWidget {
  const GerenteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var snapshot = FirebaseFirestore.instance
        .collection('users')
        .where('nome', isNotEqualTo: null)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento usuario'),
      ),
      body: StreamBuilder(
        stream: snapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum usuario cadastrado'));
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int i) {
              var item = snapshot.data!.docs[i].data;
              return ListTile(
                leading: IconButton(
                    icon: const Icon(Icons.person), onPressed: () => null),
                title: const Text('Nome'),
                subtitle: const Text('Categoria'),
                trailing: Wrap(
                  spacing: 12,
                  children: const [Icon(Icons.delete), Icon(Icons.edit)],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
