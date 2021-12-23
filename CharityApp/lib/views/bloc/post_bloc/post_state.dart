import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/post_overview.dart';
import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostsLoadSuccess extends PostState {
  final List<Post> posts;
  PostsLoadSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostsLoadOverviewSuccess extends PostState {
  final List<PostOverview> postsOverview;
  PostsLoadOverviewSuccess({required this.postsOverview});

  @override
  List<Object> get props => [postsOverview];
}

class PostsLoadFailure extends PostState {}

class PostsLoadInProgress extends PostState {}

class LoadingPostState extends PostState {}

class LoadedPostState extends PostState {
  List<Post> listPost = [];

  LoadedPostState(this.listPost);
}

class LoadingFailState extends PostState {}

class LoadingDetailPostState extends PostState {}

class LoadedDetailPostState extends PostState {}

class LoadingFailDetailState extends PostState {}
