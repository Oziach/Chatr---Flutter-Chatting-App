import 'package:chatr/themes/themeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Row(
        
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
          Text("Dark Mode", style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.w600),),
          CupertinoSwitch(
            value: Provider.of<ThemeProvider>(context, listen: false  ).isDarkMode,
            onChanged: (value){Provider.of<ThemeProvider>(context, listen: false).ToggleTheme();}
          )
        ],),
      ),
    );
  }
}