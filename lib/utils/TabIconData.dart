class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/tabs/tab_1.png',
      selectedImagePath: 'assets/tabs/tab_1s.png',
      isSelected: true,
    ),
    TabIconData(
      imagePath: 'assets/tabs/tab_2.png',
      selectedImagePath: 'assets/tabs/tab_2s.png',
      index: 1,
    ),
    TabIconData(
      imagePath: 'assets/tabs/tab_3.png',
      selectedImagePath: 'assets/tabs/tab_3s.png',
      index: 2,
    ),
    TabIconData(
      imagePath: 'assets/tabs/tab_4.png',
      selectedImagePath: 'assets/tabs/tab_4s.png',
      index: 3,
    ),
  ];
}
