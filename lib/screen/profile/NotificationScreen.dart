import 'package:bmitserp/provider/notificationprovider.dart';
import 'package:bmitserp/widget/notification/notificationlist.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: Notification(),
    );
  }
}

class Notification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  var initial = true;

  Future<String> getNotification() async {
    await Provider.of<NotificationProvider>(context, listen: false)
        .getNotification();

    return "Loaded";
  }

  @override
  void didChangeDependencies() {
    if (initial) {
      getNotification();
      initial = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text('Notification'),
          ),
          body: RefreshIndicator(
              onRefresh: () {
                Provider.of<NotificationProvider>(context, listen: false).page =
                    1;
                return getNotification();
              },
              child: NotificationList())),
    );
  }
}
