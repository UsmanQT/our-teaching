// search_bar.dart
import 'package:flutter/material.dart';

class SearchBarComponent extends StatefulWidget {
  final Function(String)? onSearchChanged;
  final String? hintText;
  final TextEditingController? controller;

  const SearchBarComponent({
    super.key,
    this.onSearchChanged,
    this.hintText = 'Search...',
    this.controller,
  });

  @override
  _SearchBarComponentState createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      if (widget.onSearchChanged != null) {
        widget.onSearchChanged!(_controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              if (widget.onSearchChanged != null) {
                widget.onSearchChanged!('');
              }
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (text) {
          if (widget.onSearchChanged != null) {
            widget.onSearchChanged!(text);
          }
        },
      ),
    );
  }
}
