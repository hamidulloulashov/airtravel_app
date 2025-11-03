import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final VoidCallback onClear;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Container(
        color: Theme.of(context).appBarTheme.backgroundColor,
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: widget.controller,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(11.0),
              child: SvgPicture.asset(
                    "assets/icons/search.svg"),
            ),
            suffixIcon: widget.controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                    ),
                    onPressed: () {
                      widget.controller.clear();
                      setState(() {});
                      widget.onClear();
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: isDark 
                ? Colors.grey[800] 
                : Colors.grey[100],
          ),
          onChanged: (value) {
            setState(() {});
          },
          onSubmitted: widget.onSearch,
        ),
      ),
    );
  }
}