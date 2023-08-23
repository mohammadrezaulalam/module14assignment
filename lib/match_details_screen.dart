import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MatchDetailScreen extends StatelessWidget {
  final DocumentReference matchRef;

  const MatchDetailScreen(this.matchRef, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: matchRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasError){
          return const Center(child: Text('There is an Error to fetch data!'),);
        }
        final matchData = snapshot.data!.data() as Map;
          return Scaffold(
          appBar: AppBar(
            title: Text(
              matchData['match_name'],
              style: GoogleFonts.alata(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                color: Colors.white
              ),
            ),
            centerTitle: true,),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height/4,
              width: double.infinity,
              child: Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                      matchData['match_name'],
                      style: GoogleFonts.alata(
                        textStyle: Theme.of(context).textTheme.titleLarge,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          matchData['score_team_a'].toString(),
                          style: GoogleFonts.figtree(
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          ' : ',
                          style: GoogleFonts.figtree(
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple
                          ),
                        ),
                        Text(
                          matchData['score_team_b'].toString(),
                          style: GoogleFonts.figtree(
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Time : ${matchData['running_time']}",
                      style: GoogleFonts.figtree(
                        textStyle: Theme.of(context).textTheme.titleLarge,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Total Time : ${matchData['total_time']}",
                      style: GoogleFonts.figtree(
                        textStyle: Theme.of(context).textTheme.titleLarge,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ],
                  ),
                  ),
              ),
            ),
          ),
        );
        
      },
    );
  }
}
