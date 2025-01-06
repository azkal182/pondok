import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pondok/core/utils/html_to_json_parser.dart';
import 'package:pondok/domain/entities/post.dart';
import 'package:pondok/domain/usecases/get_posts.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;

  PostBloc(this.getPosts) : super(PostInitial()) {
    on<FetchPostsEvent>((event, emit) async {
      emit(PostLoading());
      final result = await getPosts();
      result.fold(
        (failure) => emit(PostError(failure.message)),
        (posts) {
          final processedPosts = posts.map((post) {
            final parsedContent =
                HtmlToJsonHelper.convertHtmlToJson(post.content);
            final parseOverview = HtmlToJsonHelper.cleanHtml(post.overview);
            return post.copyWith(
                content: parsedContent.toString(),
                overview: parseOverview.toString());
          }).toList();
          emit(PostLoaded(processedPosts));
        },
      );
    });
  }
}
