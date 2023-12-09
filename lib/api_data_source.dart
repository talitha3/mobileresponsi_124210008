import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadCategori() {
    return BaseNetwork.get("api/json/v1/1/categories.php");
  }
  Future<Map<String, dynamic>> loadMeal() {
    return BaseNetwork.get("api/json/v1/1/filter.php?c=Seafood");
  }
  Future<Map<String, dynamic>> loadDetailMeal() {
    return BaseNetwork.get("api/json/v1/1/lookup.php?i=52772");
  }

  Future<Map<String, dynamic>> loadDetailBlogs(int blogId){
    String id = blogId.toString();
    return BaseNetwork.get("blogs/?format=json/$blogId");
  }
  Future<Map<String, dynamic>> loadDetailNews(int newId){
    String id = newId.toString();
    return BaseNetwork.get("news/?format=json/$newId");
  }
  Future<Map<String, dynamic>> loadDetailReports(int reportId){
    String id = reportId.toString();
    return BaseNetwork.get("reports/?format=json/$reportId");
  }
}