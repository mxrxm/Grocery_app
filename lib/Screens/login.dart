import 'package:flutter/material.dart';
import 'package:grocery_app/Screens/explore_screen.dart';
import 'package:grocery_app/Screens//sign_up.dart';
import 'package:grocery_app/Database.dart';


//Login screen widget
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  UserDb userdb=UserDb();

  // Controllers for text fields to manage input

  final username_value = TextEditingController();

  final password_value = TextEditingController();

  final _fromkey = GlobalKey<FormState>();

  bool _isSecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            //const SizedBox(height: 0,),
            const Icon(
              Icons.lock_outline,
              size: 100,
            ),
            const Text(
              "Welcome back",
              style: TextStyle(
                  fontFamily: "gilroy",
                  fontSize: 48,
                  color: Color.fromRGBO(71, 152, 100, 1),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "please enter your details",
              style: TextStyle(
                  fontFamily: "gilroy",
                  fontSize: 20,
                  color: Color.fromRGBO(187, 223, 199, 1),
                  fontWeight: FontWeight.w100),
            ),
            const SizedBox(
              height: 19,
            ),
            // Username input field
            Form(

              key: _fromkey,
              child:Column(
              children:[ 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: username_value,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        fillColor: Color.fromARGB(255, 224, 231, 224),
                        filled: true,
                        hintText: "Username",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 155, 158, 156))),
                            validator:((username) => username!.length < 3 ? 'Name should be found':null) ,
                  )),
                  const SizedBox(
                    height: 19,
                  ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    obscureText: _isSecurePassword,
                    controller: password_value,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        prefixIcon: const Icon(Icons.password),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        fillColor: const Color.fromARGB(255, 224, 231, 224),
                        filled: true,
                        hintText: "Password",
                        suffixIcon: togglepassword(),
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 155, 158, 156))),
                            validator: ((value){
                              if(value! != password_value.text) return "passsword should be matched";
                              if(value.isEmpty) return "password should be at least 3 characters";
                              return null;
                          }),
                  )),
                   const SizedBox(
              height: 0,
            ),
            // Forgot password link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    child: const Text("Forgot password?",
                        style: TextStyle(
                            fontFamily: "gilroy",
                            fontSize: 18,
                            color: Color.fromRGBO(53, 170, 82, 1),
                            fontWeight: FontWeight.w100)),
                  ),
                ],
              ),
            ),
              ]
              )    
            ),
            
            
           

            const SizedBox(
              height: 5,
            ),
            // Login button
            ElevatedButton(
                onPressed: () async{
                   Map m=  await userdb.validateData (username_value.text, password_value.text);

                if(!m['state']){
                  showDialog(context: context, builder:(context){
                    return AlertDialog(
                      title: const Text("ERROR"),
                      content:   Text( m['message']),
                      actions: [
                        TextButton(onPressed:() {
                          Navigator.of(context).pop();
                        } , child: const Text("OK")),
                        
                      ],
                    );
                  }
                  );
                }
                else{

                
                

                  /**********************************HERE***********************************************
                 
                 username_value 
                 password_value */
                /*
                  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ExploreScreen()));
                 */
                Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ExploreScreen(username: username_value.text),
  ),
);


                 
                 
                }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 53),
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(71, 152, 100, 1),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: "gilroy",
                  ),

                  padding: const EdgeInsets.symmetric(vertical: 24),
                ),
                child: const
                    Center(
                        child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "gilroy",
                          fontSize: 24),
                    ))
                  ,
                ),
            const SizedBox(
              height: 50,
            ),
            // Divider with text "or continue with"
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: Divider(
                    thickness: 0.3,
                    color: Colors.black,
                  )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                          child: Text(
                        "or continue with",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(53, 170, 82, 1),
                            fontFamily: "gilroy",
                            fontSize: 16),
                      ))),
                  Expanded(
                      child: Divider(
                    thickness: 0.3,
                    color: Colors.black,
                  )),
                ])),
            const SizedBox(
              height: 40,
            ),
            // Social media login icons (Google & Facebook)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "images/google.png",
                height: 50,
              ),
              const SizedBox(
                width: 35,
              ),
              Image.asset(
                "images/facebook.png",
                height: 50,
              ),
            ]),
            const SizedBox(
              height: 25,
            ),
            // Option to navigate to the sign-up page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text("Not a member?",
                  style: TextStyle(
                    fontFamily: "gilroy",
                  )),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => sign_up()));
                  },
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontFamily: "gilroy",
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Center(
                          child: Text(
                        "Register Now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(71, 152, 100, 1),
                            fontFamily: "gilroy"),
                      ))
                    ],
                  ))
            ]),
          ]),
        ),
      ),
    ));
  }


  // Function to toggle password visibility
  Widget togglepassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            _isSecurePassword = !_isSecurePassword;
          });
        },
        icon: _isSecurePassword
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off));
  }
}
