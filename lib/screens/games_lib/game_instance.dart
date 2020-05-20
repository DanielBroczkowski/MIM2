import 'package:flutter/material.dart';
import 'package:mim2/widgets/send_to_database.dart';
import 'package:mim2/model/record_type.dart';
import 'package:mim2/model/lib.dart';

class GameInstance extends StatefulWidget {
  Library game;
  GameInstance(this.game);

  @override
  _GameInstanceState createState() => _GameInstanceState();
}

class _GameInstanceState extends State<GameInstance> {
  Library game;
  @override
  void initState() {
    game = widget.game;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff2e2e2e).withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.redAccent),
          boxShadow: [
            BoxShadow(
              //color: Colors.redAccent[100],
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(Icons.videogame_asset , size: 50,),
          title: Text("Tytuł: ${game.game.title}", style: TextStyle(fontSize: 20,),),
          subtitle: Text("Producent: ${game.game.producer} \nRok wydania: ${game.game.year} \nUkończone: ${ifGamePlayed()}"),
          trailing: InkWell(
              onTap: (){Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SendToDatabase(RecordType.GAMEEDIT, library: game,), ));},
              child: Icon(Icons.build)),
          isThreeLine: true,
        ),
      ),
    );
  }
  String ifGamePlayed(){
    if(game.game.played == true){
      return "tak";
    }
    else{
      return "nie";
    }
  }
}