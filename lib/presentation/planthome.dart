import 'package:flutter/material.dart';
import 'package:smartgarden_v3/presentation/plantinfo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> plants = ['Coriander', 'Broccoli', 'Sunflower', 'Spinat', 'Cauli Flower'];

    void _showAddPlantDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newPlantName = ''; // Initialize an empty string for the new plant name

        return AlertDialog(
          title: const Text('Add New Plant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Plant Name'),
                onChanged: (value) {
                  newPlantName = value; // Update the new plant name as the user types
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newPlantName.isNotEmpty) {
                  setState(() {
                    plants.add(newPlantName); // Add the new plant to the list
                  });
                }
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditPlantDialog(int index) {
    String newPlantName = plants[index]; // Initialize with the current plant name

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Plant Name'),
          content: TextFormField(
            initialValue: newPlantName,
            onChanged: (value) {
              newPlantName = value; // Update the new plant name as the user types
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  plants[index] = newPlantName; // Update the plant name
                });
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deletePlant(int index) {
    setState(() {
      plants.removeAt(index); // Remove the plant from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              height: 100,
              child: Stack(
                children: <Widget>[
                  ListTile(
                    title: Text(plants[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailPage(plantName: plants[index])),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row( // This adds three icons at the end of the ListTile
                      children: <Widget>[
                        CircleAvatar(
                          radius: 10, // Adjust the size of the CircleAvatar
                          backgroundColor: Colors.white, // Change color to white
                          child: Icon(Icons.nature, color: Color.fromARGB(255, 2, 254, 31), size: 20), // Change the icon and its color
                          foregroundColor: Colors.red, // Add a red border
                        ),
                        SizedBox(width: 5), // Add space between the icons
                        CircleAvatar(
                          radius: 10, // Adjust the size of the CircleAvatar
                          backgroundColor: Colors.white, // Change color to white
                          child: Icon(Icons.wb_sunny, color: Color.fromARGB(255, 242, 238, 2), size: 20), // Change the icon and its color
                          foregroundColor: Colors.red, // Add a red border
                        ),
                        SizedBox(width: 5), // Add space between the icons
                        CircleAvatar(
                          radius: 10, // Adjust the size of the CircleAvatar
                          backgroundColor: Colors.white, // Change color to white
                          child: Icon(Icons.thermostat, color: Colors.black, size: 20), // Change the icon and its color
                          foregroundColor: Colors.red, // Add a red border
                        ),
                      ],
                    ),
                  ),                  
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditPlantDialog(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deletePlant(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPlantDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
