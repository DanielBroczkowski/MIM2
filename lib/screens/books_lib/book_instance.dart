import 'package:flutter/material.dart';
import 'package:mim2/widgets/send_to_database.dart';
import 'package:mim2/model/record_type.dart';
import 'package:mim2/model/lib.dart';

class BookInstance extends StatefulWidget {
  Library book;
  BookInstance(this.book);

  @override
  _BookInstanceState createState() => _BookInstanceState();
}

class _BookInstanceState extends State<BookInstance> {
  Library book;

  @override
  void initState() {
    book = widget.book;
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
          border: Border.all(width: 1, color: Colors.amberAccent),
          boxShadow: [
            BoxShadow(
              //color: Colors.greenAccent[100],
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(Icons.book , size: 50,),
          title: Text("Tytuł: ${book.book.title}", style: TextStyle(fontSize: 20,),),
          subtitle: Text("Autor: ${book.book.author} \nRok wydania: ${book.book.year} \nUkończone: ${ifBookRed()}"),
          trailing: InkWell(
              onTap: (){Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SendToDatabase(RecordType.BOOKEDIT, library: book,),));},
              child: Icon(Icons.edit)),
          isThreeLine: true,
        ),
      ),
    );
  }
  String ifBookRed(){
    if(book.book.read == true){
      return "tak";
    }
    else{
      return "nie";
    }
  }
}
