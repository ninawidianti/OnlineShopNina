import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshopnina/addproduct.dart';
import 'package:onlineshopnina/homepage.dart';
import 'package:onlineshopnina/updateproduct.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  List productList = [];

  Future<void> deleteProduct(String id) async {
    String urlDeleteProduct =
        "https://ninawidianti.000webhostapp.com/deleteproduct.php";

    try {
      var responseDelete =
          await http.post(Uri.parse(urlDeleteProduct), body: {"id": id});
      var deleteDataProduct = jsonDecode(responseDelete.body);
      if (deleteDataProduct["success"] == "true") {
        print("Product successfully deleted");
        // Remove the product from the list and update the state
        setState(() {
          productList.removeWhere((product) => product["id"] == id);
        });
      } else {
        print("Product failed to delete");
      }
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> getAllProduct() async {
    String urlAllProduct =
        "https://ninawidianti.000webhostapp.com/allproductlist.php";

    try {
      var response = await http.get(Uri.parse(urlAllProduct));
      productList = jsonDecode(response.body);
      setState(() {
        productList = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  @override
  void initState() {
    getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: const Text(
          'Product List',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(5),
            child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  '${productList[index]["images"]}',
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                productList[index]["name"],
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      productList[index]['description']!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Text(
                    'Rp'
                    '${productList[index]['price']}',
                    // productList[index]['price']!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Rp'
                    '${productList[index]['promo']}',
                    // productList[index]['price']!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProduct(
                            id: productList[index]["id"],
                            name: productList[index]["name"],
                            price: productList[index]["price"],
                            description: productList[index]["description"],
                            promo: productList[index]["promo"],
                            images: productList[index]["images"],
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.upload_circle_fill,
                      size: 18,
                      color: Colors.yellow.shade800,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteProduct(productList[index]["id"]);
                    },
                    icon: Icon(
                      CupertinoIcons.delete_solid,
                      size: 18,
                      color: Colors.red.shade400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProduct()),
          );
        },
        mini: true,
        splashColor: Colors.green.shade400,
        backgroundColor: Colors.green.shade200,
        child: const Icon(
          CupertinoIcons.add_circled,
          size: 12,
          color: Colors.black54,
        ),
      ),
    );
  }
}
