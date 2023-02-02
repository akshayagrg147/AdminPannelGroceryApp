import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// function to start app building

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  String _textprovider = "";
  final textfield_controller = TextEditingController();

  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  //A function that validate user entered password
  bool validatePassword(String pass){
    String _password = pass.trim();

    if(pass_valid.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
         //   mainAxisAlignment: MainAxisAlignment.center,
           // children: <Widget>[
            child:ListView(
              children: [
                Image.asset(
                  'assets/images/carrot.jpg',
                  height: 75,
                  // width:  150,
                  filterQuality: FilterQuality.high,
                ),

                //space
                const SizedBox(
                  height: 20,
                  width: 10,
                ),

//login
                const SizedBox(
                  height: 20,
                  // width: 200.0,
                  child: Text("",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                    ),),


                  //space
                ),
                const SizedBox(
                  height: 0,
                  width: 10,
                ),

//email validator
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: TextFormField(
                   // controller: textfield_controller,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.all(  Radius.circular(3),)
                        ),
                        labelText: 'email',
                        labelStyle: TextStyle(color: Colors.black, fontSize: 16.0)
                    ),
                    keyboardType: TextInputType.text,
                  //  decoration:buildInputDecoration(Icons.email,"Email"),
                    validator: (value){
                      print(value);
                      if(value!.isEmpty){
                    //    return "Please Enter Email";
                      }else if(!RegExp(r'\S+@\S+\.\S+').hasMatch(value))
                      {
                        return "Please Enter a Valid Email";
                      }
                      return null;
                    },
                  ),
                ),

//password validator
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child:TextFormField(
                    controller: textfield_controller,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.all(  Radius.circular(3),)
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black, fontSize: 16.0)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                      //  return "Please enter password";
                      }else{
                        //call function to check password
                        bool result = validatePassword(value);
                        if(result){
                          // create account event
                          return null;
                        }else{
                          return " Password should contain Capital, small letter & Number & Special";
                        }
                      }
                    },
                ),
                ),

//login button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "otp");
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      backgroundColor: Colors.green),
                  child: const Text(
                    "Log in",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 30,
                  width: 15,
                ),
                Text('$_textprovider')
              ],
            )
        //    ], //<Widget>[]
          ), //Column
        ), //Center
      );
  }
}
