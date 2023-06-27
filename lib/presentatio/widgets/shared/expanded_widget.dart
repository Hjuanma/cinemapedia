import 'package:flutter/material.dart';

class ExpandedWidget extends StatefulWidget {
  final String text;
  final int maxLength;
  const ExpandedWidget({super.key, required this.text, this.maxLength = 315});

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  bool expanded = false;
  late String subString;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > widget.maxLength) {
      subString = widget.text.substring(0, widget.maxLength);
    } else {
      subString = widget.text;
      expanded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          expanded ? Text(widget.text) : Text(subString, maxLines: 8, overflow:TextOverflow.ellipsis ,),
          const SizedBox(height: 5,),
          widget.text.length > widget.maxLength ? InkWell(
            onTap: () {setState(() {
              expanded = !expanded;
            });},
            child: Row(
              children: [
                Text(expanded ? "Mostrar menos" : "Mostrar mas", style: const TextStyle(color: Colors.black38),),
                Icon(expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down , color: Colors.black38,)
              ],
            ),
          )
          : const SizedBox()
    ]);
  }
}
