import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: padding,
        child: Material(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Container(
                      padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
                      child: Row(
                        children: [
                          Icon(Icons.admin_panel_settings_outlined),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Admin Panel"),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white24,
                    ),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      text: 'Create Election Event',
                      icon: Icons.calendar_view_month_outlined,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Create Election Event Manually',
                      icon: Icons.how_to_vote_outlined,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    const SizedBox(height: 24),
                    Divider(
                      color: Colors.white24,
                    ),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      text: 'View Results',
                      icon: Icons.bar_chart_outlined,
                      onClicked: () => selectedItem(context, 2),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        children: <Widget>[
                          Divider(
                            color: Colors.white24,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Admin"),
                                  // ad anything here
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white24;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
      //Navigator.of(context).push(MaterialPageRoute(builder: (context) =>PeoplePage(),))
      case 1:
      case 2:
      case 3:
        break;
    }
  }
}
