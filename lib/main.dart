import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_dekho/backend/fetchNews.dart';
import 'package:news_dekho/screens/splashScreen.dart';
import 'package:news_dekho/utils/variables.dart';
import 'package:news_dekho/widgets/bottomNavBar.dart';
import 'package:news_dekho/widgets/newsTile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Portrain only screen orientation

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white),
    useMaterial3: true,
  );
  var darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white),
    useMaterial3: true,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const splashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  void categoryTapped(int index) {
    switch (index) {
      case 0:
        variables.category = 'entertainment';
        break;
      case 1:
        variables.category = 'sports';
        break;
      case 2:
        variables.category = 'science';
        break;
      case 3:
        variables.category = 'technology';
        break;
      case 4:
        variables.category = 'health';
        break;
      default:
        variables.category = 'entertainment';
        break;
    }
    print('category= ${variables.category} ');
  }

  void selectedCountry(String Country) {
    setState(() {
      variables.country = Country;
      variables.pageNo = 1;
      variables.query = '';
    });

    Future.delayed(Duration(milliseconds: 250), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    late var searchController = TextEditingController(text: variables.query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(137, 114, 112, 112),
        title: Container(
          height: 47,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(70))),
                ),
              ),
              //Search button
              IconButton(
                onPressed: () {
                  variables.pageNo = 1;
                  variables.query = searchController.text;

                  FocusScope.of(context)
                      .unfocus(); //remove the current focus from any widget within the focus scope
                  setState(() {});
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
      //Drawer
      drawer: Drawer(
        width: 210,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Select Country',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: InkWell(
                onTap: () => selectedCountry('in'),
                child: Card(
                  color: variables.country == 'in' ? Colors.greenAccent : null,
                  child: ListTile(
                    title: Text('India'),
                    trailing:
                        Image.asset('lib/assets/images/in.png', height: 37),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: InkWell(
                onTap: () => selectedCountry('us'),
                child: Card(
                  color: variables.country == 'us' ? Colors.greenAccent : null,
                  child: ListTile(
                    title: Text('United States'),
                    trailing:
                        Image.asset('lib/assets/images/us.png', height: 37),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: InkWell(
                onTap: () => selectedCountry('gb'),
                child: Card(
                  color: variables.country == 'gb' ? Colors.greenAccent : null,
                  child: ListTile(
                    title: Text('United Kingdom'),
                    trailing:
                        Image.asset('lib/assets/images/uk.png', height: 37),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: InkWell(
                onTap: () => selectedCountry('au'),
                child: Card(
                  color: variables.country == 'au' ? Colors.greenAccent : null,
                  child: ListTile(
                    title: Text('Australia'),
                    trailing:
                        Image.asset('lib/assets/images/au.png', height: 37),
                  ),
                ),
              ),
            ),
            SizedBox(height: 39),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Global',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: InkWell(
                onTap: () => selectedCountry(''), //for global
                child: Card(
                  color: variables.country == '' ? Colors.greenAccent : null,
                  child: ListTile(
                    title: Text(
                      'Worldwide',
                    ),
                    trailing:
                        Image.asset('lib/assets/images/globe.png', height: 37),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Navigation bar
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 17.0,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              categoryTapped(index);
              fetchNews(variables.category);
              variables.query = '';
              variables.pageNo = 1;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: " Entertainment",
              icon: Icon(Icons.tv_rounded),
            ),
            BottomNavigationBarItem(
              label: "Sports",
              icon: Icon(Icons.sports_soccer_rounded),
            ),
            BottomNavigationBarItem(
              label: "Science",
              icon: Icon(Icons.science_outlined),
            ),
            BottomNavigationBarItem(
              label: "Tech",
              icon: Icon(Icons.smartphone_rounded),
            ),
            BottomNavigationBarItem(
              label: "Health",
              icon: Icon(Icons.health_and_safety_rounded),
            ),
          ]),
      extendBodyBehindAppBar: true,

// Body

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: FutureBuilder<List>(
                    future: fetchNews(variables.category), //function call
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading indicator while waiting for the data
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return ListView.builder(
                        itemExtent: 110,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return newsTile(
                            title: snapshot.data![index]['title'].toString(),
                            description:
                                snapshot.data![index]['description'].toString(),
                            content:
                                snapshot.data![index]['content'].toString(),
                            publishedAt:
                                snapshot.data![index]['publishedAt'].toString(),
                            source: snapshot.data![index]['source']['name']
                                .toString(),
                            url: snapshot.data![index]['url'].toString(),
                            urlToImage:
                                snapshot.data![index]['urlToImage'].toString(),
                          );
                        },
                      );
                    }),
              ),
            ),
            Container(
              color: Color.fromARGB(0, 255, 153, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: variables.pageNo > 1
                          ? () {
                              setState(() {
                                variables.pageNo -= 1;
                              });
                            }
                          : null,
                      icon: Icon(Icons.navigate_before)),
                  SizedBox(width: 15),
                  Text(
                      '${variables.pageNo.toString()}/${variables.maxPages.toString()}'),
                  SizedBox(width: 15),
                  IconButton(
                      onPressed: variables.pageNo < variables.maxPages
                          ? () {
                              setState(() {
                                variables.pageNo += 1;
                              });
                            }
                          : null,
                      icon: Icon(Icons.navigate_next)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
