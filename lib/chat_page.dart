import 'package:chatui/message_stream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constant.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatPage extends StatefulWidget {
  static const String id = 'CHATPAGE';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _auth = FirebaseAuth.instance;
  String messageText;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    currentUser();
  }

  Future<void> currentUser() async {
    try {
      FirebaseUser _user = await _auth.currentUser();
      if (_user != null) {
        loggedInUser = _user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Container(
            child: Image.asset("images/logo.png"),
          ),
        ),
        title: Text("Instant Chat"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              _auth.signOut();
              Navigator.popUntil(context, (route) {
                return route.isFirst;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (newValue) {
                        messageText = newValue;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                    color: Colors.blueGrey,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.send,
                    ),
                    onPressed: () {
                      messageController.clear();
                      _firestore.collection("messages").add({
                        "text": messageText,
                        "sender": loggedInUser.email,
                        'timestamp': Timestamp.now(),
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final messageSender;
  final messageText;
  final bool isMe;

  MessageBubble({this.messageSender, this.messageText, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            messageSender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white12.withOpacity(.2),
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(20.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
            color: isMe
                ? Colors.blueGrey.withOpacity(.2)
                : Colors.white.withOpacity(.8),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                "$messageText",
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
