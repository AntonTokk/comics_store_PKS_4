import 'package:flutter/material.dart';

void main() {
  runApp(ComicsStoreApp());
}

class ComicsStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comics Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<String> favorites = {};
  String selectedCategory = 'All';

  final List<Comic> comics = [
    Comic(
      title: 'Spider-Man: Blue',
      author: 'Jeph Loeb',
      price: 14.99,
      imageUrl: 'https://i.pinimg.com/736x/1d/a4/3d/1da43d8742b591be0dd6557410e701b7.jpg',
      category: 'Spider-Man',
      description: 'Это трогательная история о Питере Паркере и Гвен Стейси.',
      quantity: 5,
    ),
    Comic(
      title: 'Spider-Man: Kraven\'s Last Hunt',
      author: 'J.M. DeMatteis',
      price: 17.99,
      imageUrl: 'https://cdn1.ozone.ru/s3/multimedia-1-d/6933150625.jpg',
      category: 'Spider-Man',
      description: 'Последняя охота Кравена на Человека-паука.',
      quantity: 3,
    ),
    Comic(
      title: 'Batman: Year One',
      author: 'Frank Miller',
      price: 19.99,
      imageUrl: 'https://s3.amazonaws.com/www.covernk.com/Covers/L/B/Batman+Year+One/batmanyearonetradepaperback1.jpg',
      category: 'Batman',
      description: 'Происхождение Бэтмена.',
      quantity: 7,
    ),
    Comic(
      title: 'Batman: The Long Halloween',
      author: 'Jeph Loeb',
      price: 22.99,
      imageUrl: 'https://static.tvtropes.org/pmwiki/pub/images/batman_long_halloween_cover.jpg',
      category: 'Batman',
      description: 'Годовая тайна для Бэтмена.',
      quantity: 4,
    ),
    Comic(
      title: 'Teenage Mutant Ninja Turtles: City at War',
      author: 'Kevin Eastman',
      price: 15.99,
      imageUrl: 'https://vignette.wikia.nocookie.net/tmnt/images/b/b0/Idw91.jpg/revision/latest?cb=20190214074102',
      category: 'Ninja Turtles',
      description: 'Черепашки сталкиваются с городской войной.',
      quantity: 6,
    ),
    Comic(
      title: 'Teenage Mutant Ninja Turtles: The Last Ronin',
      author: 'Kevin Eastman',
      price: 24.99,
      imageUrl: 'https://i.dailymail.co.uk/1s/2024/04/11/21/83526179-13298943-image-a-142_1712867277901.jpg',
      category: 'Ninja Turtles',
      description: 'Последний выживший Черепашка ищет мести.',
      quantity: 2,
    ),
  ];

  List<Comic> get filteredComics {
    if (selectedCategory == 'All') {
      return comics;
    } else {
      return comics.where((comic) => comic.category == selectedCategory).toList();
    }
  }

  void removeComic(Comic comic) {
    setState(() {
      comics.remove(comic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comics Store'),
      ),
      body: Column(
        children: <Widget>[
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
            items: <String>['All', 'Spider-Man', 'Batman', 'Ninja Turtles']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredComics.length,
              itemBuilder: (context, index) {
                final comic = filteredComics[index];
                return ComicItem(
                  comic: comic,
                  isFavorite: favorites.contains(comic.title),
                  onFavoritePressed: () {
                    setState(() {
                      if (favorites.contains(comic.title)) {
                        favorites.remove(comic.title);
                      } else {
                        favorites.add(comic.title);
                      }
                    });
                  },
                  onComicPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComicDetailsScreen(comic: comic),
                      ),
                    );
                  },
                  onRemovePressed: () {
                    removeComic(comic);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Comic {
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  final String category;
  final String description;
  final int quantity;

  Comic({
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.quantity,
  });
}

class ComicItem extends StatelessWidget {
  final Comic comic;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onComicPressed;
  final VoidCallback onRemovePressed;

  ComicItem({
    required this.comic,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onComicPressed,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onComicPressed,
        child: Row(
          children: <Widget>[
            Image.network(
              comic.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      comic.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      comic.author,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      '\$${comic.price}',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: onFavoritePressed,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onRemovePressed,
            ),
          ],
        ),
      ),
    );
  }
}

class ComicDetailsScreen extends StatelessWidget {
  final Comic comic;

  ComicDetailsScreen({required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              comic.imageUrl,
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
                    comic.title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Автор: ${comic.author}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Цена: \$${comic.price}',
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
                    comic.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Осталось экземпляров: ${comic.quantity}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
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