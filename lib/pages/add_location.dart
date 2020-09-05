import 'package:flutter/material.dart';
import 'package:world_time/service/world_time.dart';

class AddLocation extends StatefulWidget {
    
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {

  List<WorldTime> allLocations = [
    WorldTime(url: 'Asia/Karachi',location: 'Karachi' , flag: 'pakistan.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  WorldTime locationToAdd;

  void addLocation(WorldTime location){
      Navigator.pop(context,{
        'location': location.location ?? 'Karachi',
        'url' : location.url ?? 'Asia/Karachi',
        'flag': location.flag ?? 'pakistan.png',
      });
  }

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
          itemCount: allLocations.length,
          itemBuilder: (context,index) {
              return Card(
                  child: ListTile(
                    onTap: () => addLocation(allLocations[index]),
                    title: Text(allLocations[index].location),
                ),
              );
          },
        );
  }
}
