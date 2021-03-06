import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
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
  final List<EventOverviewPaticipants> eventsOverview;
  PostsLoadOverviewSuccess({required this.eventsOverview});

  @override
  List<Object> get props => [eventsOverview];
}

class PostLoadFailure extends PostState {}

class PostLoadInProgress extends PostState {}

class PostUpdated extends PostState {
  final Post post;
  const PostUpdated({required this.post});
    @override
  List<Object> get props => [post];
}
class PostUpdateFail extends PostState {
  
}
