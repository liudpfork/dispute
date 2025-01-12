import 'package:dispute/model/profile.dart';
import 'package:dispute/screen/event.dart';
import 'package:dispute/screen/profil.dart';
import 'package:dispute/widget/the_wall.dart';
import 'package:dispute/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String projectUrl = 'RemotAI';
    final profil = context.watch<Profile>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('nostr Test RemotAI'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(),
            const Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 25, left: 10, right: 10),
              child: SelectableText(
                'A Demo Test Nostr By RemotAI',
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 25,
                left: 10,
                right: 10,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBackgroundColor,
                  minimumSize: const Size(400, 40),
                  maximumSize: const Size(400, 40),
                ),
                onPressed: () {},
                child: InkWell(
                  child: Text(projectUrl),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: projectUrl));
                    displaySnackBar(
                        context, 'copied to clipboard: $projectUrl');
                  },
                ),
              ),
            ),
            TheWallWidget(
              channel: WebSocketChannel.connect(Uri.parse(profil.relay)),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: buttonBorderColor, width: 3),
                borderRadius: BorderRadius.circular(100)),
            tooltip: 'Send an event',
            heroTag: "send_event",
            child: const Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: buttonBorderColor, width: 3),
                borderRadius: BorderRadius.circular(100)),
            tooltip: 'Edit your profil',
            heroTag: "profil",
            child: const Icon(Icons.vpn_key),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
