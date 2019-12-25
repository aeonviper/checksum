import 'dart:io';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

Future main(List<String> argumentList) async {
  var file = File(argumentList.single);
  print(file.path);

  var md5output = new AccumulatorSink<Digest>();
  var sha1output = new AccumulatorSink<Digest>();
  var sha256output = new AccumulatorSink<Digest>();
  var sha512output = new AccumulatorSink<Digest>();

  var md5input = md5.startChunkedConversion(md5output);
  var sha1input = sha1.startChunkedConversion(sha1output);
  var sha256input = sha256.startChunkedConversion(sha256output);
  var sha512input = sha512.startChunkedConversion(sha512output);

  var fileAccess = await file.open();
  var bytes = [];

  while ((bytes = await fileAccess.read(10240)).length > 0) {
    md5input.add(bytes);
    sha1input.add(bytes);
    sha256input.add(bytes);
    sha512input.add(bytes);
  }

  md5input.close();
  sha1input.close();
  sha256input.close();
  sha512input.close();

  var md5digest = md5output.events.single;
  var sha1digest = sha1output.events.single;
  var sha256digest = sha256output.events.single;
  var sha512digest = sha512output.events.single;

  print("MD5: " + md5digest.toString());
  print("MD5: " + md5digest.toString().toUpperCase());

  print("SHA1: " + sha1digest.toString());
  print("SHA1: " + sha1digest.toString().toUpperCase());

  print("SHA256: " + sha256digest.toString());
  print("SHA256: " + sha256digest.toString().toUpperCase());

  print("SHA512: " + sha512digest.toString());
  print("SHA512: " + sha512digest.toString().toUpperCase());
}
