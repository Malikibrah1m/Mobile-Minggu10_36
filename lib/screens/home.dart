import 'package:flutter/material.dart';
import 'package:minggu10_35/model/user_model.dart';
import 'package:minggu10_35/services/api_services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<UserModel>? _userModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API {JSON} Placeholder'),
        centerTitle: true,
      ),
      body: _userModel == null || _userModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: .5,
              ),
              itemCount: _userModel!.length,
              itemBuilder: (context, index) {
                UserModel item = _userModel![index];
                return Card(
                  child: Column(
                    children: [
                      // Image.network('https://picsum.photos/id/$index/200/300'),
                      Image.network(item.thumbnailUrl),
                      //untuk iamge network saya menggunakan dari link lain, dikarenakan image dari API yang dipakai tidak bisa diakses
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          item.url,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.redAccent),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
