import 'package:airtravel_app/features/accaunt/pages/notification_settings_page.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                cursorColor: Theme.of(context).textTheme.bodyLarge?.color,
                controller: widget.controller,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color
                        ?.withOpacity(0.4),
                    fontSize: 16,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "assets/icons/search.svg",
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color
                            ?.withOpacity(0.6) ?? Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: widget.controller.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.color
                                ?.withOpacity(0.6),
                          ),
                          onPressed: () {
                            widget.controller.clear();
                            widget.onClear();
                            setState(() {});
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            "assets/icons/filter.svg",
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.color
                                  ?.withOpacity(0.6) ?? Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                  widget.onSearch(value);
                },
                onSubmitted: widget.onSearch,
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationSettingsPage()),
    );
  },
  borderRadius: BorderRadius.circular(12),
  child: Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[800] : Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Image.asset(
        "assets/notifaction.png",
        width: 24,
        height: 24,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    ),
  ),
)
,
        ],
      ),
    );
  }
}