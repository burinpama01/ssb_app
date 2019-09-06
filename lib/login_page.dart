import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ssb_app/Home_page_test.dart';
import 'package:ssb_app/home_page.dart';
import 'ProfileScreen.dart';

class GoogleSignApp extends StatefulWidget {
  @override
  _GoogleSignAppState createState() => _GoogleSignAppState();
}

class _GoogleSignAppState extends State<GoogleSignApp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
    ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails =
        await _firebaseAuth.signInWithCredential(credential);
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ProfileScreen(detailsUser: details),
      ),
    );
    return userDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // child: Image.network(
              //     'https://i.pinimg.com/originals/4e/5a/44/4e5a4406c184c2f20a0bc223c08e9a96.jpg',
              //     fit: BoxFit.fill,
              //     color: Color.fromRGBO(255, 255, 255, 0.6),
              //     colorBlendMode: BlendMode.modulate),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    width: 300.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: SizedBox(
                            width: 200.0,
                            height: 200.0,
                            child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 48.0,
                                child: SizedBox(
                                  width: 100.0,
                                  height: 100.0,
                                  child: Image.asset(
                                    'images/front-bus.png',
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: TextField(
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              labelText: 'Username',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: TextField(
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              labelText: 'Password',
                              prefixIcon: const Icon(
                                Icons.vpn_key,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 500.0,
                            height: 50.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Color(0xff343F4B),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  )
                                ],
                              ),
                              onPressed: () => _signIn(context)
                                  .then((FirebaseUser user) => print(user))
                                  .catchError((e) => print(e)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text('Forgot Password ?'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 500.0,
                              height: 50.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Color(0xffffffff),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.google,
                                      color: Color(0xffCE107C),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18.0),
                                    )
                                  ],
                                ),
                                onPressed: () => _signIn(context)
                                    .then((FirebaseUser user) => print(user))
                                    .catchError((e) => print(e)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: FlatButton(
                            child: Text(
                              'Create Account',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePageTest(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;
  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}
