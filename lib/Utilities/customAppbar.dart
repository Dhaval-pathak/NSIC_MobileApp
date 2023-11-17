import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Providers/progress_indicator.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final progressModel = Provider.of<ProgressIndicatorProvider>(context);
    final currentScreenIndex = progressModel.currentScreenIndex;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: CupertinoColors.white,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [
              Color(0x33dbfff0),
              Color(0xfff3e9db),
              Color(0x47f6f6b5)
            ],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Get.back();
          progressModel.goBackward();
        },
      ),
      title: ListTile(
        title: Text(
          "Step ${currentScreenIndex + 1}/5",
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text("New Unit Registration"),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: LinearProgressIndicator(
          value: (currentScreenIndex + 1) / 5,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xe2f1a729)),
        ),
      ),
    );
  }
}
