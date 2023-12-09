import 'package:flutter/material.dart';
import 'package:resmobile/models/meals_model.dart';
import 'package:resmobile/models/detail_model.dart';
import 'package:resmobile/services/api_data_source.dart';
import 'package:resmobile/views/detail_page.dart';

class ListPage extends StatefulWidget {
  final String title;

  const ListPage({Key? key, required this.title}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    var endpoint = widget.title == 'news' ? 'articles' : widget.title;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.title.toUpperCase()} LIST'),
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadList(endpoint),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (widget.title == 'news') {
              MealsModel news = MealsModel.fromJson(snapshot.data!);
              return _buildNews(news);
            } else if (widget.title == 'blogs') {
              DetailModel blogs = DetailModel.fromJson(snapshot.data!);
              return _buildBlogs(blogs);
            } else {
              DetailModel reports = DetailModel.fromJson(snapshot.data!);
              return _buildReports(reports);
            }
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildNews(MealsModel news) {
    return ListView.builder(
      itemCount: news.meals!.length,
      itemBuilder: (context, index) {
        var item = news.meals![index];
        return _buildItemList(
          item.strMealThumb!,
          item.strMeal!,
          '', // You may add summary and url fields here
          '',
        );
      },
    );
  }

  Widget _buildBlogs(DetailModel blogs) {
    return ListView.builder(
      itemCount: blogs.meals!.length,
      itemBuilder: (context, index) {
        var item = blogs.meals![index];
        return _buildItemList(
          item.strMealThumb!,
          item.strMeal!,
          '', // You may add summary and url fields here
          '',
        );
      },
    );
  }

  Widget _buildReports(DetailModel reports) {
    return ListView.builder(
      itemCount: reports.meals!.length,
      itemBuilder: (context, index) {
        var item = reports.meals![index];
        return _buildItemList(
          item.strMealThumb!,
          item.strMeal!,
          '', // You may add summary and url fields here
          '',
        );
      },
    );
  }

  Widget _buildItemList(
      String img, String title, String summary, String newsUrl) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(
              type: widget.title,
              title: title,
              imgUrl: img,
              summary: summary,
              newsUrl: newsUrl,
            ),
          ),
        );
      },
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                img,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
