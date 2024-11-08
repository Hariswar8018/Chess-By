
import 'package:flutter/material.dart';

class Global {
  static Widget yellow(double w,String str){
    return Container(
      height: 55,
      width: w-30,
      decoration: BoxDecoration(
        color: Color(0xffffda44),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 15,),
          Text(str,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17),),
          Spacer(),
          Icon(Icons.arrow_forward_outlined,color: Colors.black,),
          SizedBox(width: 15,),
        ],
      ),
    );
  }
  static Widget yellowwithout(double w,String str){
    return Container(
      height: 55,
      width: w-30,
      decoration: BoxDecoration(
        color: Color(0xffffda44),
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Center(child: Text(str,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17),)),
    );
  }
  static Widget yellowcustom(double w,double h,Widget r,Color ft,String str){
    return Container(
      height: h,
      width: w-30,
      decoration: BoxDecoration(
        color: ft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 15,),
          Text(str,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17),),
          Spacer(),
          r,
          SizedBox(width: 15,),
        ],
      ),
    );
  }
  static Widget white(double w,String str,Widget w1){
    return Container(
      height: 55,
      width: w - 30,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade300.withOpacity(0.8), // Adjust opacity here
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          w1,
          SizedBox(width: 9),
          Text(
            str,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 17,
              color: Colors.white,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
  static Color blac=Color(0xff202020);
  static Color yell=Colors.yellowAccent;
  static Widget height(double h)=>SizedBox(height: h,);
  static Widget width(double w)=>SizedBox(width: w,);

   /*
    Navigator.push(
        context,
        PageTransition(
            child: First2(),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 80)));
   */
 static Widget d(TextEditingController c, String label, String hint, bool number,bool on) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0,right: 14),
      child:Container(
        decoration: BoxDecoration(
          color: Color(0xff202020),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: c,
            readOnly: on,
            keyboardType: number ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              labelText: "  " + label,
              hintText: hint,
              isDense: true,
              filled: true,
              fillColor: Color(0xff202020), // Set the editor background color to black
              labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Set label color and font size
              hintStyle: TextStyle(color: Colors.white54, fontSize: 16), // Set hint color and font size
              border: InputBorder.none, // Remove the underline
              focusedBorder: InputBorder.none, // Remove the underline when focused
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please type it';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  static text1(String str,double w)=>  Text(str,style: TextStyle(fontSize: w/12,color: Colors.white,fontWeight: FontWeight.w600),);
  static text11(String str,double w)=>  Text(str,style: TextStyle(fontSize: w/14,color: Colors.white,fontWeight: FontWeight.w600),);

  static text2(String str, double w)=>Text(str,style: TextStyle(fontSize: w/25,color: Colors.white,fontWeight: FontWeight.w400),);
/*

  @override
  Widget build(BuildContext context) {
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
             opacity: 0.7
          ),
        ),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
    );
  }

  */
}