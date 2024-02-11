// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

// Project imports:
import 'package:maskany_app/core/constants.dart';
import 'package:maskany_app/data/data_sources/local/shared_pref.dart';
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
                    child: TextButton(onPressed: () {
                      CacheHelper.clearData(key: tokenKey);
                    }, child: Text('Press')))
              ],
            ),
          );
        },
      ),
    );
  }
}
