import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constant/dto.constant.dart';
import 'package:my_app/data/entity/chat/chat_message/private_chat_message.entity.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/usecase/module/chat/private_chat_message.usecase.dart';
import 'send_private_chat_message.state.dart';

class SendPrivateChatMessageCubit extends Cubit<SendPrivateChatMessageState> {
  final PrivateChatMessageUseCase _useCase;

  SendPrivateChatMessageCubit(this._useCase)
      : super(const SendPrivateChatMessageState());

  send(
      {required String senderUid,
      required String receiverUid,
      required String content,
      ChatMessageType type = ChatMessageType.text}) async {
    await _useCase.sendMessage(PrivateChatMessageEntity(
      sender: AccountEntity(),
      receiver: AccountEntity(),
      content: content,
      type: type,
    ));
  }
}
