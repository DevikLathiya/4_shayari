import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'List Page.dart';
import 'Shayari Page.dart';

class SubCategory extends StatefulWidget  {
  int sub, full;
  SubCategory(this.sub,this.full);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {

  @override
  void initState() {
      if(widget.sub==0) { list=[];  list.addAll(love);}
      else if(widget.sub==1) { list=[]; list.addAll(sad); }
      else if(widget.sub==2) { list=[]; list.addAll(god); }
      else if(widget.sub==3) { list=[]; list.addAll(friend); }
      else if(widget.sub==4) { list=[]; list.addAll(life); }
      else if(widget.sub==5) { list=[]; list.addAll(other); }
      else if(widget.sub==6) { list=[]; list.addAll(intresting); }
      else if(widget.sub==7) { list=[]; list.addAll(alcoholic); }
      else if(widget.sub==8) { list=[]; list.addAll(birthday); }
      else if(widget.sub==9) { list=[]; list.addAll(memories); }
      else if(widget.sub==10) { list=[]; list.addAll(pain); }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(title: Text("${Mshayri[widget.sub]}"),
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black,width: 2),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30),)),backgroundColor: Colors.red.shade200,),

      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding:  EdgeInsets.only(top: 5,left: 10,right: 10),
          child: ListTile(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ShayariPage(index,widget.full);
            },));
          },
          title: Text("${list[index].substring(0,50)}...",maxLines: 2,textAlign: TextAlign.center),
          tileColor: Colors.teal.shade100, hoverColor: Colors.cyan,
          shape: RoundedRectangleBorder(side: BorderSide(width: 2,color: Colors.black), borderRadius: BorderRadius.circular(10)),
          leading: SizedBox(width: 60,height: 50,
            child: CircleAvatar(backgroundImage: AssetImage("images/${image[widget.sub]}"),)),
          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
          contentPadding: EdgeInsets.only(top: 4,bottom: 4,left: 4),),
        );
      },
          itemCount: list.length),
    );
  }

}
