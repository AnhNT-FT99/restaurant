import 'dart:async';
import 'package:restaurant_finder/bloc/bloc.dart';
import 'package:restaurant_finder/model/location.dart';
import 'package:restaurant_finder/model/restaurant.dart';
import 'package:restaurant_finder/model/zomato_client.dart';

class RestaurantBloc implements Bloc {
  final Location location;
  final _client = ZomatoClient();
  final _controller = StreamController<List<Restaurant>>();

  RestaurantBloc(this.location);

  Stream<List<Restaurant>> get stream => _controller.stream;

  void submitQuery(String query) async {
    final results = await _client.fetchRestaurants(location, query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
