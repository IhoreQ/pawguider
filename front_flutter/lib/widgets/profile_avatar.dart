import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String photoUrl;

  const ProfileAvatar({Key? key, required this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 65),
        child: PhysicalModel(
          color: Colors.black,
          shape: BoxShape.circle,
          elevation: 10.0,
          child: CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
            radius: 65.0,
          ),
        ),
      ),
    );
  }
}
