import 'dart:async';

import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:charityapp/views/bloc/post_bloc/post_event.dart';
import 'package:charityapp/views/bloc/post_bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepositoryImp postRepository;
  StreamSubscription? _postsSubscription;

  PostBloc({required this.postRepository}) : super(PostsLoadInProgress());

  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is LoadPosts) {
      yield* _mapLoadPostsToState(event);
    } else if (event is AddPost) {
      yield* _mapAddPostToState(event);
    } else if (event is DeletePost) {
      yield* _mapDeletePostToState(event);
    } else if (event is PostsUpdated) {
      yield* _mapPostsUpdatedToState(event);
    }
  }

  Stream<PostState> _mapLoadPostsToState(LoadPosts event) async* {
    _postsSubscription?.cancel();
      _postsSubscription = this.postRepository.load(event.eventId, event.startIndex, event.number).listen((posts) {
        add(PostsUpdated(eventId: event.eventId, posts: posts));
      });
  }
  Stream<PostState> _mapAddPostToState(AddPost event) async* {
    this.postRepository.add(event.post);
  }
  Stream<PostState> _mapDeletePostToState(DeletePost event) async* {
    this.postRepository.delete(event.post.id);
  }
  Stream<PostState> _mapPostsUpdatedToState(PostsUpdated event) async* {
    yield PostsLoadSuccess(posts: event.posts);
  }
}
