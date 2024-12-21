import 'package:cloud_firestore/cloud_firestore.dart';

class Fournisseur{
  String id;
  final String matricule;
  final String qte;
  final String IdChauffeur;


  Fournisseur({
    this.id='',
    required this.matricule,
    required this.qte,
    required this.IdChauffeur,
  });

  Map<String, dynamic> toJson() =>{
    'id':id,
    'matricule':matricule,
    'qte':qte,
    'IdChauffeur':IdChauffeur,
  };
  static Fournisseur fromJson(Map<String, dynamic> json)=> Fournisseur(
    id: json['id'],
    matricule: json['matricule'],
    qte: json['qte'],
    IdChauffeur: json['IdChauffeur'],
  );
}