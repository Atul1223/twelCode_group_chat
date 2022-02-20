// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice/Models/UserModel.dart';
import 'package:practice/Services/MessageService.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String channelName;
  final String channelImage;
  const ChatPage(
      {Key? key, required this.channelName, required this.channelImage})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _message = "";
  final FirebaseMessages firebaseMessages = FirebaseMessages();
  late final Stream<QuerySnapshot> _messageStream;
  final ScrollController _scrollController = ScrollController();

  Widget messageList(String uid) {
    return StreamBuilder<QuerySnapshot>(
        stream: _messageStream,
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
                controller: _scrollController.jumpTo(snapshot.data?.size),
                itemCount: snapshot.data?.size,
                itemBuilder: ((context, index) {
                  if (snapshot.data?.docs[index].get('uid').toString() == uid) {
                    return _chatBubble(
                        context,
                        true,
                        snapshot.data?.docs[index].get('message'),
                        snapshot.data?.docs[index].get('sendBy'));
                  } else {
                    return _chatBubble(
                        context,
                        false,
                        snapshot.data?.docs[index].get('message'),
                        snapshot.data?.docs[index].get('sendBy'));
                  }
                }));
          } else if (snapshot.hasData) {
            return Container(
              color: Colors.grey[850],
              child: Center(
                  child: Text('Loading',
                      style: TextStyle(color: Colors.white, fontSize: 30))),
            );
          } else {
            return Container(
              color: Colors.grey[850],
              child: Center(
                  child: Text(
                'Not able to load Messages',
                style: TextStyle(color: Colors.white, fontSize: 30),
              )),
            );
          }
        }));
  }

  @override
  void initState() {
    super.initState();

    _messageStream =
        firebaseMessages.getConversationMessages(widget.channelName);
  }

  final TextEditingController textEditingController = TextEditingController();
  senMessage(String message, String sendBy, String roomId, String uid) {
    if (message.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "sendBy": sendBy,
        "message": message,
        "uid": uid,
        "time": DateTime.now().toUtc()
      };

      firebaseMessages.sendConversationMessages(roomId, messageMap);
    }
  }

  _chatBubble(
      BuildContext context, bool isSender, String Message, String UserName) {
    if (isSender == true) {
      return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  UserName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Message,
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                    ),
                  ),
                ),
              ]));
    } else {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                UserName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Message,
                      style: TextStyle(fontSize: 14),
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ),
                ),
              )
            ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? _userModel = Provider.of<UserModel?>(context);

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        elevation: 0,
        //leading: Icon(Icons.abc),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            widget.channelImage,
            height: 10,
            width: 10,
          ),
        ),
        title: Text(
          widget.channelName,
          style: TextStyle(fontSize: 18, letterSpacing: 1),
        ),
        titleSpacing: 2,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messageList(_userModel!.uid.toString()),
            ),
            Container(
              color: Colors.grey[700],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 3.0, 15.0, 10.0),
                child: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 150,
                            minHeight: 40,
                          ),
                          child: Form(
                            child: TextFormField(
                              controller: textEditingController,
                              initialValue: null,
                              maxLines: null,
                              keyboardType: TextInputType.text,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                              cursorColor: Colors.greenAccent,
                              decoration: InputDecoration(
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: 'Message',
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 24),
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _message = value.toString();
                                });
                              },
                              onChanged: (String value) {
                                setState(() {
                                  _message = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          alignment: Alignment.bottomRight,
                          onPressed: () {
                            senMessage(_message, _userModel.name.toString(),
                                widget.channelName, _userModel.uid.toString());
                            textEditingController.clear();
                          },
                          icon: Icon(
                            Icons.send,
                            size: 30,
                            color: Colors.greenAccent,
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
