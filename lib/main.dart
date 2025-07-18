import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/my_screen.dart';
import 'screens/product_list_page.dart'; // 상품 리스트 페이지 import

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainTabNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainTabNavigator extends StatefulWidget {
  const MainTabNavigator({super.key});
  @override
  State<MainTabNavigator> createState() => _MainTabNavigatorState();
}

class _MainTabNavigatorState extends State<MainTabNavigator> {
  int _currentIndex = 0;
  String? _selectedCategory; // 상품리스트 진입 시 카테고리 저장

  Widget _getBody() {
    if (_selectedCategory != null) {
      // 상품리스트 화면
      return ProductListPage(
        initialFit: _selectedCategory!,
        onBack: () => setState(() => _selectedCategory = null),
      );
    }

    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          onCategoryTap: (category) =>
              setState(() => _selectedCategory = category),
        );
      case 1:
        return const FeedScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const MyScreen();
      default:
        return const Center(child: Text("NOT FOUND"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: '피드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '장바구니',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'MY',
          ),
        ],
        onTap: (index) => setState(() {
          _currentIndex = index;
          _selectedCategory = null; // 탭 이동 시 상품리스트 닫기
        }),
      ),
    );
  }
}
