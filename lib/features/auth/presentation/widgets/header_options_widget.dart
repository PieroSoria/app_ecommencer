import 'package:flutter/material.dart';

class HeaderOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const HeaderOption({super.key, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.8,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 157, 10, 0),
            Color.fromARGB(255, 11, 0, 46),
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: IconButton(
              onPressed: onTap,
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
