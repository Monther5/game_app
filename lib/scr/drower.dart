import 'package:flutter/material.dart';
import 'package:move_app/provider/lang_provider.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.text,
      required this.onTab,
       this.icon,
      this.withDivider = true});
  final String text;
  final Function onTab;
  final IconData ?icon;
  final bool withDivider;
  @override
  Widget build(BuildContext context) {
    return Consumer<darkmodeprovider>(builder: (context, darkModeConsumer, _) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
             
              onTab();
             
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: darkModeConsumer.isdark
                      ? Colors.grey
                      : Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(icon,
                        color: darkModeConsumer.isdark
                            ? Colors.red
                            : Colors.blue),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          color: darkModeConsumer.isdark
                              ? Colors.red
                              : Colors.blue),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (withDivider)
            const Divider(
              thickness: 1,
              endIndent: 5,
              indent: 5,
            ),
        ],
      );
    });
  }
}