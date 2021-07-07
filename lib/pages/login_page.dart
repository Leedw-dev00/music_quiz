import 'package:flutter/material.dart';
import 'package:music_quiz/pages/home_page.dart';
import 'package:kakao_flutter_sdk/all.dart';




class loginPage extends StatefulWidget{
  @override
  _loginPageState createState()=> _loginPageState();
}

class _loginPageState extends State<loginPage>{
  bool _isKakaoTalkInstalled = true;


  @override
  void initState(){
    _initKakaoTalkInstalled();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {

    // KaKao native app key
    KakaoContext.clientId = "8a7b9454428d7228248fda3a61bfc9c1";  //Native Key
    // KaKao javascript key
    KakaoContext.javascriptClientId = "650cec2d5eb43e6d060a37d9d9ed5df9";  //JavaScript Key

    isKakaoTalkInstalled();

    return Scaffold(
      backgroundColor: Color(0xFFFEC768),
      body: Container(
        child: Stack(
          children: <Widget>[
            Image.asset('assets/images/back.png', width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
            Positioned(child: GestureDetector(
              child: Image.asset('assets/images/start.png', fit: BoxFit.fitHeight, height: 110.0,),
              onTap: () => _loginWithKakao(),
            ), bottom: 150.0, left: 100.0, right: 100.0, )
          ],
        )
      ),
    );
  }
}