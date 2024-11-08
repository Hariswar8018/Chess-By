import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: w,height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/back.png"),
              fit: BoxFit.cover,
              opacity: 0.2
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                ),
                Global.text11("  Points & Levels", w),
              ],
            ),  SizedBox(height: 20,),
            Center(
              child: Container(
                color: Global.blac,
                width: w-25,
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.orange.shade400,
                      child: Icon(Icons.subscriptions,color: Colors.yellow,size: 35,),
                    ),
                    SizedBox(height: 4,),
                    Text(_user!.Chess_Level,style: TextStyle(color: Colors.yellow),),
                    SizedBox(height: 4,),
                    Global.text1((_user.Won+_user.lichesorgran+_user.chesscomra).toString(), w),
                    Text("Total Points Earned",style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
            SizedBox(height : 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                f("Played",(_user.Won+_user.Lose+_user.Draw).toString(),context),
                f("Won",_user.Won.toString(),context),
                f("Lose",_user.Lose.toString(),context),
                f("Draw",_user.Draw.toString(),context),
              ],
            ),
            SizedBox(height : 25),
          ],
        ),
      ),
    );
  }
  Widget f(String str, String str2,BuildContext context){
    return Container(
      decoration: BoxDecoration(
          color: Global.blac,
          borderRadius: BorderRadius.circular(15)
      ),
      width: MediaQuery.of(context).size.width/4-9,
      height: MediaQuery.of(context).size.width/4-15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(str,style: TextStyle(fontSize: 17,color: Colors.grey),),
          SizedBox(height: 4,),
          Text(str2,style: TextStyle(fontSize: 21,color: Colors.white),),
        ],
      ),
    );
  }
}
