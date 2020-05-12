import 'package:flutter/material.dart';
import 'package:restaurant_finder/bloc/bloc_provider.dart';
import 'package:restaurant_finder/bloc/restaurant_bloc.dart';
import 'package:restaurant_finder/model/location.dart';
import 'package:restaurant_finder/model/restaurant.dart';
import 'package:restaurant_finder/view/location_view.dart';
import 'package:restaurant_finder/view/restaurant_tile_view.dart';

class RestaurantScreen extends StatelessWidget {
  final Location location;

  const RestaurantScreen({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFBF2E2E), Color(0xFFCE5E5E)])),
        ),
        title: Text(location.title),
      ),
      body: _buildSearch(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit_location),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LocationScreen(
              isFullScreenDialog: true,
            ),
            fullscreenDialog: true,
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    final bloc = RestaurantBloc(location);

    return BlocProvider(
      bloc: bloc,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Món ăn',
              ),
              onChanged: (query) => bloc.submitQuery(query),
            ),
          ),
          Expanded(child: _buildStreamBuilder(bloc)),
        ],
      ),
    );
  }

  Widget _buildStreamBuilder(RestaurantBloc bloc) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        final results = snapshot.data;

        if (results == null) {
          return Center(child: Text('Tên Nhà Hàng'));
        }

        if (results.isEmpty) {
          return Center(child: Text('Không có kết quả'));
        }

        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Restaurant> results) {
    return ListView.separated(
      itemCount: results.length,
      itemBuilder: (context, index) => Divider(),
      separatorBuilder: (context, index) {
        final restaurant = results[index];
        return RestaurantTile(restaurant: restaurant);
      },
    );
  }
}
