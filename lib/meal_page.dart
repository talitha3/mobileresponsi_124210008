import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'meals_model.dart';


class PageListMeals extends StatefulWidget {
  const PageListMeals({Key? key}) : super(key: key);

  @override
  State<PageListMeals> createState() => _PageListMealsState();
}

class _PageListMealsState extends State<PageListMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MEALS"),
        centerTitle: true,
      ),
      body: _buildListMealsBody(),
    );
  }

  Widget _buildListMealsBody() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: ApiDataSource.instance.loadMeal(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            Meal meal = Meal.fromJson(snapshot.data);
            return _buildSuccessSection(meal);
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

  Widget _buildSuccessSection(Meal data) {
    return ListView.builder(
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: InkWell(
              //onTap: () {
                //Navigator.push(
                  //context,
                 // MaterialPageRoute(
                   // builder: (context) => PageDetailMeals(meals: data.meals![index]),
                 // ),
               // );
             // },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        data.meals![index].strMealThumb!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.meals![index].strMeal!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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