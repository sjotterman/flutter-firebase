import 'package:flutter/material.dart';

class SmallCustomButton extends StatelessWidget {
  const SmallCustomButton({
    Key key,
    this.color,
    this.textColor,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  final Function onPressed;
  final Widget child;
  final color;
  final textColor;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? Colors.blue;
    final actualTextColor = textColor ?? Colors.white;
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      height: 30.0,
      minWidth: 90.0,
      onPressed: onPressed,
      color: buttonColor,
      disabledColor: Colors.grey[500],
      disabledTextColor: Colors.grey[900],
      textColor: actualTextColor,
      child: child,
    );
  }
}
