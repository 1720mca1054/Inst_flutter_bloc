import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:api_bloc_insta/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:api_bloc_insta/jsonimport.dart';
import 'jsonimport.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.home,
                    size: 37,
                  ),
                  Icon(
                    Icons.search,
                    size: 37,
                  ),
                  Icon(
                    Icons.add_box,
                    size: 37,
                  ),
                  Icon(
                    Icons.favorite_border,
                    size: 37,
                  ),
                  Icon(
                    Icons.perm_identity,
                    size: 37,
                  )
                ],
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(
              'Instagram',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            leading: Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
            actions: <Widget>[
              Transform.rotate(
                  alignment: Alignment(-1, 0.5),
                  angle: pi / -4,
                  child: Icon(Icons.send, color: Colors.black))
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: SafeArea(child: Instagram()),
            ),
          ),
        ));
  }
}

class Instagram extends StatefulWidget {
  @override
  _InstagramState createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  List list = [];
  ApiBloc bloc = ApiBloc();

  @override
  void initState() {
    super.initState();
    bloc.getData();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Row(children: <Widget>[
          GestureDetector(
            onTap: () {
              bloc.addStory();
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 8),
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: 60.0,
                          height: 60.0,
                          margin: EdgeInsets.only(left: 10, top: 8),
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTgdmgiXDeDj7Osrvbdl1Ppuos_q_uCDIUZims8fBQjFzXwRoxX")))),
                      Container(
                          height: 17,
                          width: 19,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          //padding: EdgeInsets.all(20),
                          //color: Colors.white,
                          margin: EdgeInsets.only(left: 51, top: 51),
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.blue,
                            size: 18,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Your Story',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              child: StreamBuilder<List<int>>(
                  stream: bloc.storyStream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return ListView.builder(

                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 9.5, bottom: 8),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                          width: 60.0,
                                          height: 60.0,
                                          margin:
                                              EdgeInsets.only(left: 10, top: 8),
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: new NetworkImage(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTgdmgiXDeDj7Osrvbdl1Ppuos_q_uCDIUZims8fBQjFzXwRoxX")))),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Added Story',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                    }
                  }),
            ),
          )
        ]),

//        Main Part of Instagram where Images and all things shows up
        Divider(),
        StreamBuilder(
          stream: bloc.apiControl,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              list = snapshot.data;
              return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List.generate(list.length, (index) {
                    Post data = list[index];
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, left: 7),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          width: 31.0,
                                          height: 31.0,
                                          margin: EdgeInsets.only(
                                              left: 8, bottom: 5),
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: new NetworkImage(
                                                      data.thumbnailUrl)))),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: Text(
                                          data.id.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        child: Icon(Icons.more_vert),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            //margin: EdgeInsets.only(top: 8),
                            child: Image.network(data.url),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 10.0, top: 8.0, bottom: 8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.chat_bubble_outline,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Transform.rotate(
                                    alignment: Alignment(-0.1, -0.6),
                                    angle: pi / -4,
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.black,
                                      size: 30,
                                    )),
                                Spacer(),
                                Icon(
                                  Icons.turned_in_not,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '57,038 views',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  //Text('astrogeeks')
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: RichText(
                                      text: TextSpan(
                                          text: '',
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: data.title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )
                                          ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }));
            } else
              return Text('');
          },
        )
      ]),
    );
  }
}

class ApiController {
  Future<List<Post>> fetchPost() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/photos');

    if (response.statusCode == 200) {
// If server returns an OK response, parse the JSON.

      var data = json.decode(response.body);
      var rest = data as List;
      List<Post> list = rest.map((json) => Post.fromJson(json)).toList();
      return list;
    } else {
// If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
