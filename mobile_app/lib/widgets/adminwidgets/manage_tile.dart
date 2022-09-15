import 'package:flutter/material.dart';

class ManageTile extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color color;
  final Icon icon;
  final Color tileColor;
  final Widget screen;

  const ManageTile({Key? key, required this.title, required this.style, required this.color, required this.icon, required this.tileColor, required this.screen,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
            leading: icon,
            title: Text(title, style: style,),
            tileColor: Colors.white,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen,)),
          );
  }
}

