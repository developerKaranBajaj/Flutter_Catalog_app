import 'package:first_application/core/store.dart';
import 'package:first_application/models/cart.dart';
import 'package:first_application/models/catalog.dart';
import 'package:first_application/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import "package:velocity_x/velocity_x.dart";
import 'home_widgets/catalog_header.dart';
import 'home_widgets/catalog_list.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final url = "https://api.jsonbin.io/b/61dfc124a34b603fd98288a4";
  final url = "https://api.jsonbin.io/b/61dfc63254d6b73fd3606d8e";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    // final catalogJson = await rootBundle.loadString("assets/files/catalog.json");
    final response = await http.get(Uri.parse(url));
    final catalogJson = response.body;
    var decodeData = jsonDecode(catalogJson);
    var productsData = decodeData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //final dummyList = List.generate(50, (index) => catalogModel.items[0]);
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      floatingActionButton:
       VxBuilder(
        mutations: const {AddMutation, RemoveMutation},
        builder: (context, dynamic, _) => FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.cartRoute);
          },
          child: const Icon(
            CupertinoIcons.cart,
            color: Colors.white,
          ),
          backgroundColor: context.theme.toggleableActiveColor,
          
        ).badge(
            color: Vx.red500,
            size: 22,
            count: _cart.items.length,
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                const CatalogList().py16().expand()
              else
                const CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
      /*    appBar: AppBar(
        title: const Text(
          "Flutter App",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (catalogModel.items!=null && catalogModel.items.isNotEmpty)? 
        // ListView.builder(
        //   itemCount: catalogModel.items.length,
        //   itemBuilder: (context, index) {
        //     return ItemWidget(item: catalogModel.items[index]);
        //   },
        // )
        GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16),
                itemBuilder: (context, index) {
                  final item = catalogModel.items[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: GridTile(
                      child: Image.network(item.image),
                      header: Container(
                        child: Text(item.name,style: const TextStyle(
                          color: Colors.white
                        )),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                        ),),
                      footer:  Container(
                        child: Text("\$" + item.price.toString(),
                        style: const TextStyle(
                          color: Colors.white
                        )),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),),
                      )
                  );   
                },
                itemCount: catalogModel.items.length,
              )
        :const Center(
          child: CircularProgressIndicator()
          ),
      ),
      drawer: MyDrawer(),*/
    );
  }
}
