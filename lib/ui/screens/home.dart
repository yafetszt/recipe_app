import 'package:flutter/material.dart';
import 'package:flutter_app/model/recipe.dart';
import 'package:flutter_app/utils/store.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Recipe> recipes = getRecipes();
  List<String> userFavorites = getFavoritesIDs();

  void _handleFavoritesListChanged(String recipeID) {
    setState(() {
      if (userFavorites.contains(recipeID)) {
        userFavorites.remove(recipeID);
      } else {
        userFavorites.add(recipeID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Column _buildRecipes(List<Recipe> recipesList) {
      return Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: recipesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(recipesList[index].name),
                    );
                  },
              ),
          ),
        ],
      );
    }

    const double _iconSize = 20.0;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 2.0,
              bottom: TabBar(
                labelColor: Theme.of(context).indicatorColor,
                tabs: [
                  Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
                  Tab(icon: Icon(Icons.favorite, size: _iconSize)),
                  Tab(icon: Icon(Icons.settings, size: _iconSize)),
                ],
              ),
            ),
          ),
            body: Padding(
              padding: EdgeInsets.all(5.0),
              child: TabBarView(
                children: [
                  _buildRecipes(recipes.where((recipe) => recipe.type == RecipeType.food).toList()),
                  _buildRecipes(recipes.where((recipe) => userFavorites.contains(recipe.id)).toList()),
                  Center(child: Icon(Icons.settings)),
                ],
              ),
            ),
        ),
      );
  }
}