import 'package:flutter/material.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MainPage(),
      routes: {
        '/recipe-list': (context) => RecipeListPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.redAccent, // Color for selected item
        unselectedItemColor: Colors.black, // Color for unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> recipeCategories = [
    'Appetizers',
    'Main Courses',
    'Desserts',
    'Drinks'
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Categories'),
      ),
      body: ListView.builder(
        itemCount: recipeCategories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipeCategories[index]),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/recipe-list',
                arguments: recipeCategories[index],
              );
            },
          );
        },
      ),
    );
  }
}

class RecipeListPage extends StatelessWidget {
  final Map<String, List<Map<String, String>>> recipes = {
    'Appetizers': [
      {'name': 'Bruschetta', 'image': 'assets/bruschetta.jpg'},
      {'name': 'Stuffed Mushrooms', 'image': 'assets/mushrooms.jpg'},
    ],
    'Main Courses': [
      {'name': 'Spaghetti Carbonara', 'image': 'assets/spaghetti.jpg'},
      {'name': 'Grilled Chicken', 'image': 'assets/chicken.jpg'},
    ],
    'Desserts': [
      {'name': 'Cheesecake', 'image': 'assets/cheesecake.jpg'},
      {'name': 'Chocolate Cake', 'image': 'assets/chocolate_cake.jpg'},
    ],
    'Drinks': [
      {'name': 'Mojito', 'image': 'assets/mojito.jpg'},
      {'name': 'Lemonade', 'image': 'assets/lemonade.jpg'},
    ],
  };

  RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String category =
        ModalRoute.of(context)?.settings.arguments as String;

    final List<Map<String, String>> categoryRecipes = recipes[category]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Recipes'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3 / 4,
        ),
        itemCount: categoryRecipes.length,
        itemBuilder: (context, index) {
          final recipe = categoryRecipes[index];
          return RecipeCard(
            name: recipe['name']!,
            imagePath: recipe['image']!,
          );
        },
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String name;
  final String imagePath;

  RecipeCard({super.key, required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Recipes'),
      ),
      body: const Center(
        child: Text('Search for your favorite recipes here!'),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: const Center(
        child: Text('Your favorite recipes will be listed here!'),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: const Center(
        child: Text('Manage your profile here!'),
      ),
    );
  }
}
