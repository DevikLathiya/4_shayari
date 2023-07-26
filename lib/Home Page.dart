import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shayari/Second%20Page.dart';
import 'List Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 List <bool> tap=[];
 @override
  void initState() {
   tap=List.filled(Mshayri.length, false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.yellow[100],
      appBar: AppBar(title: Text("Shayari",style: TextStyle(fontSize: 25 )),
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black,width: 2),borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),)),backgroundColor: Colors.red.shade200,
      ),

      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(padding: EdgeInsets.only(top: 8.0,left: 10,right: 10),
          child: GestureDetector(
            onTapCancel: () {
              setState(() {
                tap[index] =false;
              });
            },
            onTapDown: (details) {
              setState(() {
                tap[index] = true;
              });
            },
            child: ListTile(
              onTap: () {
                tap[1] = false;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SubCategory(index,index);
                },));},
              leading: SizedBox(height: 60, width: 60,
                 child: CircleAvatar(backgroundImage: AssetImage("images/${image[index]}"),)),
              hoverColor: Colors.red,tileColor: (tap[index]) ? Colors.red : Colors.amber[300],
              trailing: Icon(Icons.arrow_forward_ios,size: 30,color: Colors.black,),
              title: Text("${Mshayri[index]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black,width: 2),
                borderRadius: BorderRadius.circular(10),),

              contentPadding: EdgeInsets.all(4),
            ),
          ),
        );
      },
          itemCount: Mshayri.length),
    );
  }
}
