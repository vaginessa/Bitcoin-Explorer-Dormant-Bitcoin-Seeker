import 'package:flutter/material.dart';

class PreviewCard extends StatelessWidget {
  const PreviewCard({
    Key? key, 
    required this.icon, 
    required this.title, 
    required this.subtitle
  }) : super(key: key);

  final Icon icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.blue
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            child: icon
          ),
          const SizedBox(height: 30,),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),),
          Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 14),)
        ],
      ),
      width: 210,
      height: 140,
    );
  }
}
