import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<AppCubit>(context);
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: cubit.property.length,
                  itemBuilder: (context, index) {
                    var distanceDiff = Geolocator.distanceBetween(
                            cubit.currentLocation!.latitude,
                            cubit.currentLocation!.longitude,
                            double.parse(cubit.property[index].lat!),
                            double.parse(cubit.property[index].long!))
                        .toStringAsFixed(2);

                    return Card(
                      child: Center(
                        child: Text('Distance : ${distanceDiff} Km'),
                      ),
                    );
                  },
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
