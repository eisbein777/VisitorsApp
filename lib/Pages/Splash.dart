import 'package:flutter/material.dart';
import 'package:fitzroy_visitors/Pages/SignIn.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //  appBar: new AppBar(
      //   title: new Text("Box Decoration and Stack example"),
      //  ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      // margin: const EdgeInsets.all(5),
      //padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
          border: new Border.all(
        color: Color(0xFF00888A), //Color(0xFF05827E)
        width: 15,
      )),
      child: new Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Welcome to",
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Container(
            constraints: new BoxConstraints.expand(
              height: 500.0,
              width: 600.0,
            ),
            alignment: Alignment.center,
            padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/DFLogo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                    buttonColor: Color(0xFF00888A),
                    child: RaisedButton(
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SigninForm()),
                        );
                      },
                    )),
//                Spacer(),
                ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                    buttonColor: Color(0xFF00888A),
                    child: RaisedButton(
                      child: Text(
                        'Sign Out',
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SigninForm()),
                        );
                      },
                    )),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
