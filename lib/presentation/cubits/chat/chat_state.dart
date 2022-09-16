part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class Loading extends ChatState {}

class Loaded extends ChatState {
  final List<ChatEntity> chats;
  const Loaded({
    required this.chats,
  });
}

class Empty extends ChatState {}
