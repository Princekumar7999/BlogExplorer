import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blog_list_bloc.dart';
import '../widgets/blog_list_item.dart';
import '../widgets/error_widget.dart';
import 'blog_detail_screen.dart';

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blog Explorer')),
      body: BlocBuilder<BlogListBloc, BlogListState>(
        builder: (context, state) {
          if (state is BlogListInitial) {
            context.read<BlogListBloc>().add(FetchBlogs());
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogListLoaded) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogListItem(
                  blog: blog,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailScreen(blog: blog),
                      ),
                    );
                  },
                  onFavoriteToggle: () {
                    context.read<BlogListBloc>().add(ToggleFavorite(blog));
                  },
                );
              },
            );
          } else if (state is BlogListError) {
            return ErrorDisplayWidget(message: state.message);
          }
          return Container();
        },
      ),
    );
  }
}
