import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.constant.dart';
import '../../../repository/chat/chat_message.repository.dart';

@lazySingleton
class DeleteChatMessageUseCase {
  final ChatMessageRepository _repository;

  DeleteChatMessageUseCase(this._repository);

  Future<Either<Failure, String>> call(String messageId) async {
    return _repository.deleteChatMessageById(messageId);
  }
}
