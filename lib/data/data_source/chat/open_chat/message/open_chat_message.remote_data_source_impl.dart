import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/data/data_source/chat/open_chat/message/open_chat_message.data_source.dart';
import 'package:hot_place/domain/model/chat/open_chat/message/open_chat_message.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/error/custom_exception.dart';
import '../../../../../core/error/failure.constant.dart';

class RemoteOpenChatMessageDataSourceImpl
    implements RemoteOpenChatMessageDataSource {
  final SupabaseClient _client;

  RemoteOpenChatMessageDataSourceImpl(this._client);

  final _logger = Logger();

  @override
  Future<String> createChatMessage(OpenChatMessageModel chat) async {
    try {
      return await _client.rest
          .from(TableName.openChatMessage.name)
          .insert(chat.toJson())
          .select()
          .limit(1)
          .then((fetched) => OpenChatMessageModel.fromJson(fetched.first).id);
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.toString());
    }
  }

  @override
  Future<String> deleteChatMessageById(String messageId) async {
    try {
      return await _client.rest
          .from(TableName.openChatMessage.name)
          .delete()
          .eq('id', messageId)
          .then((_) => messageId);
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.toString());
    }
  }

  @override
  Stream<List<OpenChatMessageModel>> getChatMessageStream(String chatId) {
    return _client
        .from(TableName.openChatMessage.name)
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .asyncMap(
            (data) async => data.map(OpenChatMessageModel.fromJson).toList());
  }
}
