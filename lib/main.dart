import 'package:flutter/material.dart';

void main() {
  runApp(const VocabloomApp());
}

class VocabloomApp extends StatelessWidget {
  const VocabloomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabloom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF22C55E), // greenAccent
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF22C55E),
          secondary: Color(0xFFF59E0B), // amberAccent
          tertiary: Color(0xFFEC4899), // pinkAccent
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}

// --- 1. ONBOARDING SCREEN ---
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String selectedLevel = 'A1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🌸 VOCABLOOM', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF22C55E))),
              const SizedBox(height: 8),
              const Text('New York City • Learning Adventure Map', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
              const SizedBox(height: 32),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Your Age (18+ for AI Companion)',
                  labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_nameController.text.isEmpty || _ageController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields!')),
                    );
                    return;
                  }
                  int age = int.tryParse(_ageController.text) ?? 0;
                  bool isAdult = age >= 18;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainHomeScreen(userName: _nameController.text, isAdult: isAdult),
                    ),
                  );
                },
                child: const Text('Start Adventure 🦖', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- MAIN HOME HUB (17 FEATURES HUB) ---
class MainHomeScreen extends StatefulWidget {
  final String userName;
  final bool isAdult;

  const MainHomeScreen({Key? key, required this.userName, required this.isAdult}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeHubView(userName: widget.userName),
      const GardenView(),
      const GrammarLabView(),
      EnglishChatView(isAdult: widget.isAdult),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: const Color(0xFF22C55E),
        unselectedItemColor: const Color(0xFF94A3B8),
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Hub'),
          BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: 'Garden'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Grammar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }
}

// --- 1. HUB VIEW (NYC Map & Stats) ---
class HomeHubView extends StatelessWidget {
  final String userName;
  const HomeHubView({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('🌸 Vocabloom', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF22C55E))),
                Row(
                  children: const [
                    Text('🔥 47', style: TextStyle(color: Color(0xFFF59E0B), fontWeight: FontWeight.bold)),
                    SizedBox(width: 12),
                    Text('💎 1240', style: TextStyle(color: Color(0xFF38BDF8), fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF22C55E), width: 1.5),
              ),
              child: Row(
                children: [
                  const Text('🦖', style: TextStyle(fontSize: 50)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome back, $userName!', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 4),
                        const Text('Ready to grow your words today?', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('🗺️ NYC Adventure Map', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?q=80&w=600'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
              child: const Center(
                child: Text('Times Square ➔ Central Park ➔ Brooklyn Bridge', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. GARDEN OF WORDS (Сад Слов) ---
class GardenView extends StatelessWidget {
  const GardenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🌱 Your Garden', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF22C55E))),
            const Text('Water your word plants to help them grow!', style: TextStyle(color: Color(0xFF94A3B8))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                FlowerCard(word: 'APPLE', type: 'RARE', color: Colors.blue, health: '85%'),
                FlowerCard(word: 'BOOK', type: 'COMMON', color: Colors.green, health: '60%'),
                FlowerCard(word: 'LOVE', type: 'LEGENDARY', color: Colors.amber, health: '100%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FlowerCard extends StatelessWidget {
  final String word;
  final String type;
  final Color color;
  final String health;

  const FlowerCard({Key? key, required this.word, required this.type, required this.color, required this.health}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(Icons.local_florist, color: color, size: 36),
          const SizedBox(height: 8),
          Text(word, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Text(type, style: TextStyle(fontSize: 10, color: color)),
          const SizedBox(height: 4),
          Text(health, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
        ],
      ),
    );
  }
}

// --- 3. GRAMMAR LAB (12 Levels) ---
class GrammarLabView extends StatelessWidget {
  const GrammarLabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('📚 Grammar Lab', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF22C55E))),
            const Text('12 Levels • Master Grammar via Memes', style: TextStyle(color: Color(0xFF94A3B8))),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  GrammarTile(level: 'Level 1', title: 'Present Simple', status: 'Completed 🟢'),
                  GrammarTile(level: 'Level 2', title: 'Past Simple', status: 'Completed 🟢'),
                  GrammarTile(level: 'Level 3', title: 'Adjectives', status: 'CURRENT 🔥'),
                  GrammarTile(level: 'Level 4', title: 'Adverbs', status: 'Locked 🔒'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GrammarTile extends StatelessWidget {
  final String level;
  final String title;
  final String status;

  const GrammarTile({Key? key, required this.level, required this.title, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(level, style: const TextStyle(color: Color(0xFF22C55E), fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(status, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
        ],
      ),
    );
  }
}

// --- 4. ENGLISH-ONLY CHAT (Cyrillic Block Logic) ---
class EnglishChatView extends StatefulWidget {
  final bool isAdult;
  const EnglishChatView({Key? key, required this.isAdult}) : super(key: key);

  @override
  State<EnglishChatView> createState() => _EnglishChatViewState();
}

class _EnglishChatViewState extends State<EnglishChatView> {
  final TextEditingController _chatController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {'sender': 'Dino', 'text': 'Welcome to Vocabloom! Keep chatting in English.', 'status': 'info'}
  ];

  // Кириллицаны анықтайтын regex (орыс/қазақ әріптерін бұғаттау)
  bool hasCyrillic(String text) {
    return RegExp(r'[а-яА-ЯёЁіІғҒқҚңҢөӨұҰүҮһҺәӘ]').hasMatch(text);
  }

  void sendMessage() {
    String text = _chatController.text.trim();
    if (text.isEmpty) return;

    if (hasCyrillic(text)) {
      setState(() {
        messages.add({'sender': 'You', 'text': text, 'status': 'blocked'});
      });
    } else {
      setState(() {
        messages.add({'sender': 'You', 'text': text, 'status': 'approved'});
      });
    }
    _chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1E293B),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('💬 English-Only Chat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                if (widget.isAdult)
                  const Text('18+ AI 🔓', style: TextStyle(color: Color(0xFFEC4899), fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var msg = messages[index];
                bool isBlocked = msg['status'] == 'blocked';
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isBlocked ? const Color(0xFF7F1D1D) : const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(msg['sender'], style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                      const SizedBox(height: 4),
                      Text(msg['text'], style: const TextStyle(color: Colors.white, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(
                        isBlocked ? '❌ Only English!' : '✅ Approved • +5 XP',
                        style: TextStyle(fontSize: 10, color: isBlocked ? Colors.redAccent : const Color(0xFF22C55E)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1E293B),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type in English only...',
                      hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF22C55E)),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
