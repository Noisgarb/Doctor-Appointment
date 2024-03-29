import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:sqq_flutter2/components/email_verify.dart';
import 'package:sqq_flutter2/constants.dart';
import 'package:sqq_flutter2/model/Reset_Password.dart';
import 'package:sqq_flutter2/model/admin_home_page.dart';
import 'package:sqq_flutter2/model/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/signup_error.dart';
import '../main.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError) {
          return const Center(child: Text("Error"),);
        }else if(snapshot.hasData){
          return const VerifyEmailPage();
        }else{
          return const AuthPage();
        }
      },
    )
  );
}



class LoginWidget extends StatefulWidget {

  final VoidCallback onClickedSignUp;

  const LoginWidget({Key? key, required this.onClickedSignUp}) : super(key: key);


  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  
  // ignore: prefer_typing_uninitialized_variables
  var passwordVisible;
  late String initText;
  final _paswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _adminCodeController = TextEditingController();

@override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  void dispose() {
    super.dispose();
    _paswordController.dispose();
    _emailController.dispose();
    _adminCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        children:[
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.only(left: 10, right:320),
            child: Container(
            height:44,
            width: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: kGreenColor,
              ),
              child: const Icon(
                Icons.arrow_left_sharp,
                color: kWhiteColor,
                size: 22.0,
                ),

          ),
          ),
          
          const SizedBox(height: 22),
          Row(
              children: [
                Padding(padding: EdgeInsets.only(right:45)),
                Text(
                'Sign in',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.end,
                ),
                ]
          ),
          const SizedBox(height: 25),
          Row(
              children: [
                Padding(padding: EdgeInsets.only(right:45)),
                Text(
                'Welcome back',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: kGreyColor900, fontSize: 15),
                textAlign: TextAlign.end,
                ),
                ]
          ),
          const SizedBox(height: 45),


              Row(
                children: [
                Padding(padding: EdgeInsets.only(left: 60)),
                Container(
                  width: 300,
                  height: 24,
                  child: 
                TextFormField(
                  controller: _emailController,
                  cursorColor: kWhiteColor,
                  textInputAction: TextInputAction.next,
                  //autofocus: true,
                    decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    hintText: 'Email address',
                    prefixIcon: Padding(padding: EdgeInsets.zero, child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: Svg('asset/signup/img-message.svg', size: Size(24,24))),
                    ),)
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                        email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,
                ),
                ),
                const SizedBox(height: 65,),
                
              ],),

              Row(
                children: [
                Padding(padding: EdgeInsets.only(left: 60)),
                Container(
                  width: 300,
                  height: 24,
                  child: 
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _paswordController,
                  obscureText: !passwordVisible,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    //labelText: 'Password', 
                    //border: OutlineInputBorder(),
                    hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off), 
                        color: kGreyColor900,
                        padding: EdgeInsets.only(bottom: 8),
                        //iconSize: 24,
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },),
                      prefixIcon: Padding(padding: EdgeInsets.zero, child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: Svg('asset/signup/img-passwd.svg', size: Size(24,24))),
                      
                    ),)
                  ),
                ),
                autovalidateMode:AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6 ? 'Enter min. 6 characters' : null,
                ),
                ),
                const SizedBox(height: 65,),
                ],),

                Row(
                children: [
                Padding(padding: EdgeInsets.only(left: 60)),
                Container(
                  width: 300,
                  height: 24,
                  child: 
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _adminCodeController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    //labelText: 'Password', 
                    //border: OutlineInputBorder(),
                    hintText: 'admin code, for doctor only',
                      prefixIcon: Padding(padding: EdgeInsets.zero, child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: const DecorationImage(image: Svg('asset/signup/img-account.svg', size: Size(24,24))),
                      
                    ),)
                  ),
                ),
                ),
                ),
                const SizedBox(height: 65,),
                ],),

              Row(
              children: [
                const Padding(padding: EdgeInsets.only(right:120)),
                GestureDetector(
                  child: Text(
                'Forget your password?',
                style: TextStyle(
                decoration: TextDecoration.underline,
                color: kBlackColor800,
                fontSize: 15,
                ),
                textAlign: TextAlign.end,
                ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ForgotPasswordPage())),
                
                 ), ),
              ]
          ),

          const SizedBox(height: 50,),

              Row(children: [
                const Padding(padding: EdgeInsets.only(left: 30)),
                GestureDetector(
                  onTap: () => signIn(),
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                  height: 60,
                  width: 354,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kGreenColor,
                    ),
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 30, color: kWhiteColor),
                      textAlign: TextAlign.center,
                  ),
                ),
                ),
              ],),

              const SizedBox(height: 20,),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(right: 120)),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: kGreyColor800, fontSize: 20),
                      text: 'No account? ',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                          text: 'Sign up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: kGreenColor,
                          )
                        )
                      ]
                    )),
                ],
              )
            ],
          )
        
      ,),);

  }
  void signIn() async {
    //final admin = FirebaseFirestore.instance.collection('DoctorID').doc('doctorID');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>const Center(child: CircularProgressIndicator(),));
  try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text.trim(), 
    password: _paswordController.text.trim()
    );
}
on FirebaseAuthException catch (e) {
  print(e);
  Utils.showSnackBar(e.message);
  // TODO
}

 navigatorKey.currentState!.popUntil((route) => route.isFirst);

}
}
