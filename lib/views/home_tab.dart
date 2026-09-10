import 'package:flutter/cupertino.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _selectedSegment = 0;
  final List<String> _feedItems = [
    'Cupertino Design Principles',
    'Smooth Fluid Gestures',
    'Haptic Feedback & Interactions',
    'Dynamic Blur & Vibrancy',
  ];

  Future<void> _handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _feedItems.insert(0, 'Updated: Modern iOS UI #${_feedItems.length + 1}');
      });
    }
  }

  void _showActionSheet(BuildContext context, String title) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(title),
        message: const Text('Choose an iOS action to execute on this card'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Pin to Favorites'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Share Item'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Remove from Feed'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Today'),
            trailing: Icon(CupertinoIcons.bell_fill, size: 22),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: _handleRefresh,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'THURSDAY, SEPTEMBER 10',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.secondaryLabel.resolveFrom(context),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl<int>(
                      groupValue: _selectedSegment,
                      children: const {
                        0: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Text('Featured'),
                        ),
                        1: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Text('Trending'),
                        ),
                        2: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Text('News'),
                        ),
                      },
                      onValueChanged: (int? val) {
                        if (val != null) {
                          setState(() {
                            _selectedSegment = val;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoContextMenu(
                actions: <Widget>[
                  CupertinoContextMenuAction(
                    onPressed: () => Navigator.pop(context),
                    trailingIcon: CupertinoIcons.bookmark,
                    child: const Text('Bookmark'),
                  ),
                  CupertinoContextMenuAction(
                    onPressed: () => Navigator.pop(context),
                    trailingIcon: CupertinoIcons.share,
                    child: const Text('Share'),
                  ),
                  CupertinoContextMenuAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(context),
                    trailingIcon: CupertinoIcons.delete,
                    child: const Text('Delete'),
                  ),
                ],
                child: Container(
                  height: 190,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        CupertinoColors.systemIndigo,
                        CupertinoColors.systemPurple,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.systemPurple.withValues(alpha: 0.3),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'FEATURED',
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.sparkles,
                            color: CupertinoColors.white,
                            size: 24,
                          ),
                        ],
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cupertino Experience',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Press and hold this card for 3D context menu or tap below for quick actions',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CupertinoListSection.insetGrouped(
                header: const Text('TODAY’S HIGHLIGHTS'),
                margin: EdgeInsets.zero,
                children: _feedItems.map((item) {
                  return CupertinoListTile(
                    title: Text(item),
                    subtitle: const Text('Pull down to refresh feed'),
                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        CupertinoIcons.app_badge_fill,
                        color: CupertinoColors.systemBlue,
                        size: 20,
                      ),
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () => _showActionSheet(context, item),
                  );
                }).toList(),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 30),
          ),
        ],
      ),
    );
  }
}
