// import 'dart:async';
// import 'dart:convert';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class DiscordGatewayClient {
//   final String botToken;
//   WebSocketChannel? _channel;
//   Timer? _heartbeatTimer;
//   int? _heartbeatInterval;
//   int? _lastSequence;

//   DiscordGatewayClient(this.botToken);

//   void connect() {
//     _channel = WebSocketChannel.connect(Uri.parse('wss://gateway.discord.gg/?v=10&encoding=json'));

//     _channel!.stream.listen(
//       (event) {
//         final payload = jsonDecode(event);
//         final op = payload['op'];
//         final s = payload['s'];
//         final t = payload['t'];
//         final d = payload['d'];

//         if (s != null) {
//           _lastSequence = s;
//         }

//         switch (op) {
//           case 10: // Hello
//             _startHeartbeat(d['heartbeat_interval']);
//             _identify();
//             break;
//           case 0: // Dispatch
//             _handleDispatch(t, d);
//             break;
//           case 11: // Heartbeat ACK
//             print("✅ Heartbeat ACK received");
//             break;
//           default:
//             break;
//         }
//       },
//       onDone: () {
//         print("🔌 Gateway disconnected.");
//         _heartbeatTimer?.cancel();
//       },
//       onError: (error) {
//         print("❌ WebSocket error: $error");
//         _heartbeatTimer?.cancel();
//       },
//     );
//   }

//   void _startHeartbeat(int intervalMs) {
//     _heartbeatInterval = intervalMs;
//     _heartbeatTimer = Timer.periodic(Duration(milliseconds: intervalMs), (_) {
//       final payload = {
//         'op': 1,
//         'd': _lastSequence,
//       };
//       _channel?.sink.add(jsonEncode(payload));
//       print("💓 Heartbeat sent");
//     });
//   }

//   void _identify() {
//     final payload = {
//       'op': 2,
//       'd': {
//         'token': botToken,
//         'intents': 513, // 512 (GUILD_MESSAGES) + 1 (GUILDS)
//         'properties': {
//           'os': 'flutter',
//           'browser': 'flutter',
//           'device': 'flutter'
//         }
//       }
//     };
//     _channel?.sink.add(jsonEncode(payload));
//     print("📨 IDENTIFY sent");
//   }

//   void _handleDispatch(String? type, dynamic data) {
//     if (type == 'MESSAGE_CREATE') {
//       final author = data['author']['username'];
//       final content = data['content'];
//       final channelId = data['channel_id'];

//       print("💬 [$channelId] $author: $content");
//     }
//   }

//   void close() {
//     _heartbeatTimer?.cancel();
//     _channel?.sink.close();
//   }
// }
