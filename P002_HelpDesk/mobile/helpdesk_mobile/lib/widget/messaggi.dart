import 'package:flutter/material.dart';
import 'package:helpdesk_mobile/custom_widget/custom_widget.dart';

class Messaggi extends StatefulWidget {
  const Messaggi({super.key});

  @override
  _MessaggiState createState() => _MessaggiState();
}

class _MessaggiState extends State<Messaggi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.barraApplicazioni(title: "Messaggi"),
      body:

          /// Notifications page
          const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.notifications_sharp),
                title: Text('Notification 1'),
                subtitle: Text('This is a notification'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.notifications_sharp),
                title: Text('Notification 2'),
                subtitle: Text('This is a notification'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
