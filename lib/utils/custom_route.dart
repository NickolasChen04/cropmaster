import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart'; // 导入CustomAppBar

class ContentSlideRoute extends PageRouteBuilder {
  final Widget page;
  
  ContentSlideRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // 获取AppBar和底部按钮的高度
            final appBarHeight = AppBar().preferredSize.height;
            final bottomAreaHeight = 120.0; // 估算底部区域高度，根据实际调整
            
            // 获取屏幕高度
            final screenHeight = MediaQuery.of(context).size.height;
            
            // 计算中间内容区域的高度
            final contentHeight = screenHeight - appBarHeight - bottomAreaHeight;
            
            return Stack(
              children: [
                // 上部分 - AppBar (保持不动)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: appBarHeight,
                  child: Container(
                    color: Colors.white,
                    child: Opacity(
                      opacity: 1.0,
                      child: DefaultTextStyle(
                        style: const TextStyle(color: Colors.transparent),
                        child: Scaffold(
                          appBar: const CustomAppBar(title: 'Farm Setup'),
                          body: Container(),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // 中间部分 - 内容 (滑动过渡)
                Positioned(
                  top: appBarHeight,
                  left: 0,
                  right: 0,
                  height: contentHeight,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    )),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: Builder(
                        builder: (context) {
                          final scaffold = child as Scaffold;
                          return Scaffold(
                            body: scaffold.body,
                            backgroundColor: scaffold.backgroundColor,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                
                // 底部部分 - 按钮区域 (保持不动)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: bottomAreaHeight,
                  child: Container(
                    color: Colors.white,
                    child: Opacity(
                      opacity: 0, // 透明度为0，让真正的底部可见
                      child: Container(),
                    ),
                  ),
                ),
              ],
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
          maintainState: true,
        );
} 