import 'package:flutter/material.dart';

class LostPasswordAppbar extends StatelessWidget
    implements PreferredSizeWidget {

  LostPasswordAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Theme.of(context).colorScheme.primary,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.clear),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
