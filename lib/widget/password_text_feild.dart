import 'package:flutter/material.dart';
import 'package:task/widget/responsive_ui.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String textHint;

  const PasswordFormField({Key key, @required this.controller, this.textHint})
      : assert(controller != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _showPassword = false;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: TextFormField(
        controller: widget.controller,
        style: Theme.of(context).textTheme.bodyText1,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          //labelText: 'Password',
          hintText: widget.textHint,

          hintStyle: Theme.of(context).textTheme.bodyText1,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),

          prefixIcon: Icon(
            Icons.vpn_key,
            color: Theme.of(context).primaryColor,
          ),

          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
            child: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        obscureText: !_showPassword,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please enter your password';
          }
        },
      ),
    );
  }
}
