import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignUpPage(),
    );
  }
}

class LoginSignUpPage extends StatefulWidget {
  @override
  _LoginSignUpPageState createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  bool isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void submit() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    if (!isLogin) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }
      if (_usernameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a username')),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful')),
      );
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/eco.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'ECO ZONE',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (!isLogin)
                    _buildTextField(
                      controller: _usernameController,
                      label: 'Username',
                    ),
                  SizedBox(height: 10),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                  ),
                  SizedBox(height: 10),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: true,
                  ),
                  if (!isLogin) SizedBox(height: 10),
                  if (!isLogin)
                    _buildTextField(
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      obscureText: true,
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 80),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Colors.purple,
                    ),
                    child: Text(
                      isLogin ? 'Login' : 'Sign Up',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: toggleForm,
                    child: Text(
                      isLogin
                          ? 'Don\'t have an account? Sign up'
                          : 'Already have an account? Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
          )
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: <Widget>[
            DashboardCard(
              title: 'Water Quality',
              imagePath: 'assets/images/quality_water.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WaterQualitySensorsPage()),
                );
              },
            ),
            DashboardCard(
              title: 'Environment',
              imagePath: 'assets/images/environment.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnvironmentPage()),
                );
              },
            ),
            DashboardCard(
              title: 'Biological System',
              imagePath: 'assets/images/biological_system.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BiologicalSystemPage()),
                );
              },
            ),
            DashboardCard(
              title: 'Devices',
              imagePath: 'assets/images/devices.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DevicesPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Function onTap;

  DashboardCard({required this.title, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class EnvironmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Environment Data'),
      ),
      body: Center(
        child: Text('Display data for Environment here'),
      ),
    );
  }
}

class BiologicalSystemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biological System Data'),
      ),
      body: Center(
        child: Text('Display data for Biological System here'),
      ),
    );
  }
}

class DevicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devices Data'),
      ),
      body: Center(
        child: Text('Display data for Devices here'),
      ),
    );
  }
}

class WaterQualitySensorsPage extends StatefulWidget {
  @override
  _WaterQualitySensorsPageState createState() =>
      _WaterQualitySensorsPageState();
}

class _WaterQualitySensorsPageState extends State<WaterQualitySensorsPage> {
  Map<String, Map<String, String>> sensorData = {
    'Temperature': {'value': '25°C', 'ideal': '24 - 28°C'},
    'Dissolved Oxygen': {'value': '8.5 mg/L', 'ideal': '6 - 8 mg/L'},
    'Ammonia': {'value': '0.02 mg/L', 'ideal': '0 - 0.05 mg/L'},
    'Nitrate': {'value': '0.15 mg/L', 'ideal': '10 - 20 mg/L'},
    'Electrical Conductivity': {'value': '200 µS/cm', 'ideal': '150 - 500 µS/cm'},
    'Dissolved Solids': {'value': '150 ppm', 'ideal': '100 - 200 ppm'},
    'pH': {'value': '7.2', 'ideal': '6.5 - 7.5'},
    'Water Level': {'value': '80%', 'ideal': '70% - 90%'}
  };

