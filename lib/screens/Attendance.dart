import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text('ATTENDANCE')),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 0, 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('At Home',
                    style: Theme.of(context).textTheme.headline5),
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  onTap: null,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://scontent.fbkk14-1.fna.fbcdn.net/v/t1.0-9/13177687_995427020556595_9011059072266479109_n.jpg?_nc_cat=106&_nc_sid=174925&_nc_ohc=mSEMdIUWPp4AX9qrhK0&_nc_ht=scontent.fbkk14-1.fna&oh=63c13e736bd0e094686a5f4e3dd150f9&oe=5FA01EA7'), //  child: ,
                  ),
                  title: Text('Taem Potsathorn'),
                  subtitle: Text('9:30 PM'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: null,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://scontent.fbkk10-1.fna.fbcdn.net/v/t1.15752-9/120880748_2856447131265238_8336864427954512917_n.jpg?_nc_cat=102&_nc_sid=ae9488&_nc_ohc=YKQQSeFsZqUAX-2XCil&_nc_ht=scontent.fbkk10-1.fna&oh=ea89449b3781901c0a0c500a7ebab753&oe=5F9ED7C6'), //  child: ,
                  ),
                  title: Text('Ta Chanita'),
                  subtitle: Text('4:50 PM'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 15, 0, 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Not At Home',
                        style: Theme.of(context).textTheme.headline5),
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  onTap: null,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://scontent.fbkk10-1.fna.fbcdn.net/v/t1.15752-9/120908273_2681512852090915_3928138782469336254_n.jpg?_nc_cat=105&_nc_sid=ae9488&_nc_ohc=GsIjgDZxuBcAX_LYGVB&_nc_oc=AQmuvN8Gk1YieCCGoS_-9zmBGc90q8a0nQxT3Ox1X8h4UWDDDQaYFTB_pQd1W4lXSbg&_nc_ht=scontent.fbkk10-1.fna&oh=84350b59803079b134c0eebbce869ff1&oe=5FA12A72'), //  child: ,
                  ),
                  title: Text('Taeng Jidapa'),
                  subtitle: Text('6.34 AM'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: null,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://scontent.fbkk10-1.fna.fbcdn.net/v/t1.15752-9/120846275_699451117340494_5419469292602497837_n.jpg?_nc_cat=108&_nc_sid=ae9488&_nc_ohc=T2sgPK80PYIAX8UEIP6&_nc_ht=scontent.fbkk10-1.fna&oh=4648108d1ba29a25939b2e0b0401a9a5&oe=5F9FD347'), //  child: ,
                  ),
                  title: Text('Tree Ratree'),
                  subtitle: Text('6.00 AM'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: null,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://scontent.fbkk10-1.fna.fbcdn.net/v/t1.15752-9/120959567_753548415377383_5274481230380980416_n.jpg?_nc_cat=101&_nc_sid=ae9488&_nc_ohc=ghkz5sDDW0MAX8P4EJk&_nc_ht=scontent.fbkk10-1.fna&oh=e725c28d4636fbb26c6784bdd1f73097&oe=5FA2799F'), //  child: ,
                  ),
                  title: Text('Pat Supat'),
                  subtitle: Text('4.00 AM'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
