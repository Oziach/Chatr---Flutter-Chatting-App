// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatr/authStuff/auth.dart';
import 'package:chatr/pages/settingsPage.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {

  const CustomDrawer({super.key});

  void Logout() {
    Auth auth = Auth();
    auth.Logout();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //logo
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.message_sharp,
                  color: Theme.of(context).colorScheme.primary,
                  size: 48,
                )
              ),
              
              //home list tile
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 12),
                child: ListTile(
                  leading: Icon(Icons.people),
                  title: Text('C H A T S', style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),),
                  onTap: (){}, 
                ),
              ),
              
              //settings list tile
                  Padding(
                padding: const EdgeInsets.only(left:20, top: 12),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('S E T T I N G S', style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),),
                  onTap: (){
                    Navigator.pop(context);

                    //goto settings
                    Navigator.push( 
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      )
                    );
                  }, 
                ),
              ),
            ],
          ),

          //logout
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 12, bottom: 20),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('L O G O U T', style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),),
              onTap: Logout, 
            ),
          )
        ],
      ),
    );
  }
}