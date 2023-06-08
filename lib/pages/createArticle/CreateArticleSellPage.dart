import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:squelette_mobile_parcours/controllers/ArticleController.dart';
import 'package:squelette_mobile_parcours/pages/createArticle/widgets/EntryFieldLongtext.dart';
import '../../utils/Routes.dart';
import 'widgets/EntryField.dart';
import 'package:provider/provider.dart';

class CreateArticleSellPage extends StatefulWidget {
  CreateArticleSellPage({this.selectedValue, this.article_id});
  final int? article_id;
  final String? selectedValue;

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  @override
  State<CreateArticleSellPage> createState() => _CreateArticleSellPageState();
}

class _CreateArticleSellPageState extends State<CreateArticleSellPage> {
  String? _selectedValue ;
  bool isSwitched = false;
  final _controller = ValueNotifier<bool>(false);
  bool checked = false;
  var categorie = TextEditingController();
  var title_form = TextEditingController(text: "Titre");
  var price_form = TextEditingController(text: "1000");
  var country_form = TextEditingController(text: "RD congo");
  var city_form = TextEditingController(text: "Kinshasa");
  var content_form = TextEditingController(text:"Contenu quelconque");
  var keyword_form = TextEditingController(text: "keyword");
  bool? negociation_form;
  var devise_form = TextEditingController(text: "CDF");

  String selectedImagePath = '';

  var formkey = GlobalKey<FormState>();
  bool isVisible = false;
  final ImagePicker picker = ImagePicker();
  XFile? imageSelectetion;
  var imageFile;
  var imagePicker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
          Navigator.popAndPushNamed(context, Routes.ArticlesPageRoutes);
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
                Text("Categorie de la vente",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                _entryFieldDropdown(),
                SizedBox(
                  height: 10,
                ),
                Text("Titre de l'annonce",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                EntryField(
                  ctrl: title_form,
                  label: "ex: Veste Pastorale",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Prix de l'article",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    ),
                    Row(
                      children: [
                        Text("Negociable",
                            style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                        ),
                        SizedBox(width: 2,),
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
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                EntryField(
                  ctrl: price_form,
                  label: "ex: 150.000 Fc",
                  required: true,
                  type: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Pays ou Région",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                EntryField(
                  ctrl: country_form,
                  label: "ex: RD. Congo",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Province ou Ville",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                EntryField(
                  ctrl: city_form,
                  label: "ex: RD. Congo",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Devise",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                //
                EntryField(
                  ctrl: devise_form,
                  label: "ex: Vrai ou Faux",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Description",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),

                EntryFieldLongtext(
                  ctrl: content_form,
                  label: "ex: Lorem ipsum igora tu fes igora tu Lorem ipsum igora tu fes igora tu",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Mot clé",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8,),
                    Text("(Possibilité de trouver votre article par recherche)",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:
                        TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                  ],),
                SizedBox(
                  height: 5,
                ),
                EntryField(
                  ctrl: keyword_form,
                  label: "ex: veste pastorale",
                  required: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Ajouter les images (Max 6)",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selectedImagePath == ''
                          ? Image.asset('assets/image_placeholder.png', height: 0, width: 0, fit: BoxFit.fill,)
                          : Image.file(File(selectedImagePath), height: 200, width: 200, fit: BoxFit.fill,),
                      SizedBox(
                        height: 10.0,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                _uploadImages(),
                SizedBox(
                  height: 20,
                ),
                _addingButton(),
                SizedBox(
                  height: 10,
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
      radius: Radius.circular(30),
      child: Column(
        children: [
          Container(
              height: 100,
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
                    SizedBox(height: 4,),
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
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
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
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
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
        });
  }

/*  //Selecting multiple images from Gallery
  List<XFile>? imageFileList = [];
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {});
  }*/

  // Select Image from Gallery
  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  // Select Image from Camera
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  Widget _entryFieldDropdown() {
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
                  'Selectionnez la catégorie',
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
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
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
            setState(() {
              _selectedValue = value as String;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.white,
            ),
            elevation: 2,
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
      "keyword": keyword,
      "negociation": negociation,
      "devise": devise,
    };
    print(dataNewSellArticle);

    var response = await ctrl.envoieDataArticleCree(dataNewSellArticle);
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
    print(response.status);
    if (response.status) {
      await Future.delayed(Duration(seconds: 2));
      Navigator.popAndPushNamed(context, Routes.HomePagePageRoutes);
    } else {
      var msg =
      response.isException == true ? response.errorMsg : (response.data?['message'] ?? "");
      print("mqg=====!!! $msg");
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          content: Text('$msg')));
    }
    isVisible = false;
  }
}

