import 'package:firebase_football_app/match_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';


class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        'Match List',
        style: GoogleFonts.figtree(
            textStyle: Theme.of(context).textTheme.titleLarge,
            fontSize: 23,
            fontWeight: FontWeight.w400,
            color: Colors.white
        ),
      ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('football').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return const Center(child: Text('There is an Error to fetch data!'),);
          }
          final matches = snapshot.data!.docs;
        return ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, index){
            final match = matches[index];
            return ListTile(
              title: Text(
                match['match_name'],
                style: GoogleFonts.figtree(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
                ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MatchDetailScreen(match.reference) ));
              },
            );
        });
      })
    );
  }
}
