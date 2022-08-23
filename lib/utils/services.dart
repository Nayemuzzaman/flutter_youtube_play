import 'dart:io';

import 'package:flutter_youtube_play/models/channel_info.dart';
import 'package:flutter_youtube_play/models/videos_list.dart';
import 'package:flutter_youtube_play/utils/constants.dart';
import 'package:http/http.dart' as http;

class Services {
  static const CHANNEL_ID = 'UCB1-n4tcx2Gd8e9lz6vajhQ';
  static const _baseUrl = 'youtube.googleapis.com';
  /*
 curl \
  'https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2C%20contentDetails%2C%20statistics&id=UCB1-n4tcx2Gd8e9lz6vajhQ&access_token=AIzaSyDCDFz1V4FHv38sdW4VCl4H66Z04elTJZE&key=[YOUR_API_KEY]' \
  --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  --header 'Accept: application/json' \
  --compressed

 */

  static Future<ChannelInfo> getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': CHANNEL_ID,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    var response = await http.get(uri, headers: headers);
    print('Response body: ${response.body}');
    ChannelInfo channelInfo = channelInfoFromJson(response.body);

    return channelInfo;
  }
    
  static Future<VideosList> getVideosList(
      {String? playListId, String? pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId!,
      'maxResults': '3',
      'pageToken': pageToken!,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    /*
    curl \
  'https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=UUB1-n4tcx2Gd8e9lz6vajhQ&access_token=AIzaSyDCDFz1V4FHv38sdW4VCl4H66Z04elTJZE&key=[YOUR_API_KEY]' \
  --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  --header 'Accept: application/json' \
  --compressed
     */
    var response = await http.get(uri, headers: headers);
    // print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}