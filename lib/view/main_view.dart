import 'package:flutter/material.dart';
import 'package:restaurant_finder/bloc/bloc_provider.dart';
import 'package:restaurant_finder/bloc/location_bloc.dart';
import 'package:restaurant_finder/model/location.dart';
import 'package:restaurant_finder/view/location_view.dart';
import 'package:restaurant_finder/view/restaurant_view.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
        stream: BlocProvider.of<LocationBloc>(context).locationStream,
        builder: (context, snapshot) {
          final location = snapshot.data;

          if (location == null) {
            return LocationScreen();
          }

          return RestaurantScreen(location: location);
        });
  }
}
