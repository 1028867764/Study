整理后的 **Flutter** 知识大纲如下：

# 1. **Flutter 基础**

## **1.1 安装与配置**

* 略，详见 [官方文档](https://docs.flutter.cn/)

## **1.2 创建第一个 Flutter 应用**

### 1.2.1 运行 `flutter create` 命令

### 1.2.2 目录结构与文件简介
```
flutter_project/
├── android/ # Android平台相关代码
├── lib/ # 主代码目录
│   ├── main.dart # 应用入口
│   └── ... # 其他Dart文件
├── pubspec.yaml # 项目配置文件
└── build/ # 构建输出目录
```

# 2. **Widgets 基础**

## **2.1 什么是 Widgets**
在 Flutter 开发中，Widget 是构建用户界面的基本单元，Flutter 里的一切几乎都是 Widget，它可以是结构性的（如按钮或文本）、样式性的（如颜色和字体）、布局性的（如填充或边距），或者甚至是其他 Widget 的容器。Widget 主要分为 StatelessWidget 和 StatefulWidget 两种类型，以下为你详细介绍：

### StatelessWidget（无状态 Widget）
- **定义**：StatelessWidget 是没有状态的 Widget，即它们在构建时不会随时间变化。一旦创建，其内部的属性和状态都是不可变的，在创建后不可变，无论是内部数据还是外部属性的变化，都不会影响其重新构建。
- **特点**
    - **不包含可变状态**：所有的值都是最终的，创建后无法改变。
    - **只在特定情况重新构建**：只在创建和其依赖的属性变化时重新构建。当父 Widget 重新构建时，StatelessWidget 也会被重新构建。
    - **简单高效**：没有生命周期方法，不需要处理状态变化，只需要根据传入的属性进行渲染，因此具有更高的性能。
- **适用场景**：适用于显示不变的内容，如静态文本、图标、简单的按钮点击事件、路由跳转等简单交互逻辑，也可作为其他有状态小部件的子组件，用于构建复杂的 UI 结构。
- **示例代码**
```dart
import 'package:flutter/material.dart';

class MyTextWidget extends StatelessWidget {
  final String text;
  MyTextWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.0)
    );
  }
}
```
在上述代码中，`MyTextWidget` 接收一个字符串作为参数，然后使用 `Text` 小部件将该字符串展示出来，它不需要维护任何状态，非常适合用于展示静态的文本内容。

### StatefulWidget（有状态 Widget）
- **定义**：StatefulWidget 是有状态的 Widget，即它们可以在生命周期中随状态变化而重新构建。它由两个类组成，一个是 StatefulWidget 本身，另一个是与之关联的 State 对象，State 对象包含了可变状态信息，并且可以在其生命周期内改变。
- **特点**
    - **包含可变状态**：通过与之关联的 State 对象来管理状态，状态可以在 Widget 的生命周期内发生改变。
    - **状态改变时重新构建**：当状态改变时，通过调用 `setState()` 方法触发重新构建。`setState()` 方法会触发 Flutter 调用 State 的 `build()` 方法，更新 UI。
    - **多个生命周期方法**：有多个生命周期方法，如 `initState()`、`didUpdateWidget()`、`dispose()` 等，用于在不同阶段管理状态。
- **适用场景**：适用于需要动态变化的内容，如表单输入、动画、计数器、需要和用户进行交互的复杂 UI 等。
- **示例代码**
```dart
import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String _text = 'I am a StatefulWidget';

  void _changeText() {
    setState(() {
      _text = 'State has changed!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_text),
        ElevatedButton(
          onPressed: _changeText,
          child: Text('Change Text'),
        ),
      ],
    );
  }
}
```
在这个例子中，`MyStatefulWidget` 是一个 `StatefulWidget`，它持有一个变量 `_text` 来保存文本内容。当用户点击按钮时，会调用 `_changeText` 方法，更新 `_text` 的值，并调用 `setState` 方法来重新构建 Widget，从而更新界面。

## **2.2 Widget 树与构建过程**
在 Flutter 中，Widget 树是构建 UI 的核心概念，以下将详细介绍 Widget 树及其构建过程。

### 什么是 Widget 树
Widget 树是 Flutter 里 UI 的构建方式，所有的 UI 元素（像按钮、文本、图片等）都是 Widget，Widget 树呈现为嵌套结构，父 Widget 会决定子 Widget 的布局和行为。在代码运行时，并没有明确独立的 Widget 树概念，它是开发人员对 Widget 嵌套情况的描述。

### Widget 树的特点
- **声明式 UI**：借助描述 UI 的状态来构建界面。开发者只需声明 UI 应有的样子，Flutter 框架会负责将其渲染出来。
- **不可变性**：Widget 是不可变的，一旦创建，其属性和状态就不能被修改。任何状态的变化都会触发 Widget 树的重建。

### Widget 树的组成
- **根 Widget**：通常是 `MaterialApp` 或 `CupertinoApp`。`MaterialApp` 用于构建具有 Material Design 风格的应用，而 `CupertinoApp` 则用于构建具有 iOS 风格的应用。
- **布局 Widget**：例如 `Row`、`Column`、`Stack` 等。`Row` 和 `Column` 分别用于水平和垂直布局，`Stack` 则允许子 Widget 重叠排列。
- **功能 Widget**：如 `Text`、`Image`、`Button` 等，这些 Widget 用于实现具体的 UI 功能。

### Widget 树的构建过程
#### 1. 应用启动与根 Widget 创建
当 Flutter 应用启动时，会调用 `runApp()` 函数，该函数接收一个 Widget 作为参数，这个 Widget 就是应用的根 Widget，通常是 `MaterialApp` 或 `CupertinoApp`。例如：
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Center(child: Text('Hello, World!')),
    ),
  ));
}
```
在这个例子中，`MaterialApp` 是根 Widget，它管理着应用的主题和导航等全局信息。

#### 2. 从根 Widget 开始构建 Widget 树
根 Widget 的 `build` 方法会被调用，该方法会返回一个 Widget 树。在构建过程中，会根据 Widget 的类型和属性创建相应的 Widget 实例，并将它们组合成树形结构。例如，`Scaffold` 是一个常用的布局 Widget，它会创建一个包含 `AppBar`、`Body` 等子 Widget 的树形结构。

#### 3. 递归构建子 Widget
在构建 Widget 树时，会递归地调用每个 Widget 的 `build` 方法来构建其子 Widget。例如，在 `Scaffold` 的 `build` 方法中，会调用 `AppBar` 和 `Body` 的 `build` 方法来构建它们各自的子 Widget。这个过程会一直递归下去，直到构建到最底层的 Widget。

#### 4. 处理 Widget 的更新
当 Widget 的状态发生变化时，会触发 Widget 树的重建。例如，当调用 `setState()` 方法时，Flutter 会标记当前 `State` 对象为“脏”状态，当 `build` 方法再次被调用时，会重新构建 Widget 树，以反映最新的状态。不过，Flutter 采用了局部重建的策略，即只重建需要更新的部分，而不是整个 UI 树，从而提高性能。

### 示例代码
下面是一个简单的电商首页布局示例，展示了 Widget 树的构建过程：
```dart
import 'package:flutter/material.dart';

class EcommerceHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("电商首页"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // 搜索栏
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "搜索商品",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // 分类网格
          Expanded(
            flex: 1,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text("分类 ${index + 1}"),
                  ),
                );
              },
            ),
          ),
          // 商品列表
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                    child: Icon(Icons.shopping_bag),
                  ),
                  title: Text("商品名称 ${index + 1}"),
                  subtitle: Text("商品描述 ${index + 1}"),
                  trailing: Text("\$ ${(index + 1) * 10}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EcommerceHomePage(),
  ));
}
```
在这个示例中，`MaterialApp` 是根 Widget，`Scaffold` 是其子 Widget，`AppBar`、`Column`、`GridView.builder` 和 `ListView.builder` 等都是 `Scaffold` 的子 Widget，它们共同构成了一个 Widget 树。

# 3. **常用布局组件**

## 3.1 基础布局组件
### `Scaffold`
#### 基本示例代码
```dart
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Scaffold Demo')),
        body: Center(child: Text('Hello, Flutter!')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

### `Container`
#### 基本示例代码
```dart
Container(
  width: 200,
  height: 200,
  margin: EdgeInsets.all(10),
  padding: EdgeInsets.only(left: 10, top: 5, right: 0, bottom: 0), // 指定特定方向边距
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
  ),
  child: Text('Hello, Container!'),
)


Container(
  margin: EdgeInsets.fromLTRB(10, 5, 10, 5), // 分别设置左、上、右、下边距
  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // 垂直、水平对称边距
  decoration: BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.only( // 分别指定四个角的半径
      topLeft: Radius.circular(15),
      topRight: Radius.circular(30),
      bottomLeft: Radius.circular(5),
      bottomRight: Radius.circular(50),
    ),
  ),
  child: Text('综合示例'),
)
```

### `Padding`
```dart
Padding(
  padding: EdgeInsets.all(16), // 四周16像素边距
  child: Text('Hello, Flutter!'),
)
```

### `alignment` 属性和 `Center`
```dart
Container(
  width: 200,
  height: 200,
  color: Colors.blue,
  alignment: Alignment.center, // 水平垂直居中
  child: Text('居中文本'),
)

// 其它 
alignment: Alignment.topLeft,     // 左上角对齐
alignment: Alignment.bottomRight, // 右下角对齐

// 当 "alignment: Alignment.center,"时候，可省略成
Center(
  width: 200,
  height: 200,
  color: Colors.blue,
  child: Text('居中文本'),
)
```

### `SizedBox`
```dart
SizedBox(width: 50), // 水平占位空白
SizedBox(height: 80), // 垂直占位空白
```

### `ConstrainedBox`
```dart
```
### `IntrinsicHeight`
```dart
```
### `IntrinsicWidth`
```dart
```
### `ClipRRect`
```dart
```

## 3.2 线性布局
### `Column`
### `Row`
### `Expanded`
### `Wrap`

## 3.3 滚动布局
### `ListView`
### `GridView`
### `SingleChildScrollView`
### `CustomScrollView`
### `NestedScrollView`
### `ScrollController`

## 3.4 Material Design组件
### `AppBar`
### `BottomNavigationBar`
### `Card`
### `ListTile`
### `TabBar`
### `TabBarView`
### `AlertDialog`

## 3.5 交互组件
### `GestureDetector`
### `InkWell`
### `IconButton`
### `ElevatedButton`
### `TextButton`
### `TextField`

## 3.6 其它
### `Text`
### `SelectableText`
### `Stack`
### `Positioned`
### `AnimatedOpacity`
### `AnimatedPositioned`
### `SliverList`
### `SliverGrid`
### `SliverAppBar`


# 4. **自定义 Widget**

* 创建自定义 Widgets
* 使用 `CustomPaint` 和 `CustomClipper`

# 5. **响应式布局**

* 使用 `MediaQuery`、`LayoutBuilder` 适配不同屏幕尺寸
* Flutter 中的响应式设计模式（如 `AspectRatio`, `FractionallySizedBox`）

# 6. **状态管理**

## **6.1 状态管理简介**

* 有状态和无状态的 Widget 区别
* `setState` 的使用

## **6.2 常见的状态管理方案**

* Provider（最流行的状态管理方案）
* Riverpod
* Bloc（Business Logic Component）
* Redux
* GetX

## **6.3 InheritedWidget 和 ScopedModel**

# 7. **网络请求**

## **7.1 HTTP 请求**

* 使用 `http` 库进行 API 调用
* 使用 Dio 进行高级请求（拦截器、请求头等）

## **7.2 JSON 解析与数据处理**

* Dart 中如何解析 JSON
* 创建模型类并转换为 Dart 对象

# 8. **Flutter 路由与导航**

## **8.1 基本路由管理**

* 使用 `Navigator.push` 和 `Navigator.pop`

## **8.2 命名路由**

* 配置与使用命名路由

## **5.3 路由传参**

* 路由之间传递数据

## **5.4 Flutter 的嵌套路由与页面管理**

# 9. **本地存储与数据库**

## **9.1 Shared Preferences**

* 简单的 key-value 存储

## **9.2 其它数据库**

* 略，详见 [官方文档](https://docs.flutter.cn/)

# 10. **Flutter 动画与特效**

## **10.1 基本动画**

* 使用 `AnimatedContainer`, `AnimatedOpacity`, `TweenAnimationBuilder` 等

## **10.2 自定义动画**

* 使用 `AnimationController` 和 `Tween`

## **10.3 复杂动画**

* 使用 `Hero` 动画、`PageRouteBuilder` 创建页面切换动画

## **10.4 Flare/Flutter Lottie 动画**

* 集成 Lottie 动画

