import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class Paypal extends StatelessWidget {

  bool b ;
  String clientId;
  String secretkey;
  int amount ;
  String name ;
  Paypal({super.key, required this.name, required this.amount, required this.secretkey, required this.clientId, required this.b});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Pay for Classes to $name"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Image.network("https://interactivespares.com/wp-content/uploads/2018/07/paypal_logo.png"),
          SizedBox(height: 25,),
          Center(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 2.0, // Border width
                  ),
                  color: Color(0xffff79ac),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    // specify the radius for the top-left corner
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    // specify the radius for the top-right corner
                  ),
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PaypalCheckoutView(
                                  sandboxMode: true,
                                  clientId: clientId,
                                  secretKey: secretkey,
                                  transactions:  [
                                    {
                                      "amount": {
                                        "total": amount,
                                        "currency": "USD",
                                        "details": {
                                          "subtotal":  amount,
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },
                                      "description": "The payment for classes booked in ChessBe hosted by $name",
                                      // "payment_options": {
                                      //   "allowed_payment_method":
                                      //       "INSTANT_FUNDING_SOURCE"
                                      // },
                                      "item_list": {
                                        "items": [
                                          {
                                            "name": "ChessBe Lesson",
                                            "quantity": 1,
                                            "price": amount,
                                            "currency": "USD"
                                          },
                                        ],

                                        // Optional
                                        //   "shipping_address": {
                                        //     "recipient_name": "Tharwat samy",
                                        //     "line1": "tharwat",
                                        //     "line2": "",
                                        //     "city": "tharwat",
                                        //     "country_code": "EG",
                                        //     "postal_code": "25025",
                                        //     "phone": "+00000000",
                                        //     "state": "ALex"
                                        //  },
                                      }
                                    }
                                  ],
                                  note: "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Yup ! Paid Successfully. Please check your Email for Receipt. Your Teacher would contact soon'),
                                        duration: Duration(seconds: 10), // Duration for how long the Snackbar will be visible
                                        action: SnackBarAction(
                                          label: 'Close',
                                          onPressed: () {
                                            // Add your action here
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hides the current Snackbar
                                          },
                                        ),
                                      ),
                                    );
                                    log("onSuccess: $params");
                                    Navigator.pop(context);
                                  },
                                  onError: (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Upps ! Error Occured : $error"),
                                        duration: Duration(seconds: 10), // Duration for how long the Snackbar will be visible
                                        action: SnackBarAction(
                                          label: 'Close',
                                          onPressed: () {
                                            // Add your action here
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hides the current Snackbar
                                          },
                                        ),
                                      ),
                                    );
                                    log("onError: $error");
                                    Navigator.pop(context);
                                  },
                                  onCancel: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Upps ! Looks like you Canceled"),
                                        duration: Duration(seconds: 5), // Duration for how long the Snackbar will be visible
                                        action: SnackBarAction(
                                          label: 'Close',
                                          onPressed: () {
                                            // Add your action here
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hides the current Snackbar
                                          },
                                        ),
                                      ),
                                    );
                                    print('cancelled:');
                                    Navigator.pop(context);
                                  },
                                ),
                          ));
                        },
                        icon: Icon(Icons.paypal, size: 24,
                            color: Colors.white),
                        label: Text("PAY NOW ( \$ $amount )",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white))))),
          ),
        ],
      ),
    );
  }
}

