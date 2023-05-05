import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogul/constants.dart';
import 'package:mogul/handlers/providers.dart';
import 'package:mogul/home.dart';
import 'package:provider/provider.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {


  final myController = TextEditingController();

  @override
  void dispose() {
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  TextStyle hintText = GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.grey,
    fontWeight: FontWeight.w600
  );
  TextStyle textStyle = GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.grey[900],
      fontWeight: FontWeight.w600
  );


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:  Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                style: textStyle,
                controller: myController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: mainBlue
                      ),
                    ),
                    hintText: 'Email',
                    hintStyle: hintText,
                    isDense: true
                ),
              ),
              SizedBox(height: height*0.01,),
              TextField(
                style: textStyle,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          width: 1.5,
                          color: mainBlue
                      ),
                    ),
                    hintText: 'Password',
                    hintStyle: hintText,
                    isDense: true
                ),
                obscureText: true,
              ),

              SizedBox(height: height*0.05,),

              InkWell(
                onTap: (){
                  if(myController.text.isNotEmpty){
                    context.read<ProviderHandler>().changeName(myController.text);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Fill all fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: mainBlue,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 12
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 120,
              ),
              Text(
                'New User? Create Account',
                style: GoogleFonts.poppins(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 12
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

