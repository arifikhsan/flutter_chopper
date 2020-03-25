import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chopper/data/post_api_service.dart';
import 'package:flutter_chopper/models/built_post.dart';
import 'package:flutter_chopper/single_post_page.dart';
import 'package:provider/provider.dart';
import 'package:built_collection/built_collection.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chopper Blog'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newPost = BuiltPost(
            (builder) => builder
              ..title = 'new title'
              ..body = 'new body',
          );
          final response = await Provider.of<PostApiService>(
            context,
            listen: false,
          ).postPost(newPost);
          print(response.body);
        },
      ),
    );
  }

  FutureBuilder<Response<BuiltList<BuiltPost>>> _buildBody(
      BuildContext context) {
    return FutureBuilder<Response<BuiltList<BuiltPost>>>(
      future: Provider.of<PostApiService>(context).getPosts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // } else {
        if (snapshot.connectionState == ConnectionState.done) {
          // print(snapshot.data.body);
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          } else if (snapshot.hasData) {
            final posts = snapshot.data.body;
            return _buildPosts(context, posts);
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('waiting'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
        // }
      },
    );
  }

  ListView _buildPosts(BuildContext context, BuiltList<BuiltPost> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].body),
            onTap: () => _navigateToPost(context, posts[index].id),
          ),
        );
      },
    );
  }

  void _navigateToPost(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SinglePostPage(postId: id),
      ),
    );
  }
}
