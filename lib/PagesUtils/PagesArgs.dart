import 'package:mobile_wash_control/CommonElements.dart';

class PostMenuArgs {
  final int postID;
  final String ip;
  final String hash;
  final int currentProgramID;
  final SessionData sessionData;

  PostMenuArgs(
      this.postID, this.ip, this.hash, this.currentProgramID, this.sessionData);
}