import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String plantName;
  final double waterLevel;
  final double sunlightLevel;
  final double temperature;
  final double defectLevel;

  const DetailPage({super.key, 
    required this.plantName,
    this.waterLevel = 1.0,
    this.sunlightLevel = 0.5,
    this.temperature = 0.4,
    this.defectLevel = 0.2,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isVitaminPanelExpanded = false;
  bool _isAlbumPanelExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plantName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[ 
            const CircleAvatar(
              backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.qgWghmQWbaWSIn7DvMF0cgHaE6?rs=1&pid=ImgDetMain'),
              radius: 100,
            ),
            Text('Details for ${widget.plantName}'),
            const SizedBox(height: 40), // Add some spacing
            _buildIndicator('Water Level', widget.waterLevel),
            _buildIndicator('Sunlight Level', widget.sunlightLevel),
            _buildIndicator('Temperature', widget.temperature),
            _buildIndicator('Defect Level', widget.defectLevel),
            const SizedBox(height: 80),
            _buildVitaminPanel(),
            _buildAlbumPanel()
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(String label, double value) {
    return Column(
      children: <Widget>[
        Text(label),
        LinearProgressIndicator(
          value: value,
        ),
      ],
    );
  }

  Widget _buildVitaminPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isVitaminPanelExpanded = isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: _isVitaminPanelExpanded,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text('Vitamins'),
            );
          },
          body: const ListTile(
            title: Text('Vitamin A: Placeholder\nVitamin B: Placeholder\nVitamin C: Placeholder'),
          ),
        ),
      ],
    );
  }

  Widget _buildAlbumPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isAlbumPanelExpanded = isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: _isAlbumPanelExpanded,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text('Album'),
            );
          },
          body: const ListTile(
            title: Text('Placeholder for album content'),
          ),
        ),
      ],
    );
  }  
}
