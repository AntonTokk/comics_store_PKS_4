import 'package:flutter/material.dart';

class ComicDetailsScreen extends StatelessWidget {
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  final String description;

  ComicDetailsScreen({
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Автор: $author',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Цена: \$$price',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Описание:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Добавить в корзину
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Добавлено в корзину'),
                        ),
                      );
                    },
                    child: Text('Добавить в корзину'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}