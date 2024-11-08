import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/main%20page/shop/open_web.dart';
import 'package:chessby/main%20page/shop/teacher_see.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../l10n/app_localization.dart';

class ShopM extends StatefulWidget {
  const ShopM({super.key});

  @override
  State<ShopM> createState() => _ShopMState();
}

class _ShopMState extends State<ShopM> {
  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    bool result = false; // Default action: Don't close
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Exit Confirmation"),
          content: const Text("Do you really want to close the Game?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                result = false; // Stay on the screen
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                result = true; // Allow exiting
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
    return result; // Return the user's choice
  }
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          if(!start){
            return true;
          }else{
            setState(() {
              start=!start;
            });
            return false;
          }},
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          title: Text(start?"$strr":"${AppLocalizations.of(context)!.translate("Chess Shops & Courses")}",style: TextStyle(color: Colors.white),),
        ),
        body:  Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/back.png"),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: fg(w),
        ),
      ),
    );
  }

  Widget fg(double w){
    if(!start){
      return Column(
        children: [
          SizedBox(height: 15,),
          a(w,"${AppLocalizations.of(context)!.translate("Chess Sets")}",0),
          a(w,"${AppLocalizations.of(context)!.translate("Find Local Teacher")}",1),
          a(w,"${AppLocalizations.of(context)!.translate("Online Chess Course")}",2),
          a(w,"${AppLocalizations.of(context)!.translate("Chess Books")}",3),a(w,"${AppLocalizations.of(context)!.translate("Chess for Kids")}",4),a(w,"${AppLocalizations.of(context)!.translate("Chess for Special Needs")}",5),
        ],
      );
    }else if(y==0){
      return Column(
        children: [
          SizedBox(height: 15,),
          b(w,"${AppLocalizations.of(context)!.translate("Lux sets")}","https://www.amazon.in/s?k=premium+chess+set&ref=nb_sb_noss"),
          b(w,"${AppLocalizations.of(context)!.translate("Electronics set")}","https://www.amazon.in/s?k=electronic+chess+set&ref=nb_sb_noss"),
          b(w,"${AppLocalizations.of(context)!.translate("Themend Chess")}","https://www.amazon.in/s?k=themend+chess+set&ref=nb_sb_noss"),
          b(w,"${AppLocalizations.of(context)!.translate("Chess Clocks")}","https://www.amazon.in/s?k=chess+clocks&ref=nb_sb_noss"),
        ],
      );
    }else if(y==1){
      return Column(
        children: [
          SizedBox(height: 15,),
          b(w,"${AppLocalizations.of(context)!.translate("Lessons for Adults")}","U"),
          b(w,"${AppLocalizations.of(context)!.translate("Lessons for Kids")}","U"),
          b(w,"${AppLocalizations.of(context)!.translate("Lessons for Special Needs")}","U"),
        ],
      );
    }else if(y==2){
      return Column(
        children: [
          SizedBox(height: 15,),
          b(w,"${AppLocalizations.of(context)!.translate("Openings")}","https://www.udemy.com/courses/search/?src=ukw&q=chess+opening"),
          b(w,"${AppLocalizations.of(context)!.translate("Endings")}","https://www.udemy.com/courses/search/?src=ukw&q=chess+endings"),
          b(w,"${AppLocalizations.of(context)!.translate("Tactics")}","https://www.udemy.com/courses/search/?src=ukw&q=chess+tactics"),
          b(w,"${AppLocalizations.of(context)!.translate("EStrategy")}","https://www.udemy.com/courses/search/?src=ukw&q=chess+estrategy"),
        ],
      );
    }else if(y==3){
      return Column(
        children: [
          SizedBox(height: 15,),
          b(w,"${AppLocalizations.of(context)!.translate("Openings")}","https://www.udemy.com/courses/search/?src=ukw&q=chess+opening"),
          b(w,"${AppLocalizations.of(context)!.translate("Endings")}","https://www.udemy.com/courses/search/?src=ukw&q=chess+endings"),
          b(w,"${AppLocalizations.of(context)!.translate("Tactics")}","https://www.udemy.com/courses/search/?src=ukw&q=chess+tactics"),
          b(w,"${AppLocalizations.of(context)!.translate("EStrategy")}","https://www.udemy.com/courses/search/?src=ukw&q=chess+estrategy"),
        ],
      );
    }else if(y==4){
      return Column(
        children: [
          SizedBox(height: 15,),
          b(w,"${AppLocalizations.of(context)!.translate("Books Sets")}","https://www.amazon.in/s?k=chess+books&ref=nb_sb_noss"),
          b(w,"${AppLocalizations.of(context)!.translate("Chess Sets")}","https://www.amazon.in/s?k=chess+sets&ref=nb_sb_noss"),
          b(w,"${AppLocalizations.of(context)!.translate("Courses")}","https://www.udemy.com/courses/search/?src=ukw&q=chess"),
          b(w,"${AppLocalizations.of(context)!.translate("Chess Apparel for Kids")}","https://www.amazon.in/s?k=chess+for+kids&ref=nb_sb_noss"),
          b(w,"${AppLocalizations.of(context)!.translate("Lessons for Kids")}","U"),
        ],
      );
    }else {
      return Column(
        children: [
          SizedBox(height: 15,),
          b(w,"${AppLocalizations.of(context)!.translate("Books Sets")}","https://www.amazon.in/s?k=chess+books&ref=nb_sb_noss"),
          b(w,"${AppLocalizations.of(context)!.translate("Chess Sets")}","https://www.amazon.in/s?k=chess+sets&ref=nb_sb_noss"),
          b(w,"${AppLocalizations.of(context)!.translate("Courses")}","https://www.udemy.com/courses/search/?src=ukw&q=chess"),
          b(w,"${AppLocalizations.of(context)!.translate("Club & Teachers")}","U"),
          b(w,"${AppLocalizations.of(context)!.translate("Lessons for Special Needs")}","U"),
        ],
      );
    }
  }
  Widget b(double w,String str,String op){
    return InkWell(
      onTap: (){
        if(op=="U"){
          Navigator.push(
              context,
              PageTransition(
                  child: New_TeacherHome(tofind: str,
                  ),
                  type: PageTransitionType.topToBottom,
                  duration: Duration(milliseconds: 80)));
        }else{
          Navigator.push(
              context,
              PageTransition(
                  child: Open(str: op, s3: str,),
                  type: PageTransitionType.topToBottom,
                  duration: Duration(milliseconds: 80)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: w-25,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15.0,top: 8,bottom: 8),
            child: Row(
              children: [
                Text(str,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
                Spacer(),
                Icon(Icons.arrow_forward_outlined,color: Colors.black,size: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool start=false;
String strr="";
int y=0;
Widget a(double w,String str,int op){
    return InkWell(
      onTap: (){
        setState(() {
          start=true;
          y=op;
          strr=str;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: w-25,
          height: 60,
         decoration: BoxDecoration(
           color: Colors.greenAccent,
           borderRadius: BorderRadius.circular(10)
         ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15.0,top: 8,bottom: 8),
            child: Row(
              children: [
                Text(str,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
                Spacer(),
                Icon(Icons.arrow_forward_outlined,color: Colors.black,size: 30,)
              ],
            ),
          ),
        ),
      ),
    );
}
}
