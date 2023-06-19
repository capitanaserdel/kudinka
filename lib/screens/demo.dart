//
// import 'package:flutter/material.dart';
// import 'package:kasuwa/provider/product.dart';
// import 'package:provider/provider.dart';
//
// import '../provider/products_pro.dart';
//
// class EditProductScreen extends StatefulWidget {
//   static const routeName = '/edit-product';
//   @override
//   State<EditProductScreen> createState() => _EditProductScreenState();
// }
//
// class _EditProductScreenState extends State<EditProductScreen> {
//   final _priceFocusNode = FocusNode();
//   final _descriptionFocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _imageUrlFocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   var _editedProduct =
//   Product(id: '', title: '', description: '', price: 0, imageUrl: '');
//   var _initValue = {
//     'title': '',
//     'description': '',
//     'price': '',
//     'imageUrl': ''
//   };
//   var _isInit = false;
//
//   @override
//   void iniState() {
//     _imageUrlFocusNode.addListener(_updateImageUrl);
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final productId = ModalRoute.of(context)?.settings.arguments as String;
//       if (productId != null) {
//         _editedProduct = Provider.of<ProductsP>(context).findById(productId);
//         _initValue = {
//           'title': _editedProduct.title,
//           'description': _editedProduct.description,
//           'price': _editedProduct.price.toString(),
//           // 'imageUrl': _editedProduct.imageUrl,
//           'imageUrl': '',
//         };
//         _imageUrlController.text = _editedProduct.imageUrl;
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
//
//   @override
//   void dispose() {
//     _imageUrlFocusNode.removeListener(_updateImageUrl);
//     _priceFocusNode.dispose();
//     _descriptionFocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();
//     super.dispose();
//   }
//
//   void _updateImageUrl() {
//     if (!_imageUrlFocusNode.hasFocus) {
//       if (_imageUrlController.text.isEmpty ||
//           (!_imageUrlController.text.startsWith('http') &&
//               !_imageUrlController.text.startsWith('https')) ||
//           (!_imageUrlController.text.endsWith('.png') &&
//               !_imageUrlController.text.endsWith('.jpg') &&
//               !_imageUrlController.text.endsWith('.jpeg'))) {
//         return;
//       }
//       setState(() {});
//     }
//   }
//
//   void _saveForm() {
//     _form.currentState?.validate();
//     _form.currentState?.save();
//     Provider.of<ProductsP>(context, listen: false).addProduct(_editedProduct);
//     Navigator.of(context).pop();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Product'),
//         actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//             key: _form,
//             child: ListView(
//               children: [
//                 TextFormField(
//                   initialValue: _initValue['title'],
//                   decoration: InputDecoration(
//                     labelText: 'Title',
//                   ),
//                   textInputAction: TextInputAction.next,
//                   onFieldSubmitted: (_) {
//                     FocusScope.of(context).requestFocus(_priceFocusNode);
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please provide a value';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         title: value!,
//                         price: _editedProduct.price,
//                         description: _editedProduct.description,
//                         imageUrl: _editedProduct.imageUrl,
//                         id: '');
//                   },
//                 ),
//                 TextFormField(
//                   initialValue: _initValue['price'],
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   focusNode: _priceFocusNode,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please provide a price';
//                     }
//                     if (double.tryParse(value) == null) {
//                       return 'Please enter a valid number';
//                     }
//                     if (double.parse(value) <= 0) {
//                       return 'Please enter a number greater than zero';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         title: _editedProduct.title,
//                         price: double.parse(value!),
//                         description: _editedProduct.description,
//                         imageUrl: _editedProduct.imageUrl,
//                         id: '');
//                   },
//                 ),
//                 TextFormField(
//                   initialValue: _initValue['description'],
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                   ),
//                   maxLines: 3,
//                   keyboardType: TextInputType.multiline,
//                   focusNode: _descriptionFocusNode,
//                   onFieldSubmitted: (_) {
//                     FocusScope.of(context).requestFocus(_descriptionFocusNode);
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a description';
//                     }
//                     if (value.length < 10) {
//                       return 'Should be at least 10 characters';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         title: _editedProduct.title,
//                         price: _editedProduct.price,
//                         description: value!,
//                         imageUrl: _editedProduct.imageUrl,
//                         id: '');
//                   },
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       margin: EdgeInsets.only(top: 8, right: 10),
//                       decoration: BoxDecoration(
//                           border: Border.all(width: 1, color: Colors.grey)),
//                       child: _imageUrlController.text.isEmpty
//                           ? Text('Enter a URl')
//                           : FittedBox(
//                         child: Image.network(_imageUrlController.text),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Imagr URL',
//                         ),
//                         keyboardType: TextInputType.url,
//                         textInputAction: TextInputAction.done,
//                         controller: _imageUrlController,
//                         focusNode: _imageUrlFocusNode,
//                         onFieldSubmitted: (_) => _saveForm(),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter an image URL';
//                           }
//                           if (!value.startsWith('http') &&
//                               !value.startsWith('https')) {
//                             return 'Please enter a valid URL';
//                           }
//                           if (!value.endsWith('.png') &&
//                               !value.endsWith('.jpg') &&
//                               !value.endsWith('.jpeg')) {
//                             return 'Please enter a valid image URL';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _editedProduct = Product(
//                               title: _editedProduct.title,
//                               price: _editedProduct.price,
//                               description: _editedProduct.description,
//                               imageUrl: value!,
//                               id: '');
//                         },
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../provider/product.dart';
// import '../provider/products_pro.dart';
// class EditProductScreen extends StatefulWidget {
//   static const routeName = '/edit-product';
//
//   @override
//   _EditProductScreenState createState() => _EditProductScreenState();
// }
// class _EditProductScreenState extends State<EditProductScreen> {
//   final _priceFocusNode = FocusNode();
//   final _descriptionFocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _imageUrlFocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   var _editedProduct = Product(
//     id: '',
//     title: '',
//     price: 0,
//     description: '',
//     imageUrl: '',
//   );
//   var _initValues = {
//     'title': '',
//     'description': '',
//     'price': '',
//     'imageUrl': '',
//   };
//   var _isInit = true;
//
//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(_updateImageUrl);
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final productId = ModalRoute.of(context)!.settings.arguments as String?;
//       if (productId != null) {
//         _editedProduct =
//             Provider.of<ProductsP>(context, listen: false).findById(productId);
//         _initValues = {
//           'title': _editedProduct.title,
//           'description': _editedProduct.description,
//           'price': _editedProduct.price.toString(),
//           // 'imageUrl': _editedProduct.imageUrl,
//           'imageUrl': '',
//         };
//         _imageUrlController.text = _editedProduct.imageUrl;
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
//
//   @override
//   void dispose() {
//     _imageUrlFocusNode.removeListener(_updateImageUrl);
//     _priceFocusNode.dispose();
//     _descriptionFocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();
//     super.dispose();
//   }
//
//   void _updateImageUrl() {
//     if (!_imageUrlFocusNode.hasFocus) {
//       if ((!_imageUrlController.text.startsWith('http') &&
//           !_imageUrlController.text.startsWith('https')) ||
//           (!_imageUrlController.text.endsWith('.png') &&
//               !_imageUrlController.text.endsWith('.jpg') &&
//               !_imageUrlController.text.endsWith('.jpeg'))) {
//         return;
//       }
//       setState(() {});
//     }
//   }
//
//   void _saveForm() {
//     final isValid = _form.currentState?.validate();
//     if (!isValid!) {
//       return;
//     }
//     _form.currentState?.save();
//     if (_editedProduct.id != null) {
//       Provider.of<ProductsP>(context, listen: false)
//           .updateProduct(_editedProduct.id, _editedProduct);
//     } else {
//       Provider.of<ProductsP>(context, listen: false).addProduct(_editedProduct);
//     }
//     Navigator.of(context).pop();
//   }
//
//
//   void _saveForm() {
//     _form.currentState?.validate();
//     _form.currentState?.save();
//        if (_editedProduct.id != null) {
//          Provider.of<ProductsP>(context, listen: false)
//              .updateProduct(_editedProduct.id, _editedProduct);
//        } else {
//         Provider.of<ProductsP>(context, listen: false).addProduct(_editedProduct);
//        }
//     Navigator.of(context).pop();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Product'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _saveForm,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _form,
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 initialValue: _initValues['title'],
//                 decoration: InputDecoration(labelText: 'Title'),
//                 textInputAction: TextInputAction.next,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_priceFocusNode);
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please provide a value.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _editedProduct = Product(
//                       title: value!,
//                       price: _editedProduct.price,
//                       description: _editedProduct.description,
//                       imageUrl: _editedProduct.imageUrl,
//                       id: _editedProduct.id,
//                       isFavorite: _editedProduct.isFavorite);
//                 },
//               ),
//               TextFormField(
//                 initialValue: _initValues['price'],
//                 decoration: InputDecoration(labelText: 'Price'),
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.number,
//                 focusNode: _priceFocusNode,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_descriptionFocusNode);
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a price.';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number.';
//                   }
//                   if (double.parse(value) <= 0) {
//                     return 'Please enter a number greater than zero.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _editedProduct = Product(
//                       title: _editedProduct.title,
//                       price: double.parse(value!),
//                       description: _editedProduct.description,
//                       imageUrl: _editedProduct.imageUrl,
//                       id: _editedProduct.id,
//                       isFavorite: _editedProduct.isFavorite);
//                 },
//               ),
//               TextFormField(
//                 initialValue: _initValues['description'],
//                 decoration: InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//                 keyboardType: TextInputType.multiline,
//                 focusNode: _descriptionFocusNode,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a description.';
//                   }
//                   if (value.length < 10) {
//                     return 'Should be at least 10 characters long.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _editedProduct = Product(
//                     title: _editedProduct.title,
//                     price: _editedProduct.price,
//                     description: value!,
//                     imageUrl: _editedProduct.imageUrl,
//                     id: _editedProduct.id,
//                     isFavorite: _editedProduct.isFavorite,
//                   );
//                 },
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   Container(
//                     width: 100,
//                     height: 100,
//                     margin: EdgeInsets.only(
//                       top: 8,
//                       right: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 1,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     child: _imageUrlController.text.isEmpty
//                         ? Text('Enter a URL')
//                         : FittedBox(
//                       child: Image.network(
//                         _imageUrlController.text,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(labelText: 'Image URL'),
//                       keyboardType: TextInputType.url,
//                       textInputAction: TextInputAction.done,
//                       controller: _imageUrlController,
//                       focusNode: _imageUrlFocusNode,
//                       onFieldSubmitted: (_) {
//                         _saveForm();
//                       },
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter an image URL.';
//                         }
//                         if (!value.startsWith('http') &&
//                             !value.startsWith('https')) {
//                           return 'Please enter a valid URL.';
//                         }
//                         if (!value.endsWith('.png') &&
//                             !value.endsWith('.jpg') &&
//                             !value.endsWith('.jpeg')) {
//                           return 'Please enter a valid image URL.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _editedProduct = Product(
//                           title: _editedProduct.title,
//                           price: _editedProduct.price,
//                           description: _editedProduct.description,
//                           imageUrl: value!,
//                           id: _editedProduct.id,
//                           isFavorite: _editedProduct.isFavorite,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//%ANDROID_HOME%\platform_tools
//%USERPROFILE%\.dotnet\tools
//margin: EdgeInsets.only(bottom: 20.0),
//                       padding:
//                           EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
//                       transform: Matrix4.rotationZ(-8 * pi / 180)
//                         ..translate(-10.0),
//                       // ..translate(-10.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.blue,
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 8,
//                             color: Colors.black26,
//                             offset: Offset(0, 2),
//                           )
//                         ],
//                       ),
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';


enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(17, 68, 58, 0).withOpacity(0.5),
                  Color.fromRGBO(17, 68, 58, 0).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Kasuwa',
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Size> _heightAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _heightAnimation = Tween<Size>(
        begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _showErrorDialog(
      String message,
      ) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred'),
          content: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).signin(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authenticate failed. Please try again later';
      if (error.toString().contains('EMAIL_EXIST')) {
        errorMessage = 'This email address is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = '';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not found a user with that email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        // height: _heightAnimation.value.height,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 320 : 260,
        ),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                      maxHeight: _authMode == AuthMode.Signup ? 120 : 0),
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration:
                      InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                      }
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child:
                    Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  ),
                OutlinedButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    (_authMode == AuthMode.Login
                        ? 'SIGNUP INSTEAD'
                        : 'LOGIN INSTEAD'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//     );
//   }
// }
