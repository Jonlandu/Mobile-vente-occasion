import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:squelette_mobile_parcours/controllers/ArticleController.dart';
import 'package:squelette_mobile_parcours/controllers/CategorieController.dart';
import 'package:squelette_mobile_parcours/pages/Articles/Widgets/EntryFieldLongtext.dart';
import '../../models/ArticleModel.dart' as ArticleModel;
import '../../utils/Routes.dart';
import 'Widgets/EntryField.dart';
import 'package:provider/provider.dart';
import 'Widgets/EntryFieldBloqued.dart';

class ArticleUpdatePage extends StatefulWidget {
  final ArticleModel.ArticleModel articleToUpdate;

  ArticleUpdatePage({required this.articleToUpdate});

  @override
  State<ArticleUpdatePage> createState() => _ArticleUpdatePageState();
}

class _ArticleUpdatePageState extends State<ArticleUpdatePage> {
  bool isSwitched = false;

  final _controller = ValueNotifier<bool>(false);
  bool checked = false;

  late var titleArticleToUpdate;
  late var contentArticleToUpdate;
  late var keywordArticleToUpdate;
  late var deviseArticleToUpdate;
  late var countryArticleToUpdate;
  late var cityArticleToUpdate;
  late var priceArticleToUpdate;
  int? negociationArticleToUpdate;
  late var categoryArticleToUpdate;

  TextEditingController title_form = TextEditingController();
  TextEditingController content_form = TextEditingController();
  TextEditingController keyword_form = TextEditingController();
  TextEditingController devise_form = TextEditingController();
  TextEditingController country_form = TextEditingController();
  TextEditingController city_form = TextEditingController();
  TextEditingController price_form = TextEditingController();
  bool? negociation_form;
  //late int? _categorySelected = 1;
  int? _categorySelected = 1;

  var formkey = GlobalKey<FormState>();
  bool isVisible = false;

  List<File> _selectedImages = [];
  final ImagePicker picker = ImagePicker();
  var imageFile;
  var imagePicker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var categorieCtrl = context.read<CategorieController>();
      categorieCtrl.recuperCategorieAPI();

      titleArticleToUpdate = widget.articleToUpdate.title;
      title_form = TextEditingController(text: "${titleArticleToUpdate}");
      contentArticleToUpdate = widget.articleToUpdate.content;
      content_form = TextEditingController(text: "${contentArticleToUpdate}");
      keywordArticleToUpdate = widget.articleToUpdate.keyword;
      keyword_form = TextEditingController(text: "${keywordArticleToUpdate}");
      deviseArticleToUpdate = widget.articleToUpdate.devise;
      devise_form = TextEditingController(text: "${deviseArticleToUpdate}");
      countryArticleToUpdate = widget.articleToUpdate.country;
      country_form = TextEditingController(text: "RD Congo");
      cityArticleToUpdate = widget.articleToUpdate.city;
      city_form = TextEditingController(text: "${cityArticleToUpdate}");
      priceArticleToUpdate = widget.articleToUpdate.price;
      price_form = TextEditingController(text: "${priceArticleToUpdate}");
      negociationArticleToUpdate = widget.articleToUpdate.negociation;
      negociation_form = negociationArticleToUpdate == 1;
      isSwitched = negociationArticleToUpdate == 1;
      categoryArticleToUpdate = widget.articleToUpdate.categorie_name;
      //_categorySelected = categoryArticleToUpdate;
      imagePicker = new ImagePicker();

      setState(() {});

      _controller.addListener(() {
        setState(() {
          if (_controller.value) {
            checked = true;
          } else {
            checked = false;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Stack(children: [_body(context)]),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          size: 25,
          color: Colors.black,
        ),
      ),
      title: Text(
        "Modifier l'article",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    var categoriCtrl = context.watch<CategorieController>();
    String ListCategories =
        categoriCtrl.categories.map((e) => e.category_name).toString();
    return Form(
      key: formkey,
      child: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EntryField(
                  ctrl: title_form,
                  label: "Titre",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                EntryFieldLongtext(
                  ctrl: content_form,
                  label: "Description",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                _entryFieldDropdown(ListCategories, _categorySelected, (value) {
                  print("selection $value");
                  setState(() {
                    _categorySelected = value;
                  });
                }),
                SizedBox(
                  height: 10,
                ),
                EntryField(
                  ctrl: price_form,
                  label: "Prix",
                  required: true,
                  type: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                EntryFieldBloqued(
                  ctrl: devise_form,
                  label: "",
                  required: true,
                ),
                Row(
                  children: [
                    Text("Negociable",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 10,
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          negociation_form = isSwitched;
                        });
                      },
                      activeTrackColor: Colors.orange,
                      activeColor: Colors.deepOrange,
                    ),
                  ],
                ),
                EntryFieldBloqued(
                  ctrl: country_form,
                  label: "",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                EntryField(
                  ctrl: city_form,
                  label: "Province ou Ville",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                EntryField(
                  ctrl: keyword_form,
                  label: "Mot clé ",
                  required: true,
                ),
                _addingButton(),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _entryFieldDropdown(
      String categoriesList, int? defaultValue, Function(int?) onChange) {
    var categoriCtrl = context.watch<CategorieController>();
    int? _selectedValue = defaultValue;
    String? label = "Selectionnez une catégorie";
    var selectedOption = _selectedValue == null ? label : _selectedValue;
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.grey,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  selectedOption.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: categoriCtrl.categories
              .map((item) => DropdownMenuItem<int>(
                    value: item.id,
                    child: Text(
                      item.category_name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: _selectedValue,
          onChanged: (value) {
            onChange(value);
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.white,
            ),
            elevation: 0,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            padding: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            elevation: 8,
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }

  Widget _addingButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(29), color: Colors.black),
      height: 50,
      child: Builder(builder: (ctx) {
        return TextButton(
          onPressed: () => _validateForm(ctx),
          child: Text(
            "Modifier l'article",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        );
      }),
    );
  }

  void _validateForm(BuildContext ctx) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formkey.currentState!.validate()) {
      return;
    }
    isVisible = true;

    setState(() {});
    var ctrl = context.read<ArticleController>();
    int price = int.parse(price_form.text);
    String country = country_form.text;
    String city = city_form.text;
    String content = content_form.text;
    int? _category_id = _categorySelected;
    String keyword = keyword_form.text;
    bool? negociation = negociation_form;
    String devise = devise_form.text;
    String title = title_form.text;

    Map dataNewSellArticle = {
      "title": title,
      "content": content,
      "keyword": keyword,
      "devise": devise,
      "country": country,
      "city": city,
      "price": price,
      "negociation": negociation,
      "category_id": _category_id,
    };
    var articleId = widget.articleToUpdate.id;
    var response = await ctrl.updateArticlesCreated(
        articleId, dataNewSellArticle, _selectedImages);
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
    if (response.status != 200 || response.status != 204) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      Navigator.popAndPushNamed(context, Routes.HomePagePageRoutes);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 5),
          content: Text('Vous avez modifier cet article')));
    } else {
      var msg = response.isException == false
          ? response.errorMsg
          : (response.data?['message'] ?? "");
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          content: Text('$msg')));
    }
    isVisible = false;
  }
}
