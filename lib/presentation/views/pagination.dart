import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

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

  List items = [];
  int limit = 30;
  int page = 1;
  bool hasMore = true;
  bool isLoading=false;

  Future fetch() async {
    if(isLoading) return;

    isLoading =true;
    final url = Uri.parse(
        // 'https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page'
        'http://66.45.248.247:8000/properties/?page=1'
        );
    final response = await http.get(url, headers: {'page': '1'});

    if (response.statusCode == 200) {
      final List newItems = json.decode(response.body);
      setState(() {
        page++;
        isLoading=false;
        if (newItems.length < limit) {
          hasMore = false;
        }
        items.addAll(newItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
            controller: controller1,
            scrollDirection: Axis.horizontal,
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index < items.length) {
                return Text(
                  items[index]['id'].toString(),
                  style: const TextStyle(fontSize: 20),
                );
              } else {
                return  Center(
                  child: hasMore
                      ? const CircularProgressIndicator.adaptive()
                      : const Text('No More data to load'),
                );
              }
            },
          )),
          Expanded(
              child: ListView.builder(
            controller: controller2,
            // scrollDirection: Axis.horizontal,
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index < items.length) {
                return Text(
                  items[index]['id'].toString(),
                  style: const TextStyle(fontSize: 20),
                );
              } else {
                return  Center(
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
