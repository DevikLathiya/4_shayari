import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'List Page.dart';

class EditPage extends StatefulWidget {
  int full,emo;
  EditPage(this.full,this.emo);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  int tmp_index=0,text_index=0,col_ind = 0 , emo=0, fon=0;
  bool back_color = false , text_color =false,tmp_color = false ,tmp_image=false;
  double cur_size=25; String cur_font="font1";
  List fonts=["font1","font2","font3","font4","font5","font6","font7","font8","font9"];

  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {

    double screen_height=MediaQuery.of(context).size.height; // screen total height
    double status_bar = MediaQuery.of(context).padding.top;  // status bar height
    double appbar = kToolbarHeight;                          // appbar height
    double cont_height = screen_height-status_bar-appbar;


    return Scaffold(backgroundColor: Colors.teal.shade100,
      appBar: AppBar(
        title: Text("Edit Shayari"),
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black,width: 2),borderRadius: BorderRadius.vertical(
            top: Radius.circular(30), bottom: Radius.circular(30),))
      ),
      body: Column(
        children: [
          Expanded(flex: 3,
            child: WidgetsToImage(controller: controller,
              child: Container(margin: EdgeInsets.only(top: 50,left: 15,right: 15,bottom: 40),
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black,width: 2),
                  color: back_color==true ? mycolor[tmp_index] : null,
                  gradient: tmp_color==true ? LinearGradient(colors: [mycolor[col_ind],mycolor[col_ind+1]]): null
                ),
                child: Text(
                  "${emoji[widget.emo]} \n ${list[widget.full]} \n ${emoji[widget.emo]}",
                  style: TextStyle(fontSize: cur_size,fontFamily: fonts[fon],
                      color: text_color==true ? mycolor[text_index] : null),
                  textAlign: TextAlign.center,),
              ),
            ),
          ),
         //Expanded(child: Container(child: (tmp_image==true) ? Image.memory(bytes!) : null,),),
         Container(width: 200,
           decoration: BoxDecoration(color: Colors.blue.shade300,border: Border.all(color: Colors.blue)),
           child: Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
               IconButton(onPressed: () {
                 showModalBottomSheet(
                   isScrollControlled: true, barrierColor: Colors.transparent,
                   context: context, builder: (context) {
                   return Container(
                     color: Colors.red.shade100, height: cont_height,width: double.infinity,
                     child: GridView.builder(itemCount: mycolor.length-1,
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
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
                                 gradient: LinearGradient(colors: [mycolor[index],mycolor[index+1]])
                             ),
                           ),
                         );
                       },),
                   );
                 },);
               }, icon: Icon(Icons.fullscreen),padding: EdgeInsets.only(right: 10),iconSize: 45,),

               IconButton(onPressed: () {
                 setState(() {
                   int r= Random().nextInt(mycolor.length-1);
                   col_ind=r;
                   tmp_color=true;
                 });
               }, icon: Icon(Icons.refresh_rounded),padding: EdgeInsets.only(left: 5),iconSize: 40,)
             ],
           ),
         ),
          Expanded(
            child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true, barrierColor: Colors.transparent,
                        context: context, builder: (context) {
                        return Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity, height: 200,
                                color: Colors.blue.shade50,
                                child: GridView.builder(itemCount: mycolor.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            tmp_index=index;
                                            back_color=true;
                                            tmp_color=false;
                                          });
                                        },
                                        child: Container( margin: EdgeInsets.all(5),
                                          color: mycolor[index],
                                        )
                                      );
                                    },),
                              ),
                            ),
                            IconButton(onPressed: () {
                              Navigator.pop(context);
                            }, icon: Icon(Icons.close))
                          ],
                        );
                      },);

                    }, child: Text("BackGround"),
                        style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(110, 35)))),

                    ElevatedButton(onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true, barrierColor: Colors.transparent,
                        context: context, builder: (context) {
                        return Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity, height: 200,
                                color: Colors.blue.shade50,
                                child: GridView.builder(itemCount: mycolor.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            text_index=index;
                                            text_color = true;
                                          });
                                        },
                                        child: Container( margin: EdgeInsets.all(5),
                                          color: mycolor[index],
                                        ),
                                      );
                                    },),
                              ),
                            ),
                            IconButton(onPressed: () {
                              Navigator.pop(context);
                            }, icon: Icon(Icons.close))
                          ],
                        );
                      },);
                    }, child: Text("Text Color"),
                        style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(110, 35)))),

                    ElevatedButton(onPressed: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        context: context, builder: (context) {
                        return Container(height: 100,margin: EdgeInsets.all(5),
                          child: StatefulBuilder(builder: (context, setState1) {
                            return Row(
                              children: [
                                Text("  ${cur_size.toInt()}"),
                                Expanded(flex: 2,
                                  child: Slider(value: cur_size, label: cur_size.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      setState1(() {
                                        cur_size = value;
                                      });
                                    });
                                  },min: 15,max: 50,),
                                ),
                              ],
                            );
                          },),
                        );
                      },);
                    }, child: Text("Text Size"),
                      style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(110, 35))),),
                  ],
                ),

                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) {
                        return Container(
                          height: 100,margin: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: ListView.builder(itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      fon=index;
                                    });
                                  },
                                  child: Container(margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                    alignment: Alignment.center,
                                    height: 30,width: 100,color: Colors.red.shade100,
                                    child: Text("Shayari",style: TextStyle(fontSize: 20,fontFamily: fonts[index]),textAlign: TextAlign.center),),
                                );
                              },scrollDirection: Axis.horizontal,itemCount: fonts.length,)),

                              IconButton(onPressed: () {
                                Navigator.pop(context);
                              }, icon: Icon(Icons.close))
                            ],
                          ),
                        );
                      },);
                    }, child: Text("Font"),
                      style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(110, 35))),),

                    ElevatedButton(onPressed: () {
                      showModalBottomSheet(
                        barrierColor: Colors.transparent, backgroundColor: Colors.redAccent.shade100,isScrollControlled: true,
                        context: context, builder: (context) {
                        return Container(height: 400,
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.separated(itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        widget.emo=index;
                                      });
                                    },
                                    title: Text("${emoji[index]}",style: TextStyle(fontSize: 20),textAlign: TextAlign.center),);
                                }, separatorBuilder: (context, index) {
                                  return Divider(color: Colors.white,);
                                }, itemCount: emoji.length),
                              ),
                              IconButton(onPressed: () {
                                Navigator.pop(context);
                              }, icon: Icon(Icons.close))
                            ],
                          ),
                        );
                      },);
                    }, child: Text("Emoji"), style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(110, 35))),),

                    ElevatedButton(onPressed: () async {
                      if((back_color || tmp_color)==true) {
                        await controller.capture().then((value) {
                          bytes = value;
                          tmp_image = true;
                        });
                        var path =await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/Devik";
                        Directory dir = Directory(path);
                          if (!await dir.exists()) // if dir is blank(!) to create
                          {
                            await dir.create();
                          }
                          int r = Random().nextInt(1000); // genrate random no
                        String img_name = "iamge${r}.jpg"; // make image name
                        File fn = File("${dir.path}/${img_name}"); // image(file) store path
                        fn.writeAsBytes(bytes!);

                        //Share.shareFiles(['${fn.path}']);
                        Share.shareXFiles([XFile(fn.path)], text: "");
                        setState(() {});
                      }
                      else
                        {
                          Fluttertoast.showToast(
                              msg: "Plz Select Any Color",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }
                    }, child: Text("Share"),
                      style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(110, 35))),)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
