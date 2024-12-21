
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peaudelaine/admin/fournisseur.dart';
import 'dart:io';
import 'fournisseur.dart';

class Ajout extends StatefulWidget {
  const Ajout({Key? key}) : super(key: key);

  @override
  State<Ajout> createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  final mat = TextEditingController();
  final qtte = TextEditingController();
  final idCh = TextEditingController();

  @override
  Widget build(BuildContext context) =>Scaffold(
    appBar: AppBar(
      title: Text('Add Fournisseur'),
      backgroundColor: Colors.black,
    ),
    body: ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        TextField(controller: mat,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Matricule",
            )),
        const SizedBox(height: 24),


        TextField(controller: idCh,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Identifiant Chauffeur",
            )),


        const SizedBox(height: 24),
        TextField(controller: qtte,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Quantité",
            )),
        const SizedBox(height: 24),
        ElevatedButton(
          child: Text('create'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          onPressed: () {
            final matricule = mat.text;
            final IdChauffeur = idCh.text;
            final qte = qtte.text;

            createFournisseur(matricule: matricule, IdChauffeur: IdChauffeur, qte:qte);
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
Future createFournisseur({required String matricule, required String IdChauffeur, required String qte}) async {
  final docDest = FirebaseFirestore.instance.collection('fournisseurs').doc();

  final fournisseur = Fournisseur(
    id: docDest.id,
    matricule: matricule,
    qte: qte,
    IdChauffeur: IdChauffeur,
  );
  final json = fournisseur.toJson();

  await docDest.set(json);
}

