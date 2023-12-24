import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Cashflow'),
                subtitle: Text('teste@email.com'),
                // leading: Icon(Icons.account_circle),
              ),
              InkWell(onTap: () {}, child: Text('Sair'))
            ],
          ),
        ),
        ListTile(
          title: const Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    );
  }
}
