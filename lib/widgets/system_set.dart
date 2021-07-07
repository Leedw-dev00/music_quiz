import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';


class System_Set extends StatefulWidget{
  _System_SetState createState() => _System_SetState();
}

class _System_SetState extends State<System_Set>{
  bool sound_onoff = false;
  bool vib_onoff = false;


  @override
  void initState(){
    bool sound_onoff;
    bool vib_onoff;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: <Widget>[
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 150.0,
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Color(0xFFcfcfcf)),
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 30.0,),
                    Text('마스터 볼륨', style:
                      TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                      ),
                    ),
                    Spacer(),
                    FlutterSwitch(
                      height: 25.0,
                      showOnOff: true,
                      activeColor: Colors.blueAccent,

                      inactiveTextColor: Colors.white,
                      value: sound_onoff,
                      onToggle: (val){
                        setState(() {
                          sound_onoff = val;
                        });
                      }
                    ),
                    SizedBox(width: 30.0,)
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: <Widget>[
                    SizedBox(width: 30.0,),
                    Text('진동', style:
                    TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                    ),
                    ),
                    Spacer(),
                    FlutterSwitch(
                        height: 25.0,
                        showOnOff: true,
                        activeColor: Colors.blueAccent,
                        inactiveTextColor: Colors.white,
                        value: vib_onoff,
                        onToggle: (val){
                          setState(() {
                            vib_onoff = val;
                          });
                        }
                    ),
                    SizedBox(width: 30.0,)
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }


}