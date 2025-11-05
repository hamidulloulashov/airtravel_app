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
    
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 10),
              child: TextField(
                cursorColor:  Theme.of(context).textTheme.bodyLarge?.color,
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
                  suffixIcon:Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset("assets/icons/filter.svg",),
                  ),
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
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset("assets/notifaction.png", width: 24,),
          )
        ],
      ),
    );
  }
}