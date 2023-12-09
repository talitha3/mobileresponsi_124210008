import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'categories_model.dart';
import 'meal_page.dart';


class PageListCategories extends StatefulWidget {
  const PageListCategories({Key? key}) : super(key: key);

  @override
  State<PageListCategories> createState() => _PageListCategoriesState();
}

class _PageListCategoriesState extends State<PageListCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MEALS CATEGORIES"),
        centerTitle: true,
      ),
      body: _buildListCategoriesBody(),
    );
  }

  Widget _buildListCategoriesBody() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCategori(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            Kategori kategori = Kategori.fromJson(snapshot.data);
            return _buildSuccessSection(kategori);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildSuccessSection(Kategori data) {
    return ListView.builder(
      itemCount: data.categories!.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Card(
         child: InkWell(
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageListMeals(),
                  ),
        );
             },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        data.categories![index].strCategoryThumb!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.categories![index].strCategory!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.categories![index].strCategoryDescription!,
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
