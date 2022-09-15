import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openEndDrawer(

        );
      },
      child: Container(
        key: const Key('profile'),
        padding: const EdgeInsets.all(8),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.grey.shade600.withOpacity(0.1),
            shape: BoxShape.circle),
        child: SvgPicture.asset(
          "assets/icons/profile.svg",
          color: Colors.grey.shade800,
        ),
      ),
    );
  }
}