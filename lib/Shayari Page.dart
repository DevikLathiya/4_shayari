import 'dart:math';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari/Edit%20Page.dart';
import 'List Page.dart';

class ShayariPage extends StatefulWidget {
  int full,main;
  ShayariPage(this.full,this.main);

  @override
  State<ShayariPage> createState() => _ShayariPageState();
}

class _ShayariPageState extends State<ShayariPage> {
  PageController controller = PageController();
  bool tmp_color = false;
  int col_ind = 0,emo=0;

  @override
  void initState() {
    controller=PageController(initialPage: widget.full);
    super.initState();
    emo=Random().nextInt(emoji.length);
  }
  @override
  Widget build(BuildContext context)  {

    double screen_height=MediaQuery.of(context).size.height; // screen total height
    double status_bar = MediaQuery.of(context).padding.top;  // status bar height
    double appbar = kToolbarHeight;                          // appbar height
    double cont_height = screen_height-status_bar-appbar;

    return Scaffold(
      appBar: AppBar(title: Text("${Mshayri[widget.main]}",),backgroundColor: Colors.red.shade200,),
      backgroundColor: Colors.lightGreen[100],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 15),
              child: Container(margin: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(color: Colors.blue.shade100),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,  // for scroll
                        barrierColor: Colors.transparent,   // backcolor
                        context: context, builder: (context) {
                        return Container(
                          width: double.infinity,
                          height: cont_height,
                          child: GridView.builder(
                            itemCount: mycolor.length-1,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      col_ind=index;
                                      tmp_color=true;
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [mycolor[index],mycolor[index+1]],
                                      )
                                    ),
                                  ),
                                );
                              },),
                        );
                      },);

                    }, icon: Icon(Icons.fullscreen),padding: EdgeInsets.only(right: 15),iconSize: 45,),

                    Text("${widget.full+1}/${list.length}", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),

                    IconButton(onPressed: () {
                      setState(() {
                       int r= Random().nextInt(mycolor.length-1);
                       col_ind=r;
                       tmp_color=true;
                      });
                    }, icon: Icon(Icons.refresh_rounded),padding: EdgeInsets.only(left: 15),iconSize: 40,)
                  ],
                ),
              ),
            ),
            Expanded(flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    widget.full=value;
                  });
                },
                controller: controller,   itemCount: list.length,
                itemBuilder: (context, index) {
                return Container(margin: EdgeInsets.only(top: 30,left: 5,right: 5,bottom: 40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(168, 237, 234,100),
                      gradient: tmp_color==true ?LinearGradient(colors: [mycolor[col_ind],mycolor[col_ind+1]]) : null,
                      borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black,width: 2),),
                  child: Expanded(child: Text(
                    "${emoji[emo]} \n${list[widget.full]}\n ${emoji[emo]}",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,)),
                );
              },)
            ),
            Expanded(flex: 1,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {
                  setState(() {
                    FlutterClipboard.copy("${emoji[emo]} \n${list[widget.full]}\n ${emoji[emo]}").then(( value ) =>
                        Fluttertoast.showToast(
                            msg: "Text Copied..",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0
                        ));
                        });
                      }, child: Icon(Icons.copy),
                      style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(60, 35)))),

                  ElevatedButton(onPressed: () {
                    setState(() {
                      if(widget.full != 0)
                      {
                        widget.full--;
                        controller.jumpToPage(widget.full);
                      }
                    });
                  }, child: Icon(Icons.arrow_back_ios),
                      style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(60, 35)))),

                  ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return EditPage(widget.full,emo);
                    },));
                  }, child: Icon(Icons.settings),
                      style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(60, 35)))),

                  ElevatedButton(onPressed: () {
                    setState(() {
                      if(widget.full != list.length-1)
                      {
                        widget.full++;
                        //controller.jumpToPage(widget.full);
                      }else
                      {
                        widget.full = 0;
                      }
                    });
                  }, child: Icon(Icons.arrow_forward_ios),
                      style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(60, 35)))),

                  ElevatedButton(onPressed: () {
                    setState(() {
                      Share.share("${emoji[emo]} \n${list[widget.full]}\n ${emoji[emo]}");
                    });
                  }, child: Icon(Icons.share),
                      style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(60, 35))))
                    // style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(30, 30))),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
