import 'package:async/async.dart';
import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:charityapp/views/bloc/post_bloc/post_event.dart';
import 'package:charityapp/views/bloc/post_bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final postRepository = new PostRepositoryImp();
  // StreamSubscription? _postsSubscription;
  CancelableOperation? loadPostOperation;

  PostBloc() : super(PostsLoadInProgress()) {
    on<LoadEventPosts>(_onLoadPosts);
    on<AddPost>(_onAddPost);
    on<DeletePost>(_onDeletePost);
  }

  void _onLoadPosts(LoadEventPosts event, Emitter<PostState> emit) async {
    emit(PostsLoadInProgress());

    if (loadPostOperation != null && !loadPostOperation!.isCompleted)
      loadPostOperation!.cancel();

    final task = postRepository.load(
      event.eventId,
      event.startIndex,
      event.number,
    );
    loadPostOperation = CancelableOperation.fromFuture(task);

    final posts = await task;
    emit(PostsLoadSuccess(posts: posts));
  }

  void _onAddPost(AddPost event, Emitter<PostState> emit) {
    this.postRepository.add(event.post);
  }

  void _onDeletePost(DeletePost event, Emitter<PostState> emit) {
    this.postRepository.delete(event.post.id!);
  }
}
