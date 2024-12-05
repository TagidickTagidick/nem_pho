import 'package:flutter/material.dart';
import 'package:socket_io_client_flutter/socket_io_client_flutter.dart' as IO;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Socket.IO Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    // Configure socket connection
    socket = IO.io('https://nikolyamba-nem-pho-backend-64d9.twc1.net/',
        <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to the Socket.IO server
    socket.connect();

    // Listen for connection events
    socket.on('connect', (_) {
      print('Connected to the server');
      socket.emit('message', 'Hello from Flutter!');
    });

    // Listen for responses from the server
    socket.on('response', (data) {
      print('Response from server: $data');
    });

    // Handle connection errors
    socket.on('connect_error', (err) {
      print('Connection error: $err');
    });

    // Handle disconnection
    socket.on('disconnect', (_) {
      print('Disconnected from server');
    });
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Socket.IO Demo'),
      ),
      body: const Center(
        child: Text('Check your console for connection logs'),
      ),
    );
  }
}