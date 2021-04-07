import 'package:flutter/material.dart';

import 'package:flutter_app/model/recipe.dart';
import 'package:flutter_app/utils/store.dart';
import 'package:flutter_app/model/state.dart';
import 'package:flutter_app/state_widget.dart';
import 'package:flutter_app/ui/screens/login.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  List<Recipe> recipes = getRecipes();
  List<String> userFavorites = getFavoritesIDs();


    DefaultTabController _buildTabView({Widget body}) {
      const double _iconSize = 20.0;

      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            // We set Size equal to passed height (50.0) and infinite width:
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              elevation: 2.0,
              bottom: TabBar(
                labelColor: Theme.of(context).indicatorColor,
                tabs: [
                  Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
                  Tab(icon: Icon(Icons.local_drink, size: _iconSize)),
                  Tab(icon: Icon(Icons.favorite, size: _iconSize)),
                  Tab(icon: Icon(Icons.settings, size: _iconSize)),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(5.0),
            child: body,
          ),
        ),
      );
    }

    TabBarView _buildTabsContent() {
      Padding _buildRecipes(List<Recipe> recipesList) {
        return Padding(
          // Padding before and after the list view:
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
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
          ),
        );
      }

      return TabBarView(
        children: [
          _buildRecipes(
              recipes.where((recipe) => recipe.type == RecipeType.food)
                  .toList()),
          _buildRecipes(recipes
              .where((recipe) => recipe.type == RecipeType.food)
              .toList()),
          _buildRecipes(recipes
              .where((recipe) => userFavorites.contains(recipe.id))
              .toList()),
          Center(child: Icon(Icons.settings)),
        ],
      );
    }

    Center _buildLoadingIndicator() {
      return Center(
        child: new CircularProgressIndicator(),
      );
    }

    Widget _buildContent() {
      if (appState.isLoading) {
        return _buildTabView(
          body: _buildLoadingIndicator(),
        );
      } else if (!appState.isLoading && appState.user == null) {
        return new LoginScreen();
      } else {
        return _buildTabView(
          body: _buildTabsContent(),
        );
      }
    }

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
      appState = StateWidget
          .of(context)
          .state;
      return _buildContent();
    }
  }
