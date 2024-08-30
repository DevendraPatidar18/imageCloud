import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagecloud/Screens/view_image_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    /*getUploadedImagesRef();*/
  }
  @override


  final userId = FirebaseAuth.instance.currentUser?.uid;
  List<String> imageUrl = [];
  final _picker = ImagePicker();
  List<String> _uploadedFile = [];
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImages().then((file) => uploadImages(file.toList()));
          setState(() { });
        },
        child: Icon(Icons.upload),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: StreamBuilder(
          stream: FirebaseStorage.instance
              .ref("$userId/Images/")
              .listAll()
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ListResult result = snapshot.data!;
              List<Future<String>> imageURLs = [];
              for (Reference ref in result.items) {
                imageURLs.add(ref.getDownloadURL());
              }

             return FutureBuilder<List<String>>(
                  future: Future.wait(imageURLs),
                  builder: (context, urlSnapshot) {
                    if (urlSnapshot.hasData) {
                      List<String> images = urlSnapshot.data!;
                      return GridView.builder(
                        itemCount: imageURLs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns in the grid
                          crossAxisSpacing: 10.0, // Spacing between columns
                          mainAxisSpacing: 10.0, // Spacing between rows
                          childAspectRatio: 1.0, // Aspect ratio of each grid item
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            child: InkWell(
                              onTap: (){
                                String? image = images[index];
                                Navigator.push(context, MaterialPageRoute(builder: (context) => View_image(image: image,  imageURls: images, )));
                              },
                                child: Image.network(images[index],)),
                          );
                        },
                      );
                    }
                    else if (urlSnapshot.hasError) {
                      return Text('Error: ${urlSnapshot.error}');
                    } else {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.blueAccent,),
                      );
                    }
                  });

            }
            else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(child: CircularProgressIndicator(color: Colors.blueAccent,));
            }

          }),
    );
  }

  Future<List<XFile>> pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    return images;
  }

  Future<List<String>> uploadImages(List<XFile> file) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final storageRef = FirebaseStorage.instance.ref();
    for (XFile e in file) {
      final fileName = e.path.split("/").last;
      final timeStamp = DateTime.now().microsecondsSinceEpoch;
      final uploadRef = storageRef.child("$userId/Images/$timeStamp-$fileName");
      await uploadRef.putFile(File(e.path));
      String url = await uploadRef.getDownloadURL();
      imageUrl.add(url);
    }
    return imageUrl;
  }
}
