import 'package:flutter/material.dart';

void main() => runApp(const VoiceChatApp());

class VoiceChatApp extends StatelessWidget {
  const VoiceChatApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Voice Chat App',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF080A12),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  final pages = const [RoomsPage(), GamesPage(), FamilyPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.mic, color: Colors.amber),
              SizedBox(width: 8),
              Text('Voice Chat App', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => _showMessage(context, 'Notifications are not connected.'),
              icon: const Icon(Icons.notifications_none),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Center(
                child: Text('🪙 Demo coins', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        body: pages[selected],
        bottomNavigationBar: NavigationBar(
          selectedIndex: selected,
          onDestinationSelected: (value) => setState(() => selected = value),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.mic_none), selectedIcon: Icon(Icons.mic), label: 'Rooms'),
            NavigationDestination(icon: Icon(Icons.sports_esports_outlined), selectedIcon: Icon(Icons.sports_esports), label: 'Games'),
            NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups), label: 'Family'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      );
}

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  static const rooms = [
    {'name': 'Music & Chill', 'users': 'Demo', 'emoji': '🎵'},
    {'name': 'Game Zone', 'users': 'Demo', 'emoji': '🎮'},
    {'name': 'Friends Forever', 'users': 'Demo', 'emoji': '👥'},
    {'name': 'Love & Romance', 'users': 'Demo', 'emoji': '❤️'},
    {'name': 'Family Room', 'users': 'Demo', 'emoji': '🏠'},
    {'name': 'Desi Masti', 'users': 'Demo', 'emoji': '🔥'},
  ];

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search room, host or ID...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFF141824),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 20),
          const Text('🔥 Voice Rooms', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...rooms.map((room) => Card(
                color: const Color(0xFF121622),
                child: ListTile(
                  leading: CircleAvatar(radius: 28, backgroundColor: Colors.black, child: Text(room['emoji']!, style: const TextStyle(fontSize: 25))),
                  title: Text(room['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('🎙️ ${room['users']} room data'),
                  trailing: FilledButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VoiceRoomPage(roomName: room['name']!))),
                    child: const Text('OPEN'),
                  ),
                ),
              )),
        ],
      );
}

class VoiceRoomPage extends StatefulWidget {
  final String roomName;

  const VoiceRoomPage({super.key, required this.roomName});

  @override
  State<VoiceRoomPage> createState() => _VoiceRoomPageState();
}

class _VoiceRoomPageState extends State<VoiceRoomPage> {
  final seats = List<String?>.filled(8, null);
  bool muted = false;
  bool speakerOn = true;

  void toggleSeat(int index) {
    setState(() => seats[index] = seats[index] == null ? 'You' : null);
    _showMessage(context, seats[index] == null ? 'You left seat ${index + 1}.' : 'You joined seat ${index + 1}.');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.roomName),
          actions: [
            IconButton(onPressed: () => _showMessage(context, 'Sharing is unavailable until a backend is connected.'), icon: const Icon(Icons.share)),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Text('👑 HOST', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 25),
            const Text('🎙️ Voice Room', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('UI controls only. Real-time voice is not connected.', style: TextStyle(color: Colors.white60, fontSize: 12)),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 20, crossAxisSpacing: 12),
                itemBuilder: (_, index) => InkWell(
                  onTap: () => toggleSeat(index),
                  borderRadius: BorderRadius.circular(40),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: seats[index] == null ? Colors.grey.shade800 : Colors.amber,
                        child: seats[index] == null ? Text('${index + 1}') : const Icon(Icons.person),
                      ),
                      const SizedBox(height: 5),
                      Text(seats[index] ?? 'Seat', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  _RoomButton(icon: muted ? Icons.mic_off : Icons.mic, text: muted ? 'Unmute' : 'Mute', onTap: () => setState(() => muted = !muted)),
                  _RoomButton(icon: speakerOn ? Icons.volume_up : Icons.volume_off, text: speakerOn ? 'Speaker' : 'Silent', onTap: () => setState(() => speakerOn = !speakerOn)),
                  _RoomButton(icon: Icons.card_giftcard, text: 'Gifts', onTap: () => _showMessage(context, 'Gifts are demo-only.')),
                  _RoomButton(icon: Icons.chat, text: 'Chat', onTap: () => _showMessage(context, 'Chat is not connected.')),
                  _RoomButton(icon: Icons.exit_to_app, text: 'Exit', onTap: () => Navigator.pop(context)),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
}

class _RoomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _RoomButton({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: [
              CircleAvatar(radius: 25, backgroundColor: Colors.amber.withOpacity(.15), child: Icon(icon, color: Colors.amber)),
              const SizedBox(height: 5),
              Text(text, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
      );
}

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});
  static const games = ['8 Ball Pool', 'Teen Patti', 'Ludo', 'Car Racing', 'Mini Games', 'Puzzle'];
  static const emojis = ['🎱', '🃏', '🎲', '🏎️', '🎯', '🧩'];

  @override
  Widget build(BuildContext context) => GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: games.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
        itemBuilder: (_, index) => InkWell(
          onTap: () => _showMessage(context, '${games[index]} is demo UI; no game backend is connected.'),
          borderRadius: BorderRadius.circular(12),
          child: Card(
            color: const Color(0xFF151927),
            child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(emojis[index], style: const TextStyle(fontSize: 45)), const SizedBox(height: 8), Text(games[index], style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 8), const Text('PLAY', style: TextStyle(color: Colors.amber))])),
          ),
        ),
      );
}

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('👨‍👩‍👧 My Family', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Card(child: ListTile(leading: const CircleAvatar(child: Text('💚')), title: const Text('Green Family'), subtitle: const Text('Demo members • Demo rank'), trailing: FilledButton(onPressed: () => _showMessage(context, 'Family details are demo-only.'), child: const Text('OPEN')))),
          const SizedBox(height: 20),
          const Text('🏆 Family Ranking', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          for (int i = 1; i <= 5; i++) InkWell(onTap: () => _showMessage(context, 'Family $i is demo data.'), child: ListTile(leading: CircleAvatar(child: Text('$i')), title: Text('Family $i'), trailing: const Text('Demo points'))),
        ],
      );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const items = <Map<String, Object>>[
    {'icon': Icons.mic, 'title': 'Become a Host'},
    {'icon': Icons.business, 'title': 'BD Agency'},
    {'icon': Icons.shield, 'title': 'Super Admin'},
    {'icon': Icons.card_giftcard, 'title': 'My Gifts'},
    {'icon': Icons.account_balance_wallet, 'title': 'My Wallet'},
    {'icon': Icons.emoji_events, 'title': 'My Ranking'},
    {'icon': Icons.settings, 'title': 'Settings'},
  ];

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 15),
          const Center(child: CircleAvatar(radius: 55, child: Icon(Icons.person, size: 65))),
          const SizedBox(height: 12),
          const Center(child: Text('My Profile 👑', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          const SizedBox(height: 25),
          ...items.map((item) => Card(child: ListTile(leading: Icon(item['icon']! as IconData, color: Colors.amber), title: Text(item['title']! as String), trailing: const Icon(Icons.chevron_right), onTap: () => _showMessage(context, '${item['title']} is demo UI.')))),
        ],
      );
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(message)));
}
