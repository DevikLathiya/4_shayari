import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shayari/Home%20Page.dart';
void main() {
  runApp(MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    get_permission();
    super.initState();
  }

  get_permission()
  async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      print(statuses[Permission.storage]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.pink[100],shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30))),
        title: Text("Shayari App",style: TextStyle(color: Colors.black,fontSize: 25))),

      body: Container(margin: EdgeInsets.only(left: 3,right: 3,top: 3),
        decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2),
        borderRadius: BorderRadius.vertical(top: Radius.circular(60),bottom: Radius.circular(90)),
        image: DecorationImage(fit: BoxFit.fitHeight,image: AssetImage("images/UI 2.jpg"))),

        child: Center(
          child: Column(
            children: [
              Expanded(flex: 3,child: SizedBox()),

              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return HomePage();},
                      ));
                    });
                  },
                  child: Container(height: 100, width: 150,color: Colors.transparent,margin: EdgeInsets.only(bottom: 40),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
