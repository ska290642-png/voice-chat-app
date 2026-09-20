import 'package:flutter/material.dart';

void main() {
  runApp(const VoiceChatApp());
}

class VoiceChatApp extends StatelessWidget {
  const VoiceChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Chat',
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
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;

  final pages = const [
    RoomsPage(),
    GamesPage(),
    FamilyPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.mic, color: Colors.amber),
            SizedBox(width: 8),
            Text(
              'Voice Chat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                '🪙 12,580',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: pages[selected],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (value) {
          setState(() => selected = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.mic_none),
            selectedIcon: Icon(Icons.mic),
            label: 'Rooms',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon: Icon(Icons.sports_esports),
            label: 'Games',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups),
            label: 'Family',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  final List<Map<String, String>> rooms = const [
    {'name': 'Music & Chill', 'users': '356', 'emoji': '🎵'},
    {'name': 'Game Zone', 'users': '278', 'emoji': '🎮'},
    {'name': 'Friends Forever', 'users': '199', 'emoji': '👥'},
    {'name': 'Love & Romance', 'users': '142', 'emoji': '❤️'},
    {'name': 'Family Room', 'users': '128', 'emoji': '🏠'},
    {'name': 'Desi Masti', 'users': '96', 'emoji': '🔥'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search room, host or ID...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFF141824),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          '🔥 Live Rooms',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...rooms.map(
          (room) => Card(
            color: const Color(0xFF121622),
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.black,
                child: Text(
                  room['emoji']!,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              title: Text(
                room['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('🎙️ ${room['users']} people'),
              trailing: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VoiceRoomPage(
                        roomName: room['name']!,
                      ),
                    ),
                  );
                },
                child: const Text('JOIN'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class VoiceRoomPage extends StatelessWidget {
  final String roomName;

  const VoiceRoomPage({super.key, required this.roomName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            '👑 HOST',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 45,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 25),
          const Text(
            '🎙️ Voice Room',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 8,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Text('${index + 1}'),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Seat',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _RoomButton(icon: Icons.mic, text: 'Mic'),
              _RoomButton(icon: Icons.card_giftcard, text: 'Gift'),
              _RoomButton(icon: Icons.chat, text: 'Chat'),
              _RoomButton(icon: Icons.exit_to_app, text: 'Exit'),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _RoomButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const _RoomButton({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.amber.withOpacity(.15),
          child: Icon(icon, color: Colors.amber),
        ),
        const SizedBox(height: 5),
        Text(text),
      ],
    );
  }
}

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final games = [
      ['🎱', '8 Ball Pool'],
      ['🃏', 'Teen Patti'],
      ['🎲', 'Ludo'],
      ['🏎️', 'Car Racing'],
      ['🎯', 'Mini Games'],
      ['🧩', 'Puzzle'],
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: games.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (_, index) {
        return Card(
          color: const Color(0xFF151927),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  games[index][0],
                  style: const TextStyle(fontSize: 45),
                ),
                const SizedBox(height: 8),
                Text(
                  games[index][1],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'PLAY',
                  style: TextStyle(color: Colors.amber),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          '👨‍👩‍👧 My Family',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Text('💚'),
            ),
            title: const Text('Green Family'),
            subtitle: const Text('Members: 28 • Rank #3'),
            trailing: FilledButton(
              onPressed: () {},
              child: const Text('OPEN'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          '🏆 Family Ranking',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        for (int i = 1; i <= 5; i++)
          ListTile(
            leading: CircleAvatar(child: Text('$i')),
            title: Text('Family $i'),
            trailing: Text('${6000 - i * 500} pts'),
          ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 15),
        const Center(
          child: CircleAvatar(
            radius: 55,
            child: Icon(Icons.person, size: 65),
          ),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            'My Profile 👑',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 25),
        _ProfileItem(Icons.mic, 'Become a Host'),
        _ProfileItem(Icons.business, 'BD Agency'),
        _ProfileItem(Icons.shield, 'Super Admin'),
        _ProfileItem(Icons.card_giftcard, 'My Gifts'),
        _ProfileItem(Icons.account_balance_wallet, 'My Wallet'),
        _ProfileItem(Icons.emoji_events, 'My Ranking'),
        _ProfileItem(Icons.settings, 'Settings'),
      ],
    );
  }

  Widget _ProfileItem(IconData icon, String title) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
