import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peaudelaine/admin/fournisseur.dart';

import 'ajout.dart';

class ListFournisseur extends StatefulWidget {
  const ListFournisseur({Key? key}) : super(key: key);

  @override
  State<ListFournisseur> createState() => _ListFournisseurState();
}

class _ListFournisseurState extends State<ListFournisseur> {
  final CollectionReference _fournisseurs= FirebaseFirestore.instance.collection('fournisseurs');
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _idChauffeurController = TextEditingController();
  final TextEditingController _qteController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _matriculeController.text = documentSnapshot['matricule'];
      _idChauffeurController.text = documentSnapshot['IdChauffeur'];
      _qteController.text = documentSnapshot['qte'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _idChauffeurController,
                  decoration: InputDecoration(
                    labelText: 'Identifiant Chauffeur',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _matriculeController,
                  decoration: InputDecoration(
                    labelText: 'matricule camion',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _qteController,
                  decoration: InputDecoration(
                    labelText: 'quantité produit ',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String IdChauffeur = _idChauffeurController.text;
                    final String matricule = _matriculeController.text;
                    final String qte = _qteController.text;

                    await _fournisseurs
                        .doc(documentSnapshot!.id)
                        .update({"matricule": matricule, "IdChauffeur": IdChauffeur, "qte": qte});
                    _matriculeController.text = '';
                    _idChauffeurController.text = '';
                    _qteController.text = '';
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }
  Future<void> _delete(String fournisseurId) async{
    await _fournisseurs.doc(fournisseurId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a fournisseur')));
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Fournisseurs'),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Menu Icon',
        onPressed: () {},
      ),
      backgroundColor: Colors.brown,
    ),
    body: CupertinoScrollbar(
      thickness: 8,
      isAlwaysShown: true,
      child:StreamBuilder(
        stream: _fournisseurs.snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if (streamSnapshot.hasError){
            return Text('Something went wrong! ${streamSnapshot.error}');
          }
          if (streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context,index){
                final DocumentSnapshot documentSnapshot=
                streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                   child: ListTile(
                      title: Text(documentSnapshot['IdChauffeur']),
                      subtitle: Text(documentSnapshot['matricule'],),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _delete(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Ajout()),
        );
      },
      child: const Icon(Icons.add),
    ),
  );
  Widget buildDest(Fournisseur destination)=> ListTile(
    title: Text(destination.IdChauffeur),
    subtitle: Text(destination.matricule),
  );
  Stream<List<Fournisseur>> readDes() => FirebaseFirestore.instance
      .collection('fournisseurs')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Fournisseur.fromJson(doc.data())).toList());
}
