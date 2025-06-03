import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MultiMenuExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MultiMenuExample extends StatefulWidget {
  const MultiMenuExample({super.key});

  @override
  State<MultiMenuExample> createState() => _MultiMenuExampleState();
}

class _MultiMenuExampleState extends State<MultiMenuExample> {
  final Map<String, LayerLink> _menuLinks = {
    'File': LayerLink(),
    'Edit': LayerLink(),
    'View': LayerLink(),
  };

  OverlayEntry? _activeMenu;
  String? _activeMenuKey;
  Timer? _hideTimer;
  bool _hoverEnabled = false;
  String? _hoveredMenuKey;
  double topMenuVerticalPadding = 5;
  double topMenuTextFontSize = 12;
  double menuItemVerticalPadding = 12;

  void _showMenu(String key, List<String> items) {
    if (_activeMenuKey == key) return;

    _removeMenu();

    final overlay = OverlayEntry(
      builder:
          (context) => Positioned(
            width: 150, // 限制整体宽度
            child: CompositedTransformFollower(
              link: _menuLinks[key]!,
              offset: Offset(
                0,
                topMenuVerticalPadding * 2 +
                    topMenuTextFontSize +
                    menuItemVerticalPadding -
                    5,
              ),
              showWhenUnlinked: false,
              child: MouseRegion(
                onEnter: (_) => _cancelHideMenu(),
                onExit: (_) => _startHideMenu(),
                child: Material(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: items.map(_buildMenuItem).toList(),
                  ),
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(overlay);
    _activeMenu = overlay;
    _activeMenuKey = key;
  }

  void _removeMenu() {
    _hideTimer?.cancel();
    _activeMenu?.remove();
    _activeMenu = null;
    _activeMenuKey = null;
  }

  void _startHideMenu() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 300), _removeMenu);
  }

  void _cancelHideMenu() {
    _hideTimer?.cancel();
  }

  Widget _buildMenuItem(String title) {
    return InkWell(
      onTap: () {
        debugPrint("点击了: $title");
        _removeMenu();
      },
      hoverColor: Colors.blue.withOpacity(0.1),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: menuItemVerticalPadding,
        ),
        child: Text(title),
      ),
    );
  }

  Widget _buildTopMenuButton(String key, List<String> items) {
    bool isHovered = _hoveredMenuKey == key;
    return CompositedTransformTarget(
      link: _menuLinks[key]!,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_activeMenuKey == key) {
              _removeMenu();
              _hoverEnabled = false;
            } else {
              _showMenu(key, items);
              _hoverEnabled = true;
            }
          });
        },
        child: MouseRegion(
          onEnter: (_) {
            if (_hoverEnabled) {
              _cancelHideMenu();
              _showMenu(key, items);
            }
            setState(() {
              _hoveredMenuKey = key;
            });
          },
          onExit: (_) {
            if (_hoverEnabled) {
              _startHideMenu();
            }
            setState(() {
              _hoveredMenuKey = null;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: topMenuVerticalPadding,
            ),
            color: isHovered ? Colors.blue.shade700 : Colors.blue,
            child: Text(
              key,
              style: TextStyle(
                color: Colors.white,
                fontSize: topMenuTextFontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Row(
              children: [
                const SizedBox(width: 2),
                _buildTopMenuButton("File", [
                  "New",
                  "Open Recent",
                  "Save",
                  "Exit",
                ]),
                const SizedBox(width: 2),
                _buildTopMenuButton("Edit", [
                  "Undo",
                  "Redo",
                  "Cut",
                  "Copy",
                  "Paste",
                ]),
                const SizedBox(width: 2),
                _buildTopMenuButton("View", [
                  "Zoom In",
                  "Zoom Out",
                  "Full Screen",
                ]),
              ],
            ),
          ),
          Container(
            color: Colors.yellow.shade100,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ],
      ),
    );
  }
}
