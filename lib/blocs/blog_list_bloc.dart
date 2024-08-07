import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/blog.dart';
import '../repositories/blog_repository.dart';

// Events
abstract class BlogListEvent {}

class FetchBlogs extends BlogListEvent {}

class ToggleFavorite extends BlogListEvent {
  final Blog blog;
  ToggleFavorite(this.blog);
}

// States
abstract class BlogListState {}

class BlogListInitial extends BlogListState {}

class BlogListLoading extends BlogListState {}

class BlogListLoaded extends BlogListState {
  final List<Blog> blogs;
  BlogListLoaded(this.blogs);
}

class BlogListError extends BlogListState {
  final String message;
  BlogListError(this.message);
}

// BLoC
class BlogListBloc extends Bloc<BlogListEvent, BlogListState> {
  final BlogRepository repository;

  BlogListBloc(this.repository) : super(BlogListInitial()) {
    on<FetchBlogs>(_onFetchBlogs);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onFetchBlogs(FetchBlogs event, Emitter<BlogListState> emit) async {
    emit(BlogListLoading());
    try {
      final blogs = await repository.fetchBlogs();
      emit(BlogListLoaded(blogs));
    } catch (e) {
      emit(BlogListError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<BlogListState> emit) async {
    if (state is BlogListLoaded) {
      final currentState = state as BlogListLoaded;
      await repository.toggleFavorite(event.blog);
      final updatedBlogs = currentState.blogs.map((blog) {
        if (blog.id == event.blog.id) {
          return event.blog;
        }
        return blog;
      }).toList();
      emit(BlogListLoaded(updatedBlogs));
    }
  }
}