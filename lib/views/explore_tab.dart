import 'package:flutter/cupertino.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Photos & Camera',
      'category': 'Media',
      'icon': CupertinoIcons.photo_on_rectangle,
      'color': CupertinoColors.systemPink,
      'desc': 'Capture and browse high dynamic range imagery',
    },
    {
      'title': 'Health & Fitness',
      'category': 'Lifestyle',
      'icon': CupertinoIcons.heart_fill,
      'color': CupertinoColors.systemRed,
      'desc': 'Track your daily activity and vitals',
    },
    {
      'title': 'Podcasts & Music',
      'category': 'Entertainment',
      'icon': CupertinoIcons.music_note_2,
      'color': CupertinoColors.systemOrange,
      'desc': 'Curated spatial audio playlists',
    },
    {
      'title': 'Developer Tools',
      'category': 'Utilities',
      'icon': CupertinoIcons.hammer_fill,
      'color': CupertinoColors.systemIndigo,
      'desc': 'Cupertino widgets and inspection kits',
    },
    {
      'title': 'Weather Forecast',
      'category': 'Information',
      'icon': CupertinoIcons.cloud_sun_fill,
      'color': CupertinoColors.systemTeal,
      'desc': 'Real-time weather radar and forecasts',
    },
    {
      'title': 'Maps & Navigation',
      'category': 'Travel',
      'icon': CupertinoIcons.map_fill,
      'color': CupertinoColors.systemGreen,
      'desc': 'Turn-by-turn navigation with 3D landmarks',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showItemModal(BuildContext context, Map<String, dynamic> item) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoPopupSurface(
          child: Container(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            padding: const EdgeInsets.all(24.0),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (item['color'] as Color).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item['category'] as String,
                            style: TextStyle(
                              color: CupertinoColors.secondaryLabel.resolveFrom(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  item['desc'] as String,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Open App'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Dismiss'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _items.where((item) {
      final title = (item['title'] as String).toLowerCase();
      final category = (item['category'] as String).toLowerCase();
      final q = _searchQuery.toLowerCase();
      return title.contains(q) || category.contains(q);
    }).toList();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Explore'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search apps, topics, or categories',
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                onSuffixTap: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                  });
                },
              ),
            ),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.search,
                            size: 52,
                            color: CupertinoColors.secondaryLabel.resolveFrom(context),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No Results Found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.label.resolveFrom(context),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Try searching for another keyword',
                            style: TextStyle(
                              color: CupertinoColors.secondaryLabel.resolveFrom(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        CupertinoListSection.insetGrouped(
                          header: Text(_searchQuery.isEmpty ? 'DISCOVER' : 'SEARCH RESULTS (${filtered.length})'),
                          children: filtered.map((item) {
                            return CupertinoListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: (item['color'] as Color).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  item['icon'] as IconData,
                                  color: item['color'] as Color,
                                  size: 20,
                                ),
                              ),
                              title: Text(item['title'] as String),
                              subtitle: Text(item['desc'] as String),
                              trailing: const CupertinoListTileChevron(),
                              onTap: () => _showItemModal(context, item),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
