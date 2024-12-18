import 'package:flutter/material.dart';
import 'package:grocery_app/Database.dart';
import 'package:grocery_app/Screens//login.dart';

//Define the sign-up screen as a StatefulWidget
class sign_up extends StatefulWidget {
  sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  UserDb userdb=UserDb();

  // Controllers to manage the input fields

  final username_value = TextEditingController();

  final password_value = TextEditingController();

  final confirm_password_value = TextEditingController();

  final email_value = TextEditingController();

  final phone_value = TextEditingController();

  final address_value = TextEditingController();

  final _fromkey = GlobalKey<FormState>();

  // Flag for password visibility toggle
  bool _isSecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        // Allows scrolling
        child: SingleChildScrollView(
            child: Column(
          children: [
            //const SizedBox(height: 0,),
            const Icon(
              Icons.login,
              size: 100,
            ),
            const Text(
              "Register",
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
              "create your account",
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
             child: Column(
               children: [
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
                                  validator:((username) => username!.isEmpty || username.length < 3 ? 'Name should be at least 3 characters and less than 10':null) ,
                                  
                                 
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
                            validator:((value) => value!.length < 3 ? 'password should be at least 3 characters':null) ,
                  )),
                  const SizedBox(
              height: 19,
            ),
            
             // Confirm password input field with visibility toggle
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  obscureText: _isSecurePassword,
                  controller: confirm_password_value,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      prefixIcon: const Icon(Icons.password_outlined),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      fillColor: const Color.fromARGB(255, 224, 231, 224),
                      filled: true,
                      hintText: "Confirm Passwoed",
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
              height: 19,
            ),
            // Email input field
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  obscureText: false,
                  controller: email_value,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      prefixIcon: Icon(Icons.email_outlined),
                      suffixText: "@domain.com",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      fillColor: Color.fromARGB(255, 224, 231, 224),
                      filled: true,
                      hintText: "Email",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 155, 158, 156))),
                          validator: ((value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Email must contain "@" and "."';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null; // Input is valid
                          })
                 ,
                )),
            const SizedBox(
              height: 19,
            ),
            // Phone input field
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  obscureText: false,
                  controller: phone_value,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      prefixIcon: Icon(Icons.phone_android_outlined),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      fillColor: Color.fromARGB(255, 224, 231, 224),
                      filled: true,
                      hintText: "Phone",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 155, 158, 156))),
                          keyboardType: TextInputType.phone,
                          validator: ((value){
                              if(value!.isEmpty || value.length != 11) return "phone should be equal 11";
                              return null;
                          }),
                )),
            const SizedBox(
              height: 19,
            ),
            // Address input field
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  obscureText: false,
                  controller: address_value,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      prefixIcon: Icon(Icons.home_outlined),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      fillColor: Color.fromARGB(255, 224, 231, 224),
                      filled: true,
                      hintText: "Address",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 155, 158, 156))),
                          keyboardType: TextInputType.text,
                          validator: ((value){
                              if((value!.isEmpty) || value.length < 3) {return "Address should be at least 3 characters";}
                           return null;
                          }),
                )),

            const SizedBox(
              height: 50,
            ),
            
               ],
             ),
              
           ),
            
            
            // Sign Up button
            ElevatedButton(
                onPressed: () async{

                  if( _fromkey.currentState!.validate()) {

                    /**********************************HERE***********************************************/
                    int response = await userdb.insertUser(
                        username_value.text, password_value.text,
                        phone_value.text, email_value.text,
                        address_value.text);
                    print("Inserted with response: $response");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login()));
                  }
                  else{

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
                  //minimumSize: const Size.fromHeight(50),
                ),
                child: const Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Center(
                        child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "gilroy",
                          fontSize: 24),
                    ))
                  ],
                )),
            const SizedBox(
              height: 25,
            ),
            // Link to login screen for users who already have an account
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account?",
                  style: TextStyle(
                    fontFamily: "gilroy",
                  )),
              const SizedBox(
                width: 0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => login()));
                  },
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,

                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontFamily: "gilroy",
                    ),
                    padding: const EdgeInsets.all(10),
                    //minimumSize: const Size.fromHeight(50),
                  ),
                  child: const 
                      Center(
                          child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(71, 152, 100, 1),
                            fontFamily: "gilroy"),
                      ))
                    ,
                  )
            ]),
          ],
        )),
      )),
    );
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
