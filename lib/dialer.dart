import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:suvidha_caller/app_colors.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

String contact = '';
TextEditingController _controller = new TextEditingController();

class Dialer extends StatefulWidget {
  const Dialer({Key key}) : super(key: key);

  @override
  _DialerState createState() => _DialerState();
}

class _DialerState extends State<Dialer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                color: kPrimaryColor.withOpacity(0.3),
                offset: Offset(0, -6),
                blurRadius: 10)
          ]),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: TextField(
                      enabled: false,
                      controller: _controller,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Moshi Moshi'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      contact = '';
                      _controller.text = contact;
                    });
                  },
                  child: Icon(Icons.backspace_outlined),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DialerButton(
                text: "1",
              ),
              DialerButton(
                text: "2",
              ),
              DialerButton(
                text: "3",
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DialerButton(
                text: "4",
              ),
              DialerButton(
                text: "5",
              ),
              DialerButton(
                text: "6",
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DialerButton(
                text: "7",
              ),
              DialerButton(
                text: "8",
              ),
              DialerButton(
                text: "9",
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DialerButton(
                text: "*",
              ),
              DialerButton(
                text: "0",
              ),
              DialerButton(
                text: "#",
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DialerButtonCall(
                icon: Icons.call,
              )
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class DialerButton extends StatefulWidget {
  DialerButton({
    Key key,
    this.onTap,
    this.text,
  }) : super(key: key);

  final Function onTap;
  final String text;
  bool _isPressed = false;

  @override
  _DialerButtonState createState() => _DialerButtonState();
}

class _DialerButtonState extends State<DialerButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails tapDownDetails) {
        setState(() {
          widget._isPressed = true;
        });
      },
      onTapUp: (TapUpDetails tapUpDetails) {
        setState(() {
          widget._isPressed = false;
        });
      },
      onTap: () {
        contact = contact + widget.text;
        _controller.text = contact;
        _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length));
        setState(() {});
      },
      child: Container(
        height: 64,
        width: 64,
        child: Center(
          child: Text(
            '${widget.text}',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6)),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          //color: kPrimaryColor,
          gradient: LinearGradient(
              begin: (widget._isPressed)
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              end: (!widget._isPressed)
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              colors: [kPrimaryColor, kBoxShadowTop]),
          boxShadow: [
            BoxShadow(
                color: kBoxShadowTop, blurRadius: 10, offset: Offset(-6, -2)),
            BoxShadow(
                color: kBoxShadowBottom, blurRadius: 10, offset: Offset(6, 2)),
          ],
        ),
      ),
    );
  }
}

class DialerButtonCall extends StatefulWidget {
  DialerButtonCall({
    Key key,
    this.onTap,
    this.icon,
  }) : super(key: key);

  final Function onTap;
  final IconData icon;
  bool _isPressed = false;

  @override
  _DialerButtonCallState createState() => _DialerButtonCallState();
}

class _DialerButtonCallState extends State<DialerButtonCall> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails tapDownDetails) {
        setState(() {
          widget._isPressed = true;
        });
      },
      onTapUp: (TapUpDetails tapUpDetails) {
        setState(() {
          widget._isPressed = false;
        });
      },
      onTap: () async {
        if (contact == '') {
          Alert(
              context: context,
              title: "Oh My!!",
              desc: "Do you forgot the number",
              buttons: [
                DialogButton(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.deepPurpleAccent, Colors.purpleAccent]),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        } else
          bool res = await FlutterPhoneDirectCaller.callNumber(contact);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: Icon(
          widget.icon,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
              begin: (widget._isPressed)
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              end: (!widget._isPressed)
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              colors: [Colors.deepPurpleAccent, Colors.purpleAccent]),
          boxShadow: [
            BoxShadow(
                color: kBoxShadowTop, blurRadius: 10, offset: Offset(-6, -2)),
            BoxShadow(
                color: kBoxShadowBottom, blurRadius: 10, offset: Offset(6, 2)),
          ],
        ),
      ),
    );
  }
}
