
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:squelette_mobile_parcours/controllers/ArticleController.dart';
import 'package:squelette_mobile_parcours/controllers/CategorieController.dart';
import 'package:squelette_mobile_parcours/pages/createArticle/widgets/EntryFieldLongtext.dart';
import '../../utils/Routes.dart';
import 'widgets/EntryField.dart';
import 'package:provider/provider.dart';

import 'widgets/EntryFieldBloqued.dart';

class CreateArticleSellPage extends StatefulWidget {
  final int? article_id;
  CreateArticleSellPage({this.article_id});

  @override
  State<CreateArticleSellPage> createState() => _CreateArticleSellPageState();
}

class _CreateArticleSellPageState extends State<CreateArticleSellPage> {

  bool isSwitched = false;
  final _controller = ValueNotifier<bool>(false);
  bool checked = false;

  var title_form = TextEditingController(text: "Mercedes");
  var price_form = TextEditingController(text: "1200000");
  var country_form = TextEditingController(text: "R.D. Congo");
  var city_form = TextEditingController(text: "Kinshasa");
  var content_form = TextEditingController(text: "Contenue de la description de l'élément à vendre. Contenue de la description de l'élément à vendre.");
  var keyword_form = TextEditingController(text: "voiture");
  bool negociation_form=false;
  var devise_form = TextEditingController(text: "CDF");
  int? _categorySelected = 1;
  var formkey = GlobalKey<FormState>();
  bool isVisible = false;

  List<File> _selectedImages = [];
  final ImagePicker picker = ImagePicker();
  var imageFile;
  var imagePicker;

  Widget _buildImageList() {
    print("${_selectedImages.length} Images sélectionnées");
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.file(
              _selectedImages[index],
              width: 150,
              height: 230,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var categorieCtrl = context.read<CategorieController>();
      categorieCtrl.recuperCategorieAPI();
      imagePicker = new ImagePicker();
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
          Navigator.popAndPushNamed(context, Routes.HomePagePageRoutes);
        },
        child: Icon(
          Icons.arrow_back,
          size: 25,
          color: Colors.black,
        ),
      ),
      title: Text(
        "Vendre",
        style: TextStyle(
          fontSize: 30,
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
    String ListCategories = categoriCtrl.categories.map((e) => e.category_name).toString();
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
                _entryFieldDropdown(ListCategories,
                    _categorySelected, (value) {
                  print("selection $value");
                      setState(() {
                        _categorySelected = value;
                      });
                    }
                ),
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
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          negociation_form = isSwitched;
                          print("La valeur est : ${isSwitched}");
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
                SizedBox(
                  height: 10,
                ),
                Text("Ajouter les images (Max 5)",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Center(
                  child: _selectedImages.isNotEmpty
                      ? Container(height: 100, child: _buildImageList())
                      : Container(height: 0, child: _buildImageList()),
                ),
                SizedBox(
                  height: 5,
                ),
                _uploadImages(),
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

  Widget _uploadImages () {
    return DottedBorder(
      color: Colors.grey,
      dashPattern: [8, 8],
      strokeWidth: 1.4,
      borderType: BorderType.RRect,
      radius: Radius.circular(40),
      child: Column(
        children: [
          Container(
              height: 80,
              child: imageFile == null
                  ? Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        selectImage();
                      },
                      child: Icon(
                        Icons.cloud_upload,
                        color: Colors.orangeAccent,
                        size: 50,
                      ),
                    ),
                    Text(
                      "Click here to upload",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ): Container(
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }


  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                           await selectImageFromGallery();
                            print('Image_Path:-${_selectedImages}');
                            if (_selectedImages.isNotEmpty) {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/gallery.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            _selectedImages = await selectImageFromCamera();
                            print('Image_Path:-${_selectedImages}');
                            if (_selectedImages.isNotEmpty) {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
        );
  }

  selectImageFromGallery() async {
    List<XFile> xfilePick = await ImagePicker().pickMultiImage(imageQuality: 10);
    setState(
          () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            _selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    setState(
          () {
        if (file != null) {
          _selectedImages.add(File(file.path));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Widget _entryFieldDropdown( String categoriesList,
      int? defaultValue, Function(int?) onChange) {
    var categoriCtrl = context.watch<CategorieController>();
    int? _selectedValue=defaultValue;
    print("VOICI LE PRINT +++++++++++++++++++ $_selectedValue");
    String? label = "Selectionnez une catégorie";
    var selectedOption = _selectedValue == null ? label:_selectedValue;
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

  Widget _addingButton(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding:
      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(29),
          color: Colors.black),
      height: 50,
      child: Builder(
          builder: (ctx) {
            return TextButton(
              onPressed: () => _validateForm(ctx),
              child: Text(
                "Publier l'annonce",
                style:
                TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }
      ),
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
    int price  = int.parse(price_form.text);
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
      "price": price,
      "country": country,
      "city": city,
      "content": content,
      "category_id": _category_id,
      "keyword": keyword,
      "negociation": negociation,
      "devise": devise,
    };

    var response = await ctrl.envoieDataArticleCree(dataNewSellArticle, _selectedImages);
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
    if (response.status) {
      await Future.delayed(Duration(seconds: 2));
      setState(() {});
      Navigator.popAndPushNamed(context, Routes.HomePagePageRoutes);
    } else {
      var msg =
      response.isException == true ? response.errorMsg : (response.data?['message'] ?? "");
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          content: Text('$msg')));
    }
    isVisible = false;
  }
}

