// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice/Models/UserModel.dart';
import 'package:practice/Screens/Chat/ChatPage.dart';
import 'package:practice/Services/authentication.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    final UserModel? _userModel = Provider.of<UserModel?>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: RichText(
              text: TextSpan(
                  text: 'Welcome ',
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                TextSpan(
                    text: _userModel!.name.toString(),
                    style: TextStyle(color: Colors.white))
              ])),
          actions: [
            IconButton(
                onPressed: () async {
                  await _authentication.signOut();
                },
                icon: Icon(Icons.logout))
          ]),
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              ListItem(
                channelName: 'Native-Android',
                channelImage: 'assets/android.svg',
                channelDescription:
                    'Modern tools and resources to help you build experiences that people love, faster and easier, across every Android device.',
              ),
              ListItem(
                channelName: 'Flutter',
                channelImage: 'assets/flutter.svg',
                channelDescription: 'Build apps for any screen',
              ),
              ListItem(
                channelName: 'React',
                channelImage: 'assets/react.svg',
                channelDescription: 'Learn once, write anywhere.',
              ),
              ListItem(
                  channelName: 'Native-ios',
                  channelImage: 'assets/swift.svg',
                  channelDescription: 'Learn to code with Swift'),
              ListItem(
                  channelName: 'Web',
                  channelImage: 'assets/web.svg',
                  channelDescription: 'HTML-CSS-JS'),
              ListItem(
                  channelName: 'Firebase',
                  channelImage: 'assets/firebase.svg',
                  channelDescription:
                      'Backed by Google and loved by app development teams - from startups to global enterprises'),
              ListItem(
                  channelName: 'Azure DevOps',
                  channelImage: 'assets/azure.svg',
                  channelDescription:
                      'Plan smarter, collaborate better, and ship faster with a set of modern dev services.'),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  final String channelName;
  final String channelDescription;
  final String channelImage;
  const ListItem(
      {Key? key,
      required this.channelImage,
      required this.channelName,
      required this.channelDescription})
      : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: InkWell(
        onTap: (() {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: ((context) => ChatPage(
                        channelName: widget.channelName,
                        channelImage: widget.channelImage,
                      ))));
        }),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.grey[700],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  widget.channelImage,
                  width: 60,
                  height: 60,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.channelName.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.0,
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        //width: 250.0,
                        child: Text(
                          widget.channelDescription.toString(),
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.ltr,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textWidthBasis: TextWidthBasis.longestLine,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.yellow[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
