class Endpoints {
  static const String authentication = "/api/login";
  static const String articlesEndpoint = "/api/articles";
  static const String deleteArticlesEndpoint = "/api/articles/{id}";
  static const String imagesArticlesEndpoint = "/api/articles/{id}/images";
  static const String categoriesEndpoint = "/api/categories";
  static const String annoncesSimilaireEndpoint = "/annoncesSimilairesApi.php";
  static const String createArticlePublicationEndpoint = "/api/articles";
  static const String updateArticlePublicationEndpoint = "/api/articles/{id}";
  static const String createImagesPublicationEndpoint = "/api/articles/{id}/images/";
  static const String updateImagesArticleEndpoint = "/api/articles/{id}/images/{id}";
  static const String userToken="token";
  static const String detailUserEndpoint = "/api/singleUser";
  static const String logout = "/api/logout";
  static const String register = "/api/register";

}
