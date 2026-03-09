import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/profile/data/profile_storage.dart';
import 'package:imdumb/features/profile/presentation/screens/favorites_screen.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String? _displayName;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final name = await ProfileStorage.getDisplayName();
    if (mounted) setState(() => _displayName = name);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: Colors.white.withValues(alpha: 0.15),
              child: Icon(
                Icons.person,
                size: 48,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              _displayName ?? '...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Tu perfil',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 40),
          _ProfileTile(
            icon: Icons.favorite_border,
            title: 'Favoritos',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              );
            },
          ),
          _ProfileTile(
            icon: Icons.settings_outlined,
            title: 'Ajustes',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.white70, size: 24),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.white.withValues(alpha: 0.5),
      ),
    );
  }
}
