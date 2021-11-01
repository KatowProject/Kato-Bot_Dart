// ignore: library_prefixes
import 'package:nyxx/nyxx.dart' show Nyxx, GatewayIntents, MessageBuilder;
import 'package:dotenv/dotenv.dart' show load, env;

void main() {
  load();
  final client = Nyxx(env['token'] as String, GatewayIntents.allUnprivileged)
    ..onReady.listen((message) {
      print('Ready!');
    })
    ..onMessageReceived.listen((event) {
      final message = event.message;
      final prefix = env['prefix'] as String;

      if (!message.content.startsWith(prefix)) return;
      final command = message.content.substring(prefix.length);
      final args = command.split(' ');
      final commandName = args.first.toLowerCase();

      switch (commandName) {
        case 'ping':
          message.channel.sendMessage(MessageBuilder.content('Pong!'));
          break;

        case 'say':
          if (args.length < 2) {
            message.channel.sendMessage(MessageBuilder.content('Say what?'));
            return;
          }
          message.channel
              .sendMessage(MessageBuilder.content(args.skip(1).join(' ')));
          break;
      }
    });
}
