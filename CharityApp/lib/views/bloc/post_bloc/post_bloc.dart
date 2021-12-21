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
    on<LoadPosts>(_onLoadPosts);
    on<AddPost>(_onAddPost);
    on<DeletePost>(_onDeletePost);
    on<PostsUpdated>(_onPostsUpdated);
  }

  void _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
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
    add(PostsUpdated(eventId: event.eventId, posts: posts));

    // _postsSubscription?.cancel();
    // _postsSubscription = this
    //     .postRepository
    //     .load(event.eventId, event.startIndex, event.number)
    //     .listen((posts) async {
    //   final userRepo = UserRepositoryImp();
    //   UserOverview newuser = UserOverview(name: 'thạch', avatarUri: null);
    //   posts.map((post) {
    //     post.creator = newuser;
    //   });

    // });
  }

  void _onAddPost(AddPost event, Emitter<PostState> emit) {
    this.postRepository.add(event.post);
  }

  void _onDeletePost(DeletePost event, Emitter<PostState> emit) {
    this.postRepository.delete(event.post.id!);
  }

  void _onPostsUpdated(PostsUpdated event, Emitter<PostState> emit) {
    emit(PostsLoadSuccess(posts: event.posts));
    // List<Post> listPost = [];
    // final _postReposibility = new UserRepositoryImp();
    //
    // @override
    // Stream<PostState> mapEventToState(PostEvent event) async* {
    //  if ( event is LoadPostEvent)
    //  {
    //    yield* _mapToPostState();
    //  }
    // }
    // Stream<PostState> _mapToPostState() async*{
    //   try{
    //     yield LoadingPostState();
    //     if (listPost.isEmpty) listPost = await _postReposibility.getListPost(GetIt.I.get<Authenticator>().idCurrentUser);
    //     LoadedPostState(listPost);
    //   } catch(e){
    //     yield LoadingFailState();
    //   }
    // }
  }
}
