import 'package:flutter/material.dart';

class HomeEditSubSubItemWidget extends StatefulWidget {
  const HomeEditSubSubItemWidget({
    super.key,
  });

  @override
  State<HomeEditSubSubItemWidget> createState() => _HomeEditSubSubItemWidgetState();
}

class _HomeEditSubSubItemWidgetState extends State<HomeEditSubSubItemWidget> {
  int item = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(children: [
          const Expanded(
            child: Text(
              'Plastic/Folding Chair',
            ),
          ),
          //
          SizedBox(
            width: 105,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (item <= 1) return;
                    item--;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: const Color(0xff09596F),
                    ),
                    width: 30,
                    height: 30,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "${item}",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    item++;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: const Color(0xff09596F),
                    ),
                    width: 30,
                    height: 30,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
