import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Vinpi'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "This is my first flutter code",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo
                ),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.indigo, width: 2)
                ),

                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'Widget Tree in Action',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                        
                      )
                    )
                  ],
                  )
              ),

            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 40
              ),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, color: Colors.black, size: 30),
                  SizedBox(width: 20),
                  Text(
                    'User Profile'
                  )
                ],
              )
            )
            ],
            ),
            )
        )
    );
  }
}


 
