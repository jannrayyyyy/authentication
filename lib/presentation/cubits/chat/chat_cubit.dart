import 'package:authentication/domain/entity/chatentity.dart';
import 'package:authentication/domain/usecase/fetchchats.dart';
import 'package:authentication/domain/usecase/sendmessage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._sendChat, this._fetchChats) : super(ChatInitial());

  final SendChat _sendChat;
  final FetchChats _fetchChats;

  void message(
    String msg,
    String chatUid,
    String userId,
    String friendNumber,
  ) async {
    await _sendChat(
      msg,
      chatUid,
      userId,
      friendNumber,
    );
  }

  void fetchchats(String uid) async {
    emit(Loading());
    final chatStream = _fetchChats(uid);
    chatStream.listen((chats) {
      if (chats.isEmpty) {
        emit(Loading());
        emit(Empty());
      } else {
        emit(Loading());
        emit(Loaded(chats: chats));
      }
    });
  }
}
