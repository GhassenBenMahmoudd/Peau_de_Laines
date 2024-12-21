import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peaudelaine/admin/listClient.dart';
import 'package:peaudelaine/admin/login-screen.dart';
import 'package:peaudelaine/admin/produit.dart';
import 'listFournisseur.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),

      body: Center(

        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 500,
                child: ElevatedButton(
                child: Text("Liste Fournisseur" ,style: TextStyle(
                fontSize: 20,
                ),
                ),
                onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListFournisseur()));
                },
                  style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.brown),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
                ) ,
          ),

          SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 500,
                child: ElevatedButton(
                  child: Text("Liste Client",
                      style: TextStyle(
                    fontSize: 20
                      ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListClient()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.brown),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ) ,

              ),

              SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 500,
                child: ElevatedButton(
                  child: Text("Liste Produit",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListProduit()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.brown),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ) ,

              ),


              SizedBox(height: 20),
            ActionChip(label: Text("Logout"), onPressed: () {
              logout(context);
            }),
            ],
          ),
        ),
      ),
    );
  }
  Future <void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=>LoginScreen())
    );
  }
}

