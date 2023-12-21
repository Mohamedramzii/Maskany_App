import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:maskany_app/core/constants.dart';
import 'package:maskany_app/data/data_sources/network/dio_helper.dart';
import 'package:maskany_app/data/models/propertiesModel/properties_model2/properties_model2.dart';

import '../../data/models/propertiesModel/propertiesModel3.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  final controller1 = ScrollController();
  final controller2 = ScrollController();

  @override
  void initState() {
    fetch();
    controller1.addListener(() {
      if (controller1.position.maxScrollExtent == controller1.offset) {
        fetch();
      }
    });
    controller2.addListener(() {
      if (controller2.position.maxScrollExtent == controller2.offset) {
        fetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }


  List<PropertiesModel2> items = [];
  List<PropertiesModel2> itemPerLocation = [];
  int limit = 2;
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;

  Future fetch() async {
    if (isLoading) return;

    isLoading = true;

    Response response = await DioHelper.getData(
      url: 'http://66.45.248.247:8000/properties/?objects=$limit&page=$page',
      token: 'Token $tokenHolder',
    );
    if (response.statusCode == 200) {
      final List<PropertiesModel2> newItems = [];
      for (var item in response.data['results']) {
        newItems.add(PropertiesModel2.fromJson(item));
      }
      setState(() {
        page++;
        isLoading = false;

        print(newItems.length);
        if (newItems.length < limit) {
          hasMore = false;
          print(hasMore);
        }
        items.addAll(newItems);
        itemPerLocation = items.where((element) => element.city =='القاهرة').toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Center(
            child: SizedBox(
                height: 90,
                child: ListView.builder(
                  controller: controller1,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: items.length + 1,
                  itemBuilder: (context, index) {
                    if (index < items.length) {
                      return Text(
                        items[index].id.toString(),
                        style: const TextStyle(fontSize: 20),
                      );
                    } else {
                      return Center(
                        child: hasMore
                            ? const CircularProgressIndicator.adaptive()
                            : const Text('No More data to load'),
                      );
                    }
                  },
                )),
          ),
          Expanded(
              child: ListView.builder(
            controller: controller2,
            // scrollDirection: Axis.horizontal,
            itemCount: itemPerLocation.length ,
            itemBuilder: (context, index) {
              if (index < items.length) {
                return Text(
                  itemPerLocation[index].id.toString(),
                  style: const TextStyle(fontSize: 20),
                );
              } else {
                return Center(
                  child: hasMore
                      ? const CircularProgressIndicator.adaptive()
                      : const Text('No More data to load'),
                );
              }
            },
          ))
        ]),
      ),
    );
  }
}
