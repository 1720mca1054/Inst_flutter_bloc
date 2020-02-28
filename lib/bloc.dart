import 'dart:async';

import 'package:api_bloc_insta/main.dart';

class ApiBloc implements Bloc {
  int storyCount = 0;
  List<int> storyList=[];

  final StreamController _apiController = StreamController();
  final StreamController _storyController = StreamController<List<int>>();

  Stream get apiControl => _apiController.stream;
  Stream get storyStream => _storyController.stream;

  addStory(){
    storyCount++;
    storyList.add(storyCount);
    _storyController.sink.add(storyList);
  }


  getData() async {
    ApiController apiController = ApiController();
    List data = await apiController.fetchPost();
    if (data.length > 20) data = data.sublist(0, 50);
    print(data.toString());
    _apiController.sink.add(data);
  }

  @override
  void dispose() {
    _apiController.close();
    _storyController.close();
  }
}

abstract class Bloc {
  void dispose();
}
