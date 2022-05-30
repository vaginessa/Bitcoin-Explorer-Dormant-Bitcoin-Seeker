import 'package:flutter/material.dart';

class PreviewCard extends StatelessWidget {
  const PreviewCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.isSelected,
      required this.color})
      : super(key: key);

  final Icon icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isSelected ? 216 : 210,
      height: isSelected ? 146 : 140,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: color,
          border:
              isSelected ? Border.all(color: Colors.white, width: 3) : null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(child: icon),
          const SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }
}
