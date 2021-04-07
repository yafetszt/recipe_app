import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/model/state.dart';

class StateWidget extends StatefulWidget {
  final StateModel state;
  final Widget child;

  StateWidget({
    @required this.child,
    this.state,
  });

  static _StateWidgetState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_StateDataWidget>() as _StateDataWidget).data;
  }

  @override
  _StateWidgetState createState() => new _StateWidgetState();
}

  class _StateWidgetState extends State<StateWidget> {
    StateModel state;
    GoogleSignInAccount googleAccount;
    final GoogleSignIn googleSignIn = new GoogleSignIn();

    @override
  void initState() {
      super.initState();
      if (widget.state != null) {
        state = widget.state;
      } else {
        state = new StateModel(isLoading: true);
        initUser();
    }
  }

  Future<Null> initUser() async {
    googleAccount = await getSignedInAccount(googleSignIn);

    if (googleAccount == null) {
      setState(() {
        state.isLoading = false;
      });
    } else {
      await signInWithGoogle();
    }
  }

  Future<Null> signInWithGoogle() async {
      if (googleAccount == null) {
        googleAccount = await googleSignIn.signIn();
      }
      FirebaseUser firebaseUser = await signIntoFirebase(googleAccount);
      setState(() {
        state.isLoading = false;
        state.user = firebaseUser;
      });
  }

  @override
  Widget build(BuildContext context) {
      return new _StateDataWidget(
      data: this,
      child: widget.child,
      );
  }
}

  class _StateDataWidget extends InheritedWidget {
    final _StateWidgetState data;

    _StateDataWidget({
      Key key,
      @required Widget child,
      @required this.data,
    }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}

