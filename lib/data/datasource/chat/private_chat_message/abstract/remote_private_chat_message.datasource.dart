part of '../impl/remote_private_chat_message.datasource_impl.dart';

abstract interface class RemotePrivateChatMessageDataSource
    implements PrivateChatMessageDataSource<PrivateChatMessageModel> {
  @override
  Future<void> saveChatMessage(PrivateChatMessageModel model);
}
