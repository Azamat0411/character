import 'package:character/bloc/character_bloc.dart';
import 'package:character/bloc/character_event.dart';
import 'package:character/data/character.dart';
import 'package:character/repository/character_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc/character_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int page = 1;
  final refresher = RefreshController();
  List result = [];
  //return Scaffold(


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x411A1A1A),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Characters"),
      ),
      body: BlocProvider<CharacterBloc>(
        create: (context) => CharacterBloc(CharacterRepo(), page)
          ..add(CharacterEventFetch(page)),
        child: BlocConsumer<CharacterBloc, CharacterState>(
          listener: (context, state) {
            const Text('data');
          },
          builder: (context, state) {
            if (state is CharacterLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CharacterLoaded) {
              result = state.loadedChar;
              return SmartRefresher(
                controller: refresher,
                enablePullUp: true,
                enablePullDown: false,
                onLoading: _onLoading,
                child: ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          String url = "https://www.rickandmortyapi.com";
                          var urllaunchable = await canLaunch(url);
                          if (urllaunchable) {
                            await launch(url);
                          } else {
                            // print("URL can't be launched.");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[600],
                            ),
                            child: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          result[index]["image"],
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Text(
                                        result[index]["name"],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            child: null,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: result[index]["status"] ==
                                                      "Alive"
                                                  ? Colors.green
                                                  : result[index]["status"] ==
                                                          "Dead"
                                                      ? Colors.red
                                                      : null,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            result[index]["status"] +
                                                " " +
                                                "-" +
                                                " " +
                                                result[index]["species"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Last known location:",
                                        style: TextStyle(
                                            color: Color(0x8affffff),
                                            fontSize: 18),
                                      ),
                                      Text(
                                        result[index]["location"]["name"],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          result[index]["image"],
                                          fit: BoxFit.fill,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .4,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            result[index]["name"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                child: null,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: result[index]
                                                              ["status"] ==
                                                          "Alive"
                                                      ? Colors.green
                                                      : result[index]
                                                                  ["status"] ==
                                                              "Dead"
                                                          ? Colors.red
                                                          : null,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                result[index]["status"] +
                                                    " " +
                                                    "-" +
                                                    " " +
                                                    result[index]["species"],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Last known location:",
                                            style: TextStyle(
                                                color: Color(0x8affffff),
                                                fontSize: 18),
                                          ),
                                          Text(
                                            result[index]["location"]["name"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                      // Text(_table[index]["episode"][0].toString().substring(40, 41)),
                                      // Text("$index"),
                                    ],
                                  ),
                          ),
                        ),
                      );
                    }),
              );
            }
            return const Text('No data');
          },
        ),
      ),
    );
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    page++;
    result.addAll(await CharacterRepo().getCharacter(page));
    print('${result.length}');
    if (mounted) {
      setState(() {});
    }
    refresher.loadComplete();
  }
}
