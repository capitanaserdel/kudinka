// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/auth.dart';
//
// enum AuthMode { Signup, Login }
//
// class AuthScreen extends StatelessWidget {
//   static const routeName = '/auth';
//
//   double getSmall(BuildContext context) =>
//       MediaQuery.of(context).size.width * 2 / 3;
//   double getBig(BuildContext context) =>
//       MediaQuery.of(context).size.width * 7 / 8;
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
//     // transformConfig.translate(-10.0);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: <Widget>[
//           Positioned(
//               right: -getSmall(context) / 3,
//               top: -getSmall(context) / 3,
//               child: Container(
//                 width: getSmall(context),
//                 height: getSmall(context),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                         colors: [
//                           Color(0xFF00BCD4),
//                           Color(0xFF18FFFF),
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter)),
//               )),
//           Positioned(
//               left: -getBig(context) / 4,
//               top: -getBig(context) / 4,
//               child: Container(
//                 width: getBig(context),
//                 height: getBig(context),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(colors: [
//                     Color(0xFF00ACC1),
//                     Color(0xFF00E5FF),
//                   ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Kasuw',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 50,
//                       fontFamily: 'Anton',
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               )),
//           Positioned(
//               right: -getBig(context) / 2,
//               bottom: -getBig(context) / 2,
//               child: Container(
//                 width: getBig(context),
//                 height: getBig(context),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                         colors: [
//                           Color(0xFFB2EBF2),
//                           Color(0xFFB2EBF2),
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter)),
//               )),
//           SingleChildScrollView(
//             child: Container(
//               height: deviceSize.height,
//               width: deviceSize.width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(
//                     height: h * 0.3,
//                   ),
//                   Flexible(
//                     flex: deviceSize.width > 600 ? 2 : 1,
//                     child: AuthCard(),
//                   ),
//                   Flexible(
//                     child: Container(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                               onTap:(){},
//                               child: Container(
//                                 // decoration: BoxDecoration(
//                                 //   // borderRadius: BorderRadius.circular(100),
//                                 //   color: Colors.cyan,),
//                                 child: Image(
//                                   height: h * 0.04, fit: BoxFit.cover,
//                                   image:  AssetImage('assets/images/facebook.png'),
//                                 ),
//                               )
//                           ),
//                           SizedBox(width: w * 0.04,),
//                           GestureDetector(
//                               child: Image(
//                                 height: h * 0.04, fit: BoxFit.cover,
//                                 image:  AssetImage('assets/images/g.png'),
//                               )
//                           ),
//                           SizedBox(width: w * 0.04),
//                           GestureDetector(
//                               child: Image(
//                                 height: h * 0.05, fit: BoxFit.cover,
//                                 image:  AssetImage('assets/images/w.png'),
//                               )
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class AuthCard extends StatefulWidget {
//   @override
//   _AuthCardState createState() => _AuthCardState();
// }
//
// class _AuthCardState extends State<AuthCard>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   AuthMode _authMode = AuthMode.Login;
//   Map<String, String> _authData = {
//     'email': '',
//     'password': '',
//   };
//   var _isLoading = false;
//   final _passwordController = TextEditingController();
//   late AnimationController _controller;
//   late Animation<Size> _heightAnimation;
//   late Animation<double> _opacityAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     _heightAnimation = Tween<Size>(
//         begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
//     _opacityAnimation = Tween(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _controller.dispose();
//   }
//
//   void _showErrorDialog(
//       String message,
//       ) {
//     showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: Text('An error occurred'),
//           content: Text(message),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop();
//                 },
//                 child: Text('Okay'))
//           ],
//         ));
//   }
//
//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) {
//       // Invalid!
//       return;
//     }
//     _formKey.currentState!.save();
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       if (_authMode == AuthMode.Login) {
//         // Log user in
//         await Provider.of<Auth>(context, listen: false).signin(
//           _authData['email']!,
//           _authData['password']!,
//         );
//       } else {
//         // Sign user up
//         await Provider.of<Auth>(context, listen: false).signup(
//           _authData['email']!,
//           _authData['password']!,
//         );
//       }
//     } on HttpException catch (error) {
//       var errorMessage = 'Authenticate failed. Please try again later';
//       if (error.toString().contains('EMAIL_EXIST ')) {
//         errorMessage = 'This email address is already in use';
//       } else if (error.toString().contains('INVALID_EMAIL')) {
//         errorMessage = '';
//       } else if (error.toString().contains('WEAK_PASSWORD ')) {
//         errorMessage = 'This password is too weak';
//       } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
//         errorMessage = 'Could not found a user with that email';
//       } else if (error.toString().contains('INVALID_PASSWORD')) {
//         errorMessage = 'Invalid Password';
//       }
//       _showErrorDialog(errorMessage);
//     } catch (error) {
//       const errorMessage = 'Could not authenticate you. Please try again later';
//       _showErrorDialog(errorMessage);
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   void _switchAuthMode() {
//     if (_authMode == AuthMode.Login) {
//       setState(() {
//         _authMode = AuthMode.Signup;
//       });
//       _controller.forward();
//     } else {
//       setState(() {
//         _authMode = AuthMode.Login;
//       });
//       _controller.reverse();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     return Card(
//       elevation: 0,
//       child: AnimatedContainer(
//         height: _authMode == AuthMode.Signup ? 340 : 280,
//         // height: _heightAnimation.value.height,
//         constraints: BoxConstraints(
//           minHeight: _authMode == AuthMode.Signup ? 340 : 280,
//         ),
//         width: deviceSize.width * 0.75,
//         padding: EdgeInsets.all(16.0),
//         curve: Curves.easeIn,
//         duration: Duration(milliseconds: 300),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.fromLTRB(8, 8, 8, 2),
//                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.cyanAccent,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         icon: Icon(
//                           Icons.email,
//                           color: Colors.white,
//                         ),
//                         labelStyle: TextStyle(color: Colors.white),
//                         labelText: 'E-Mail'),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value!.isEmpty || !value.contains('@')) {
//                         return 'Invalid email!';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       _authData['email'] = value!;
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(8, 8, 8, 2),
//                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.cyanAccent,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         icon: Icon(
//                           Icons.vpn_key_rounded,
//                           color: Colors.white,
//                         ),
//                         labelStyle: TextStyle(color: Colors.white),
//                         labelText: 'Password'),
//                     obscureText: true,
//                     controller: _passwordController,
//                     validator: (value) {
//                       if (value!.isEmpty || value.length < 5) {
//                         return 'Password is too short!';
//                       }
//                     },
//                     onSaved: (value) {
//                       _authData['password'] = value!;
//                     },
//                   ),
//                 ),
//                 // Column(
//                 //   mainAxisAlignment: MainAxisAlignment.end,
//                 //   children:
//                 // [
//                 //   Text('Forgot Password')
//                 // ],),
//                 AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   curve: Curves.easeIn,
//                   constraints: BoxConstraints(
//                       minHeight: _authMode == AuthMode.Signup ? 60 : 0,
//                       maxHeight: _authMode == AuthMode.Signup ? 120 : 0),
//                   child: FadeTransition(
//                     opacity: _opacityAnimation,
//                     child: Container(
//                       margin: EdgeInsets.fromLTRB(8, 8, 8, 2),
//                       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                       decoration: BoxDecoration(
//                           color: Colors.cyanAccent,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: TextFormField(
//                         enabled: _authMode == AuthMode.Signup,
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               Icons.vpn_key_rounded,
//                               color: Colors.white,
//                             ),
//                             labelStyle: TextStyle(color: Colors.white),
//                             labelText: 'Confirm Password'),
//                         obscureText: true,
//                         validator: _authMode == AuthMode.Signup
//                             ? (value) {
//                           if (value != _passwordController.text) {
//                             return 'Passwords do not match!';
//                           }
//                         }
//                             : null,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 if (_isLoading)
//                   CircularProgressIndicator()
//                 else
//                   Row(
//                     children: [
//                       OutlinedButton(
//                         onPressed: _switchAuthMode,
//                         child: Text(
//                           (_authMode == AuthMode.Login
//                               ? 'SIGNUP INSTEAD'
//                               : 'LOGIN INSTEAD'),
//                         ),
//                       ),
//                       Spacer(),
//                       CircleAvatar(
//                         backgroundColor: Colors.cyan,
//                         child: GestureDetector(
//                           onTap: _submit,
//                           child: Icon(
//                             _authMode == AuthMode.Login
//                                 ? Icons.arrow_forward
//                                 : Icons.arrow_forward,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       // ElevatedButton(
//                       //   onPressed: _submit,
//                       //   child:
//                       //       Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',style: TextStyle(),),
//                       // ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // import 'package:firebase_core/firebase_core.dart';
// // import 'firebase_options.dart';
// //
// // // ...
// //
// // await Firebase.initializeApp(
// // options: DefaultFirebaseOptions.currentPlatform,
// // );