import 'package:flutter/cupertino.dart';

extension ConnectionStateDone on AsyncSnapshot {
  bool get connectionStateDone {
    return connectionState == ConnectionState.done;
  }
}
