import 'package:flutter/material.dart';
import 'package:world_time/pages/add_location.dart';
import 'package:world_time/service/world_time.dart';
class ChooseLocation extends StatefulWidget {

  final Function delete;

  ChooseLocation({this.delete});

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {


  List<WorldTime> locations = [
    WorldTime(url: 'Asia/Karachi',location: 'Karachi' , flag: 'pakistan.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index]; // we have the item user clicked on
    await instance.getTime();
    // navigate to home screen
    Navigator.pop(context, {
      'location' : instance.location,
      'flag' : instance.flag,
      'time' : instance.time,
      'isDayTime' : instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(// flutter automatically places a back arrow in the app bar when we come here from another screen
        backgroundColor: Colors.blue[900],
        title: Text('choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount:  locations.length,
        itemBuilder: (context,index){
          final location = locations[index]; // object of current location in list
          return Dismissible(
              key: Key(location.location), // location name key for dismissible widget
              onDismissed: (direction) {
                setState(() => locations.removeAt(index));
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${location.location} removed'),
                    )
                  );
              },
              background: Container(color: Colors.red),
              child: Padding(
              padding: const EdgeInsets.symmetric(vertical:1.0,horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    try{updateTime(index);}
                    catch(e){
                      print(e.toString());
                      
                    }
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/${locations[index].flag}'),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() => locations.removeAt(index));
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${location.location} removed'),
                          )
                        );
                      },
                    icon: Icon(Icons.delete),
                    ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         dynamic result = await showModalBottomSheet(context: context, builder: (context) {
            return  AddLocation();
          });
          setState(() {
            locations.insert(
              locations.length,
              WorldTime(
              location: result['location'],
              url: result['url'],
              flag: result['flag'],
              )
            );
          });
        },
        child: Icon(Icons.add,size:40.0,),
        backgroundColor: Colors.blue[900],
        ),
    );
  }
}
