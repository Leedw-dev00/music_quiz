import 'package:flutter/material.dart';
import 'package:music_quiz/pages/quiz_page.dart';


class Rank_Page extends StatefulWidget{
  _Rank_PageState createState() => _Rank_PageState();
}

class _Rank_PageState extends State<Rank_Page>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF848FD8),
        elevation: 0.0,
        title: Text('Rank', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: (){Navigator.pop(context);},
        ),
        actions: [
          IconButton(icon: Icon(Icons.contact_support_outlined, color: Colors.white,), onPressed: (){})
        ],
      ),
      backgroundColor: Color(0xFF848FD8),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0,),
                Container(
                  height: MediaQuery.of(context).size.height*0.63,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFFAFB5E2),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20.0),
                          Text('1-50th', style: TextStyle(color: Colors.white, fontSize: 23.0),),
                          Spacer(),
                          Text('17 : 08 후 종료', style: TextStyle(fontSize: 16.0),),
                          SizedBox(width: 20.0),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: MediaQuery.of(context).size.height*0.55,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0,),
                GestureDetector(
                  child: Image.asset('assets/images/play_btn.png', width: MediaQuery.of(context).size.width*0.55, fit: BoxFit.cover,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quiz_Page(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}