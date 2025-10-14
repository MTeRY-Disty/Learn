import 'dart:async';

import 'package:c2/Pages/Httptodos.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
//import 'package:c2/Controller/NavBarController.dart';
import 'package:c2/Controller/HttpController.dart';

import 'Pages/HttpPost.dart';
import 'Pages/HttpUser.dart';
import 'Pages/MainNavigationWrapper.dart';
import 'core/Routes.dart';



void main()  {
  /*
  scheduleMicrotask( ()
  {
      Get.put(HttpController());
      Get.put(NavBarController());
  }
  );
  */

  runApp(GetMaterialApp(
  initialBinding: AllControllersBinding(),
  home: Click()
    ,) );
}

class Click extends StatelessWidget {
  const Click({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowS(),
    );
  }
}

/*
class ClickPage extends StatelessWidget {
  final ClickController clickController = Get.put(ClickController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Click"),backgroundColor: Colors.red, ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text ("num Clicks",style: TextStyle(fontSize: 60),),
              /*
              Obx(() => Text(
                "${clickController.click.value}",
                style: TextStyle(fontSize: 60),
              )),
              */
              GetBuilder<ClickController>(builder: (faisal)
              {
                return Text(
                    "${faisal.click}",
                    style: TextStyle(fontSize: 60));
              }


              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: clickController.decrement ,child: Icon(Icons.remove)),
                  ElevatedButton(onPressed: clickController.increment ,child: Icon(Icons.add))
                ]
              )
            ]
          ),
        ),
      ),
    );
  }
}
/*
class ClickController extends GetxController {
  RxInt click = 0.obs;

  void increment()  {
    click.value++;
      if(click.value % 5 ==0){
        Get.snackbar("MileStone reached", "keep the good work");
      }
      //refresh();
  }
  void decrement() {

    if(click.value == 0){
      Get.snackbar("STOP", "cant go below 0");
        return;
    }
    click.value--;
  }
}
*/
class ClickController extends GetxController {
  int click = 0;

  void increment()  {
    click++;
    if(click % 5 ==0){
      Get.snackbar("MileStone reached", "keep the good work");
    }
    update();
  }
  void decrement() {

    if(click == 0){
      Get.snackbar("STOP", "cant go below 0");
      return;
    }
    click--;
    update();
  }
}
////////////////////////////////////////////////////
*/
//takefive


class Show extends StatelessWidget {
  const Show({super.key});


  @override
  Widget build(BuildContext context) {
    //final NavBarController controllerNav = Get.find<NavBarController>();
   // /*
    Get.find<HttpController>();


    List<Widget> pages = [
      HttpUser(),
      HttpPost(),
      HttpTodos(),
      Placeholder(),
    ];
   // */
    return Scaffold(
        appBar: AppBar(title: Text("Show"),backgroundColor: Colors.red,),

        bottomNavigationBar:GetBuilder<NavBarController>(builder: (controllerNav) {
          return BottomNavigationBar(

            currentIndex: controllerNav.tapped,
            onTap: controllerNav.onTap ,
          showUnselectedLabels: false,
          unselectedItemColor: const Color(0xFF526400) ,
          selectedItemColor: Colors.red,

          items: [
            BottomNavigationBarItem(icon:
            Icon(FluentSystemIcons.ic_fluent_person_accounts_regular),
                label: "profile",
                activeIcon: Icon(FluentSystemIcons.ic_fluent_person_accounts_filled)),
            BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_photo_filter_regular),
              label: "photos",
              activeIcon: Icon(FluentSystemIcons.ic_fluent_photo_filter_filled),),
            BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_add_circle_regular),
              label: "c",
              activeIcon: Icon(FluentSystemIcons.ic_fluent_add_circle_filled),),
            BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_system_regular),
              label: "b",
              activeIcon: Icon(FluentSystemIcons.ic_fluent_system_filled),),

              ],
            );
          },
        ),

          body: GetBuilder<NavBarController>(builder: (controllerNav) {
      return pages[controllerNav.tapped];
    }),



    );
  }
}
///////////////////////////
class ShowS extends StatefulWidget {
  const ShowS({super.key});

  @override
  State<ShowS> createState() => _ShowState();
}

class _ShowState extends State<ShowS> {
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    bool controllerInitialized = false;
    // Initialize pages list
    pages = [
      HttpUser(),
      HttpPost(),
      HttpTodos(),
      Placeholder(),
    ];

    // Initialize controller after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controllerInitialized) {
        Get.find<HttpController>();
        controllerInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show"),
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: GetBuilder<NavBarController>(
        builder: (controllerNav) {
          return BottomNavigationBar(
            currentIndex: controllerNav.tapped,

            onTap: controllerNav.onTap,
            showUnselectedLabels: false,
            unselectedItemColor: const Color(0xFF526400),
            selectedItemColor: Colors.red,
            items: [
              BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_person_accounts_regular),
                label: "profile",
                activeIcon: Icon(FluentSystemIcons.ic_fluent_person_accounts_filled),
              ),
              BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_photo_filter_regular),
                label: "photos",
                activeIcon: Icon(FluentSystemIcons.ic_fluent_photo_filter_filled),
              ),
              BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_add_circle_regular),
                label: "c",
                activeIcon: Icon(FluentSystemIcons.ic_fluent_add_circle_filled),
              ),
              BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_system_regular),
                label: "b",
                activeIcon: Icon(FluentSystemIcons.ic_fluent_system_filled),
              ),
            ],
          );
        },
      ),
      body: GetBuilder<NavBarController>(
        builder: (controllerNav) {
          return pages[controllerNav.tapped];
        },
      ),
    );
  }
}

