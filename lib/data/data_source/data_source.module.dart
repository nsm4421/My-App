import 'package:hot_place/data/data_source/auth/auth.data_source.dart';
import 'package:hot_place/data/data_source/auth/auth.remote_data_source.dart';
import 'package:hot_place/data/data_source/chat/message/chat_message.remote_data_source.dart';
import 'package:hot_place/data/data_source/chat/open_chat/open_chat.data_source.dart';
import 'package:hot_place/data/data_source/chat/open_chat/open_chat.remote_data_source.dart';
import 'package:hot_place/data/data_source/feed/feed.data_source.dart';
import 'package:hot_place/data/data_source/feed/feed.remote_data_source.dart';
import 'package:hot_place/data/data_source/feed/like/like_feed.data_source.dart';
import 'package:hot_place/data/data_source/feed/like/like_feed.remote_data_source.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/data_source/user/user.remote_data_source.dart';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chat/message/chat_message.data_source.dart';

@module
abstract class DataSource {
  final _client = Supabase.instance.client;

  @singleton
  AuthDataSource get authDataSource => RemoteAuthDataSource(_client);

  @singleton
  UserDataSource get userDataSource => RemoteUserDataSource(_client);

  @singleton
  FeedDataSource get feedDataSource => RemoteFeedDataSource(_client);

  @singleton
  LikeFeedDataSource get likeFeedDataSource =>
      RemoteLikeFeedDataSource(_client);

  @singleton
  OpenChatDataSource get chatDataSource => RemoteOpenChatDataSource(_client);

  @singleton
  ChatMessageDataSource get chatMessageDataSource =>
      RemoteChatMessageDataSource(_client);
}