  String _generateRandomValue(String sensorName, String idealValue) {
    final random = Random();
    List<String> idealRange;

    switch (sensorName) {
      case 'Temperature':
        idealRange = idealValue.split(' - ');
        double minTemp =
        double.parse(idealRange[0].replaceAll('°C', ''));
        double maxTemp =
        double.parse(idealRange[1].replaceAll('°C', ''));
        double randomTemp =
            random.nextDouble() * (maxTemp - minTemp) + minTemp;
        return '${(randomTemp + random.nextDouble() * 2 - 1).toStringAsFixed(1)}°C';
      case 'Dissolved Oxygen':
        idealRange = idealValue.split(' - ');
        double minOxygen =
        double.parse(idealRange[0].replaceAll(' mg/L', ''));
        double maxOxygen =
        double.parse(idealRange[1].replaceAll(' mg/L', ''));
        double randomOxygen =
            random.nextDouble() * (maxOxygen - minOxygen) + minOxygen;
        return '${(randomOxygen + random.nextDouble() * 0.5 - 0.25).toStringAsFixed(1)} mg/L';
      case 'Ammonia':
        idealRange = idealValue.split(' - ');
        double minAmmonia =
        double.parse(idealRange[0].replaceAll(' mg/L', ''));
        double maxAmmonia =
        double.parse(idealRange[1].replaceAll(' mg/L', ''));
        double randomAmmonia =
            random.nextDouble() * (maxAmmonia - minAmmonia) + minAmmonia;
        return '${(randomAmmonia + random.nextDouble() * 0.01 - 0.005).toStringAsFixed(2)} mg/L';
      case 'Nitrate':
        idealRange = idealValue.split(' - ');
        double minNitrate =
        double.parse(idealRange[0].replaceAll(' mg/L', ''));
        double maxNitrate =
        double.parse(idealRange[1].replaceAll(' mg/L', ''));
        double randomNitrate =
            random.nextDouble() * (maxNitrate - minNitrate) + minNitrate;
        return '${(randomNitrate + random.nextDouble() * 0.05 - 0.025).toStringAsFixed(2)} mg/L';
      case 'Electrical Conductivity':
        idealRange = idealValue.split(' - ');
        double minEC =
        double.parse(idealRange[0].replaceAll(' µS/cm', ''));
        double maxEC =
        double.parse(idealRange[1].replaceAll(' µS/cm', ''));
        double randomEC =
            random.nextDouble() * (maxEC - minEC) + minEC;
        return '${(randomEC + random.nextDouble() * 20 - 10).toStringAsFixed(0)} µS/cm';
      case 'Dissolved Solids':
        idealRange = idealValue.split(' - ');
        double minDS =
        double.parse(idealRange[0].replaceAll(' ppm', ''));
        double maxDS =
        double.parse(idealRange[1].replaceAll(' ppm', ''));
        double randomDS =
            random.nextDouble() * (maxDS - minDS) + minDS;
        return '${(randomDS + random.nextDouble() * 20 - 10).toStringAsFixed(0)} ppm';
      case 'pH':
        idealRange = idealValue.split(' - ');
        double minPH = double.parse(idealRange[0]);
        double maxPH = double.parse(idealRange[1]);
        double randomPH =
            random.nextDouble() * (maxPH - minPH) + minPH;
        return '${(randomPH + random.nextDouble() * 0.3 - 0.15).toStringAsFixed(1)}';
      case 'Water Level':
        idealRange = idealValue.split(' - ');
        double minLevel =
        double.parse(idealRange[0].replaceAll('%', ''));
        double maxLevel =
        double.parse(idealRange[1].replaceAll('%', ''));
        double randomLevel =
            random.nextDouble() * (maxLevel - minLevel) + minLevel;
        return '${(randomLevel + random.nextDouble() * 5 - 2.5).toStringAsFixed(0)}%';
      default:
        return 'N/A';
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 15), (timer) {
      setState(() {
        sensorData = sensorData.map((key, value) {
          return MapEntry(key, {
            'value': _generateRandomValue(key, value['ideal']!),
            'ideal': value['ideal']!,
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Water Quality Sensors'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: sensorData.length,
        itemBuilder: (context, index) {
          String sensorName = sensorData.keys.elementAt(index);
          String sensorValue = sensorData[sensorName]!['value']!;
          String idealValue = sensorData[sensorName]!['ideal']!;

          IconData icon;
          switch (sensorName) {
            case 'Temperature':
              icon = Icons.thermostat;
              break;
            case 'Dissolved Oxygen':
              icon = Icons.air;
              break;
            case 'Ammonia':
              icon = Icons.warning;
              break;
            case 'Nitrate':
              icon = Icons.nature;
              break;
            case 'Electrical Conductivity':
              icon = Icons.electrical_services;
              break;
            case 'Dissolved Solids':
              icon = Icons.filter_list;
              break;
            case 'pH':
              icon = Icons.opacity;
              break;
            case 'Water Level':
              icon = Icons.water;
              break;
            default:
              icon = Icons.sensors;
          }

          return Card(
            elevation: 5,
            margin: EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 60,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.pink,
                          Colors.lightBlueAccent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      sensorName,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.pink,
                          Colors.lightBlueAccent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      'Current Value: $sensorValue',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.pink,
                          Colors.lightBlueAccent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      'Ideal Range: $idealValue',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}