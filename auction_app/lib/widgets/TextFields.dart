import 'package:flutter/material.dart';
class PasswordTextField extends StatefulWidget {
  Function callback;
  PasswordTextField( this.callback);
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextField(

      obscureText: _showPassword,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.security),
          suffixIcon: IconButton(
            icon: Icon(
                Icons.remove_red_eye,
                color: _showPassword ? Colors.blue : Colors.red
            ),
            onPressed: (){
              setState(() {
                this._showPassword = !_showPassword;
              });
            },
          ),
      ),
      onChanged: widget.callback,
    );
  }
}

class EmailTextField extends StatelessWidget {
  final Function callback;
  EmailTextField(this.callback);
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          icon: Icon(Icons.email),
          labelText: 'Enter Email',
          errorText: 'Invalid Email',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          )
      ),
      onChanged: callback
    );
  }
}
