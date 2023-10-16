import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_resources/colors.dart';
import '../view_model/CUBIT/cubit/app_cubit.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return Scaffold(
          appBar: AppBar(),
          body:  SafeArea(child: cubit.screen[cubit.currentindex]),
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              height: 70.h,
              child: BottomNavigationBar(
                  currentIndex: cubit.currentindex,
                  onTap: (index) {
                    cubit.btmNavBar(index);
                  },
                  fixedColor: ColorsManager.kprimaryColor,
                  backgroundColor: Colors.grey.shade100,
                  type: BottomNavigationBarType.shifting,
                  iconSize: 30.r,
                  elevation: 10,
                  unselectedItemColor: Colors.black26,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled),
                      // activeIcon: Icon(Icons.home_filled),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      // activeIcon: Icon(Icons.home_filled),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.location_on),
                      // activeIcon: Icon(Icons.home_filled),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      // activeIcon: Icon(Icons.home_filled),
                      label: '',
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
