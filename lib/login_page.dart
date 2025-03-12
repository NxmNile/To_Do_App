import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<StatefulWidget> createState(){
    return _LoginPageState();
  }
}
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings){
        return MaterialPageRoute(
            builder: (context)=>Scaffold(
              body: Center(child: Padding(padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png'),
                      const SizedBox(height: 50,),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(labelText: 'Username'),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        )
                      ),
                  SizedBox(
                    width: 250,
                    child:  TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter your password';
                        }
                        return null;

                      },
                    ),
                  ),
                  const SizedBox(height: 50,),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){}
                  }, child: const Text('Login', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9C6CFE),),)
                ]),),),
              ))

        );
      },
    );
  }
}