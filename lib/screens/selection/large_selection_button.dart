import 'package:flutter/material.dart';

class LargeSelectionButton extends StatelessWidget {
  const LargeSelectionButton({
    Key key,
    this.color,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  final Function onPressed;
  final Widget child;
  final color;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? Colors.blue;
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      height: 60.0,
      minWidth: 190.0,
      onPressed: onPressed,
      color: buttonColor,
      disabledColor: Colors.grey[500],
      disabledTextColor: Colors.grey[900],
      textColor: Colors.white,
      child: child,
    );
  }
}