/*
void getHttp() async {
  try {
    dio.Response response;
    response = await dioc.get('https://jsonplaceholder.typicode.com/users');
    print(response.data.toString());
  } catch (e) {
    print('Request failed: $e');
  }
}
*/
////////////////////////////////////////////////////
///*
class NavBarController extends GetxController{
  int tapped = 0;

   void onTap(int i){
    tapped = i;
    update();
  }
}
//*/
/*
class HttpController extends GetxController{

final dioClient = dio.Dio();
List<User> users = [];
List<Post> posts = [];

Future<void> getHttp(String path) async {
  try {
    final response = await dioClient.get(
      'https://jsonplaceholder.typicode.com/$path');

    if(response.statusCode == 200){
      List<dynamic> data = response.data;
      if(path == 'users'){
        users = data.map((json) => User.fromJson(json)).toList();
      }else if(path == 'posts'){
        posts = data.map((json) => Post.fromJson(json)).toList();
      }
      update();
    }

  } catch (e) {
    debugPrint('Request failed: $e');
  }
}
}
*/
//////////////////////////////////////////////
/*
class HttpUser extends StatelessWidget {
  const HttpUser({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpController controllerH = Get.find<HttpController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Column(
            children: [

              Text("User List", style: TextStyle(fontSize: 20)),

              Expanded(
                child: GetBuilder<HttpController>(builder: (R) {
                  return ListView.builder(
                    itemCount: R.users.length,
                    itemBuilder: (context, index) {
                      final user = R.users[index];
                      return ListTile(
                        title: Text("Name: ${user.name}"),
                        subtitle: Text("ID: ${user.id} | Username: ${user.username}"),
                        onTap: (){
                          showDialog(context: context, builder: (_) => AlertDialog(
                            title: Text("ID: ${user.id} , ${user.name} "),
                            content: Column(
                              children: [
                                Text("Email:${user.email}"),
                                SizedBox(height: 21),
                                Text("address: "),
                                Text("Street: ${{user.address.street}}"),
                                Text("suite: ${{user.address.suite}}"),
                                Text("city: ${{user.address.city}}"),
                                Text("zipcode: ${{user.address.zipcode}}"),
                                Text("geo: lat :${{user.address.geo.lat}} | lng: ${{user.address.geo.lng}} "),
                                SizedBox(height: 21),
                                Text("phone:${user.phone}"),
                                SizedBox(height: 21),
                                Text("website:${user.website}"),
                                SizedBox(height: 21),
                                Text("company: "),
                                Text("name:${user.company.name}"),
                                Text("catchPhrase:${user.company.catchPhrase}"),
                                Text("bs:${user.company.bs}"),


                              ],
                            ),

                          )
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          )

      ),
    );

  }
}

class HttpPost extends StatelessWidget {
  const HttpPost({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpController controllerH = Get.find<HttpController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Column(
            children: [

              Text("Posts List", style: TextStyle(fontSize: 20)),

              Expanded(
                child: GetBuilder<HttpController>(builder: (R) {
                  return ListView.builder(
                    itemCount: R.posts.length,
                    itemBuilder: (context, index) {
                      final post = R.posts[index];
                      return ListTile(
                        title: Text("UserId: ${post.userId}"),
                        subtitle: Text("ID: ${post.id} "),
                        onTap: (){
                          showDialog(context: context, builder: (_) => AlertDialog(
                            title: Text("ID: ${post.userId} , ${post.id} "),
                            content: Column(
                              children: [
                                Text(post.title),
                                SizedBox(height: 21),
                                Text(post.body),


                              ],
                            ),

                          )
                          );
                        },
                      );
                    },
                  );
                }),
              ),
              /*
              Container(
                color: Colors.red,
                width: double.infinity,
                child: ElevatedButton(

                  onPressed: () {
                    //Get.find<HttpController>().getHttp();
                    controllerH.getHttp("posts");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),

                  child: const Icon(Icons.add),
                ),
              ),*/
            ],
          )

      ),
    );

  }
}
*/
/////////////////////////////////////////////////////
/*
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    email: json['email'],
    address: Address.fromJson(json['address']),
    phone: json['phone'],
    website: json['website'],
    company: Company.fromJson(json['company']),
  );
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json['street'],
    suite: json['suite'],
    city: json['city'],
    zipcode: json['zipcode'],
    geo: Geo.fromJson(json['geo']),
  );
}

class Geo {
  final String lat;
  final String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    lat: json['lat'],
    lng: json['lng'],
  );
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json['name'],
    catchPhrase: json['catchPhrase'],
    bs: json['bs'],
  );
}
*/
///////////////////////////////////////////
/*
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
});
  factory Post.fromJson(Map<String, dynamic> Json) => Post(
    userId: Json['userId'],
    id: Json['id'],
    title: Json['title'],
    body: Json['body']
  );

}
*/


class AllControllersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HttpController());
    Get.lazyPut(() => NavBarController());
  }
}