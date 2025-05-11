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

## **2.1 什么是 `Widget`**
在 Flutter 开发中，`Widget` 是构建用户界面的基本单元，Flutter 里的一切几乎都是 `Widget`。`Widget` 主要分为 `StatelessWidget` 和 `StatefulWidget` 两种类型，以下为你详细介绍：

### 2.1.1 `StatelessWidget`
- **定义**：StatelessWidget 是没有状态的 Widget，即它们在构建时不会随时间变化。
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

### 2.1.2 `StatefulWidget`（重点）
#### 2.1.2.1 介绍
- **定义**：`StatefulWidget` 是有状态的 `Widget`，即它们可以在生命周期中随状态变化而重新构建。它由两个部分组成，一个是 `StatefulWidget` 本身，另一个是与之关联的 `State` ，`State` 包含了可变状态信息，并且可以在其生命周期内改变。
- **特点**
    - **`StatefulWidget`**：**不可变**（immutable），仅负责创建 `State`（通过 `createState()`）。
    - **`State`**：**可变**，负责管理动态状态和 UI 更新（如 `initState()`、`build()`、`setState()`、`dispose()`、`didUpdateWidget()`、`deactivate()`）。 
    - **状态改变时重新构建**：`setState()` 方法会触发 Flutter 调用 `State` 的 `build()` 方法，更新 UI。
- **适用场景**：适用于需要动态变化的内容，如表单输入、动画、计数器、需要和用户进行交互的复杂 UI 等。

#### 2.1.2.2 **示意图：创建一个有状态的 `Widget()` 对象**
```dart
class Aaa extends StatefulWidget {
  @override // 重写
  State<Aaa> createState() => _BbbState();
}

class _BbbState extends State<Aaa> {
  // 生命周期方法
}

// 其它地方可以直接调用已经封装好的 widget 对象（不一定要声明变量接收保存）
Aaa() 
// Aaa() 是一个可以被 Flutter 框架识别并调用内置 build 方法实现渲染的widget
```

#### 2.1.2.3 **`StatefulWidget` 生命周期**

`StatefulWidget` 的生命周期分为以下几个阶段：

1. **`createState()`**：

   * 这个方法由框架调用，用于创建与 `StatefulWidget` 关联的 `State` 对象。每个 `StatefulWidget` 都需要一个对应的 `State` 对象，`createState()` 就是用来创建这个对象的。

2. **`initState()`**：

   * 在 `State` 对象被插入到树中时调用。只会调用一次，适合做初始化工作（如数据加载、订阅事件等）。
   * `super.initState()` 需要在自定义实现中调用，确保父类的初始化工作正常执行。

3. **`build()`**：

   * 这是生命周期中最常调用的方法，它用于描述组件的 UI。每当 `setState()` 被调用，或者组件的依赖发生变化时，`build()` 方法都会被重新调用。
   * `build()` 方法中不应该做耗时的操作，建议仅仅负责 UI 的构建。

4. **`didChangeDependencies()`**：

   * 当 `State` 对象的依赖发生变化时调用。例如，当 `InheritedWidget` 发生变化时，`didChangeDependencies()` 会被调用一次。
   * 这个方法也会在 `initState()` 之后调用。

5. **`setState()`**：

   * 调用 `setState()` 时，`State` 对象会重新构建其 UI。这会触发 `build()` 方法的执行，刷新页面。

6. **`deactivate()`**：

   * 当 `State` 对象从树中移除时调用，常见于 `StatefulWidget` 被替换或销毁时。在此阶段，`State` 对象仍然在内存中，但不再附加到组件树中。

7. **`dispose()`**：

   * 当 `State` 对象从树中永久移除时调用。这是清理资源的地方，特别是你需要取消订阅的监听器或释放其他资源时。
   * 一般来说，所有需要清理的资源（如 `AnimationController`、`StreamController`、`ScrollController` 等）都应该在 `dispose()` 中释放。

---
##### 🚨 **注意点**

* `initState()` 只会调用一次，适合做一次性初始化。
* `dispose()` 用来释放资源，避免内存泄漏。
* 在 `setState()` 中不做耗时操作，避免 UI 阻塞。
* `build()` 会频繁调用，不要在里面进行状态改变（比如不要在 `build()` 中调用 `setState()`）。

---

##### 📚 示例：完整的生命周期

```dart
import 'package:flutter/material.dart';

class LifecycleExample extends StatefulWidget {
  @override
  State<LifecycleExample> createState() => _LifecycleExampleState();
}

class _LifecycleExampleState extends State<LifecycleExample> {
  String _text = 'I am a StatefulWidget';
  int count = 0;
  String _number = '';

  @override
  void initState() {
    super.initState();
    _number = count.toString();
    print("initState: 组件被创建");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies: 依赖发生变化");
  } // 依赖变化时调用

  @override
  Widget build(BuildContext context) {
    print("build: 构建 UI");
    return Scaffold(
      appBar: AppBar(title: Text("生命周期示例")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_text, style: TextStyle(fontSize: 20)),
          Text('点击次数: $_number', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20), // 间距组件
          // 按钮：点击触发状态更新
          ElevatedButton(onPressed: _changeText, child: Text('Change Text')),
        ],
      ),
    );
  } // 被 Flutter 框架调用以渲染界面
  // 二次触发机制：setState() 或 didChangeDependencies()

  void _changeText() {
    setState(() {
      DateTime now = DateTime.now();
      _text =
          '状态已更新: ${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
      count++;
      _number = count.toString();
      print('setState 被调用，UI 即将更新');
    }); // 刷新 UI
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate: 组件被移除"); // 从树中移除时调用
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose: 组件销毁，资源清理"); // 永久移除时调用
  }
}

void main() => runApp(MaterialApp(home: LifecycleExample()));
```
---

##### 🔑 关键点：

1. **`initState`** 用于初始化。
2. **`build`** 用于绘制 UI。
3. **`dispose`** 用于资源清理。

## **2.2 Widget 树与构建过程**

### 2.2.1 启动应用与创建根 Widget
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

### 2.2.2 `MaterialApp`
```dart
// main() 是Dart程序的唯一入口函数，Flutter应用启动时首先执行该函数
void main() {
  // runApp() 是Flutter框架的核心启动函数，用于初始化应用并绑定根Widget
  runApp(
    MaterialApp(  // MaterialApp是Flutter提供的Material风格应用框架
      title: '外卖应用', // 应用标题（显示在任务管理器/多任务视图）
      theme: ThemeData(primarySwatch: Colors.blue), // 全局主题配置（主色为蓝色）
      home: Scaffold(), // 默认首页
    )
  );
}
```

### 2.2.3 重写 `build` 方法
`MaterialApp` 是一个预定义的 `Widget`，其内部已经实现了 `build` 方法。因此，直接将其作为根组件传递给 `runApp()` 是合法的：
```dart
void main() {
  runApp(MaterialApp(home: Scaffold())); // 无需自定义build方法
}
```
此时 `MaterialApp` 会通过自身的 `build` 方法完成渲染。

`build` 函数是 `Widget` 类中的一个抽象方法，所有 `widget` 都必须实现它。换句话说，所有的 `widget` 内部都必须有 `build` 方法，因为当 Flutter 需要渲染一个 `widget` 时，就会调用它的 `build` 方法（否则 Flutter 无法渲染）。

若创建自定义的 `StatelessWidget` 或 `StatefulWidget`，则必须重写 `build` 方法，否则会触发编译错误。

```dart
@override // 重写 build 方法
Widget build(BuildContext context) {
  return ;// 返回一个 widget 树
}
```
在 `StatelessWidget` 中，`build` 函数直接位于类的内部：
```dart
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String title;

  // 构造函数，接收 title 参数
  const MyWidget({super.key, required this.title});

  // build 方法：每个 widget 都需要这个来构建 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(child: Text('Hello World')),
    );
  }
}
```
在 `StatefulWidget` 中，`build` 函数位于对应的 `State` 类中：
```dart
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: () => setState(() => count++),
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

### 2.2.4 以命名参数形式传入自定义 Widget() 对象
```dart
import 'package:flutter/material.dart';

class Banana extends StatefulWidget {

 @override
 State<Banana> createState() => _BananaState();

}

class _BananaState extends State<Banana> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("隐式声明"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: 200,
        height: 100,
        color: Colors.yellow,
        alignment: Alignment.center,
        child: Text(
          '好棒哦',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Banana(),  // 以命名参数形式传入自定义的 StatefulWidget 组件 'Banana()'
  ));
}
```
#### 🔍 怎么理解这个调用过程？

1. 传入`Banana()` 。
2. `Banana` 会自动执行它的 `createState()` 方法，创建并返回 `_BananaState`
3. 然后 Flutter 框架会调用 `_BananaState` 类中的 `build()` 方法，构建 UI。
4. 最终，`Scaffold -> AppBar -> Container -> Text` 的整个界面被渲染出来。

## **2.3 本章小结**
```markdown
main() 
  ↓
runApp()
  ↓
MaterialApp(home: 自定义())   // 以命名参数形式传入自定义 Widget
  ↓
  ↓
自定义()                     // 自定义 extends StatefulWidget
  ↓
createState()                // 创建状态对象
  ↓
State<自定义> {              // 状态类开始生命周期
  ├─ initState()             // 初始化，只调用一次
  ├─ build()                 // 构建 UI，首次渲染或 setState 后调用
  ├─ setState()              // 修改状态，触发 build()
  └─ dispose()               // 销毁前调用，释放资源
}
```

# 3. **常用布局组件**

## 3.1 基础布局组件
### `Scaffold`
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

#### `alignment` 属性和 `Center` 组件
```dart
Container(
  width: 200,
  height: 200,
  color: Colors.blue,
  alignment: Alignment.center, // 子组件Text('居中文本')在容器内居中
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

#### `Container` 的其它属性
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Gradient + Constraints 示例')),
        body: Center(
          child: Container(
            // 1. 尺寸约束：设置最小/最大宽高
            constraints: BoxConstraints(
              minWidth: 100,  // 最小宽度
              maxWidth: 300, // 最大宽度
              minHeight: 50, // 最小高度
              maxHeight: 200, // 最大高度
            ),

            // 2. 渐变背景：使用 LinearGradient 从左到右渐变
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.green], // 渐变颜色数组
                begin: Alignment.centerLeft,         // 渐变起始位置
                end: Alignment.centerRight,          // 渐变结束位置
              ),
              borderRadius: BorderRadius.circular(10), // 圆角
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // 阴影偏移
                ),
              ],
            ),

            // 3. 子组件对齐方式
            alignment: Alignment.center,

            // 4. 内边距
            padding: EdgeInsets.all(16.0),

            // 5. 子组件：居中显示的文本
            child: Text(
              'Flutter 容器示例',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

#### `Container` 常用属性总结
```markdown
flutter_container/
├── 基础属性
│   ├── width: double
│   ├── height: double
│   └── color: Color
│
├── 布局属性
│   ├── margin: EdgeInsets
│   │   ├── fromLTRB(left, top, right, bottom)
│   │   ├── symmetric(vertical, horizontal)
│   │   └── all(value)
│   │
│   ├── padding: EdgeInsets
│   │   ├── fromLTRB(left, top, right, bottom)
│   │   ├── symmetric(vertical, horizontal)
│   │   └── all(value)
│   │
│   └── alignment: Alignment
│       ├── center
│       ├── topLeft
│       ├── bottomRight
│       └── [其他8个预置位置]
│
├── 约束属性
│   └── constraints: BoxConstraints
│       ├── minWidth: double
│       ├── maxWidth: double
│       ├── minHeight: double
│       └── maxHeight: double
│
├── 装饰属性
│   └── decoration: BoxDecoration
│       ├── color: Color
│       ├── borderRadius: BorderRadius
│       │   ├── circular(radius)
│       │   └── only(
│       │       ├── topLeft: Radius.circular(radius)
│       │       ├── topRight: Radius.elliptical(x, y)
│       │       ├── bottomLeft: Radius.zero
│       │       └── bottomRight: Radius.circular(radius)
│       │   )
│       │
│       ├── gradient: Gradient
│       │   ├── LinearGradient
│       │   │   ├── colors: List<Color>
│       │   │   ├── begin: Alignment
│       │   │   └── end: Alignment
│       │   │
│       │   └── RadialGradient
│       │       ├── colors: List<Color>
│       │       ├── center: Alignment(x, y)
│       │       ├── radius: double (0~1)
│       │       ├── stops: List<double>?
│       │       ├── focal: Alignment?
│       │       └── tileMode: TileMode
│       │
│       └── border: Border
│           ├── all(width, color)
│           └── symmetric(
│               ├── vertical: BorderSide
│               └── horizontal: BorderSide
│           )
│
└── 子元素
    └── child: Widget
```

### `Padding`
```dart
Padding(
  padding: EdgeInsets.all(16), // 四周16像素边距
  child: Text('Hello, Flutter!'),
)
```

### `ConstrainedBox`
```dart
        // 1. 基础用法（强制固定尺寸）
        ConstrainedBox(
          constraints: BoxConstraints.tight(Size(150, 150)), // 强制150x150尺寸
          child: Container(
            color: Colors.red,
            child: Center(child: Text('固定尺寸 150x150')),
          ),
        ),

        // 2. 动态约束（最小/最大宽高）
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 100,
            maxWidth: 200,
            minHeight: 50,
            maxHeight: 150,
          ),
          child: Container(
            color: Colors.blue,
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(
                '动态约束\n最小100x50\n最大200x150',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        // 3. 填充父容器
        SizedBox( // 限制父容器大小
          width: 250,
          height: 100,
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(), // 填充父容器
            child: Container(
              color: Colors.green,
              child: Center(child: Text('填充父容器 250x100')),
            ),
          ),
        ),
      
```

### `SizedBox`
```dart
SizedBox(width: 50), // 水平占位空白
SizedBox(height: 80), // 垂直占位空白
```

### `ClipRRect`
`ClipRRect`是 Flutter 中用于将子组件（如图片、容器等）裁剪为圆角矩形的组件
```dart
// 圆角图片
ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: Image.asset('assets/avatar.jpg'),
)

// ​圆角容器
ClipRRect(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    bottomRight: Radius.circular(10),
  ),
  child: Container(color: Colors.red),
)
```

### 组件的 `key` 属性
`key` 是Flutter用来区分相同类型Widget的唯一标识符（ID），若需要参与动态操作（如列表排序、状态保留），则需显式设置Key，否则**通常无需主动指定**
```dart
Column(
  children: [
    TextField(key: ValueKey('username')), // 用户名输入框
    TextField(key: ValueKey('password')), // 密码输入框
  ],
)
```

## 3.2 线性布局
### `Row` 和 `Column`
- 水平布局
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 主轴：子组件均匀分布
  crossAxisAlignment: CrossAxisAlignment.center,    // 交叉轴：垂直居中
  children: [
    Container(
      color: Colors.red,
      width: 50,
      height: 50,
      child: Text("A"),
    ),
    Container(
      color: Colors.blue,
      width: 70,
      height: 50,
      child: Text("B"),
    ),
  ],
)
```
- 垂直布局
```dart
Column(
  mainAxisSize: MainAxisSize.min,           // 主轴：仅包裹子组件高度
  crossAxisAlignment: CrossAxisAlignment.stretch, // 交叉轴：水平拉伸
  children: [
    ElevatedButton(onPressed: () {}, child: Text("按钮1")),
    ElevatedButton(onPressed: () {}, child: Text("按钮2")),
    Expanded(                              // 占据剩余空间
      child: Container(color: Colors.grey),
    ),
  ],
)
```
- 嵌套
```dart
Column(
  children: [
    Row(children: [Text("标题"), Icon(Icons.arrow_drop_down)]),
    Container(height: 10),
    Row(
      children: List.generate(3, (i) => Expanded( // 均分宽度
        child: Container(height: 50, color: Colors.primaries[i]), //Colors.primaries是Flutter内置的13种基础颜色数组（红、黄、蓝等）
      )),
    ),
  ],
)
```

### `Row` 和 `Column` 常用属性总结
```markdown
├── 主轴对齐属性
│   └── mainAxisAlignment: MainAxisAlignment
│       ├── start    // 子组件从主轴起点排列（Row左端/Column顶部）
│       │   // 示例：Row(mainAxisAlignment: MainAxisAlignment.start)
│       ├── end      // 子组件从主轴末端排列（Row右端/Column底部）
│       │   // 示例：Column(mainAxisAlignment: MainAxisAlignment.end)
│       ├── center   // 子组件居中排列
│       │   // 适用于居中按钮组或标题
│       ├── spaceBetween  // 首尾子组件贴边，中间均匀分布
│       │   // 典型应用：导航栏图标分布
│       ├── spaceAround   // 每个子组件两侧留相同空白
│       │   // 效果：视觉上每个元素有"外边距"
│       └── spaceEvenly   // 所有间隔（包括首尾）完全均等
│           // 适合需要精确控制间距的场景
│
├── 交叉轴对齐属性
│   └── crossAxisAlignment: CrossAxisAlignment
│       ├── start    // 沿交叉轴起点对齐（Row顶部/Column左端）
│       │   // 注意：受verticalDirection/textDirection影响
│       ├── end      // 沿交叉轴末端对齐（Row底部/Column右端）
│       ├── center   // 交叉轴居中对齐（默认值）
│       │   // 示例：Row(crossAxisAlignment: CrossAxisAlignment.center)
│       ├── stretch  // 强制子组件拉伸填满交叉轴
│       │   // 需要子组件没有固定宽度/高度才生效
│       └── baseline // 按文本基线对齐（需设置textBaseline）
│           // 适用场景：需要文字底部对齐的输入框组合
│
├── 主轴尺寸控制
│   └── mainAxisSize: MainAxisSize
│       ├── max  // 填满父容器主轴空间（默认）
│       │   // 示例：Row(mainAxisSize: MainAxisSize.max)
│       └── min  // 仅包裹子组件内容大小
│           // 适用场景：浮动按钮组
│
├── 子元素
│   └── children: List<Widget>
│       └── [子组件列表]  // 最少包含1个Widget
│           // 特殊元素：
│           // Expanded - 按比例分配剩余空间
│           // Spacer - 创建弹性空白
│
├── 方向依赖属性
│   ├── textDirection: TextDirection（仅 Row 有效）
│   │   ├── ltr  // 从左到右排列（默认）
│   │   │   // 影响MainAxisAlignment.start的方向
│   │   └── rtl  // 从右到左排列
│   │       // 阿拉伯语等RTL语言适配
│   │
│   └── verticalDirection: VerticalDirection（仅 Column 有效）
│       ├── down  // 从上到下排列（默认）
│       └── up    // 从下到上排列
│           // 特殊场景：聊天消息倒序排列
│
└── 基线对齐（可选）
    └── textBaseline: TextBaseline
        ├── alphabetic   // 字母基线对齐（英文文本常用）
        └── ideographic // 表意文字基线（中文/日文适用）
            // 必须与CrossAxisAlignment.baseline配合使用
            // 示例：
            // crossAxisAlignment: CrossAxisAlignment.baseline,
            // textBaseline: TextBaseline.alphabetic
```

### `Expanded` 和 `Spacer`
- `Expanded` 必须包含子组件
```dart
Row(
  children: [
    Container(width: 50, color: Colors.red),
    Expanded( 
      flex: 2, // 填满剩余空间,占比2/3
      child: Container(color: Colors.blue),
    ),
    Expanded( // 填满剩余空间,占比1/3
      flex: 1,
      child: Container(color: Colors.green),
    ),
  ],
)
```
- `Spacer` 无子组件（空白占位）
```dart
Row(
  children: [
    Container(width: 50, color: Colors.red),
    Spacer(flex: 2), // 占剩余空间的2/3
    Container(width: 50, color: Colors.blue),
    Spacer(), // 默认flex:1，占剩余空间的1/3
    Container(width: 50, color: Colors.green),
  ],
)
```

### `Wrap`
Flutter的 `Wrap` 流式布局组件，用于在空间不足时自动换行排列子组件，非常适合动态布局和响应式设计(例如b站的搜索历史标签)
```dart
// 水平流式布局（标签云）
Wrap(
  spacing: 8.0, // 主轴（默认水平）间距
  runSpacing: 4.0, // 交叉轴行列间距
  direction: MediaQuery.of(context).size.width > 600 
      ? Axis.horizontal  // 默认水平
      : Axis.vertical,
  children: List.generate(
    5,
    (index) => Container(
      width: 100,
      height: 100,
      color: Colors.primaries[index],
    ),
  ),
)
```

### `IntrinsicWidth` 和 `IntrinsicHeight`
原理：自动取子组件中的最大宽（高）度，让Column（Row）中的不同宽（高）度的子组件统一宽（高）度
```dart
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. IntrinsicHeight示例：让Row中的不同高度子组件统一高度
          IntrinsicHeight(
            child: Row(
              children: [
                // 蓝色方块（高度150）
                Container(
                  width: 80,
                  height: 150,
                  color: Colors.blue,
                  child: Center(child: Text("高150", style: TextStyle(color: Colors.white))),
                ),
                // 红色方块（高度60，会被拉伸到150）
                Container(
                  width: 80,
                  height: 60,
                  color: Colors.red,
                  child: Center(child: Text("原高60", style: TextStyle(color: Colors.white))),
                ),
                // 绿色方块（未设高度，自动匹配150）
                Container(
                  width: 80,
                  color: Colors.green,
                  child: Center(child: Text("自动高度", style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
          ),

          SizedBox(height: 40),

          // 2. IntrinsicWidth示例：让Column中的不同宽度子组件统一宽度
          IntrinsicWidth(
            child: Column(
              children: [
                // 短按钮（宽度由最长的按钮决定）
                ElevatedButton(
                  onPressed: () {},
                  child: Text("短按钮"),
                ),
                // 中等按钮
                ElevatedButton(
                  onPressed: () {},
                  child: Text("中等按钮"),
                ),
                // 最长按钮（决定最终宽度）
                ElevatedButton(
                  onPressed: () {},
                  child: Text("这个按钮文本最长，决定最终宽度"),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
));
```

## 3.3 滚动布局
### `SingleChildScrollView`
`SingleChildScrollView` 是 Flutter 中用于 **使单个子组件可以滚动** 的组件，适用于内容不确定或内容可能超出屏幕但不需要复杂列表的情况。

---

#### ✅ 基本用法

```dart
SingleChildScrollView(
  child: Column(
    children: [
      Text("内容 1"),
      Text("内容 2"),
      // 更多内容...
    ],
  ),
)
```

---

#### 📌 核心特点

| 特性        | 说明                                  |
| --------- | ----------------------------------- |
| 只能有一个子组件  | 一般配合 `Column`、`Row`、`Container` 等使用 |
| 适合少量可滚动内容 | 比如表单、静态布局超出屏幕的情况                    |
| 默认垂直方向滚动  | 可通过 `scrollDirection` 修改为水平         |

---

#### ✅ 示例代码

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SimpleListView());
  }
}

class SimpleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('独生子滚动')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(),
            Container(height: 20, color: Colors.blue),
            TextField(),
            Container(height: 400, width: 100, color: Colors.yellow),
            Container(height: 400, width: 100, color: Colors.pink),
            Container(height: 20, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
```

---

#### ❗注意事项：

* 不适合用于大量子组件（请使用 `ListView`）。
* 子组件不能有无限高度（如 `Column` + 未限制高度的 `Expanded` 可能报错）。

### `ListView.builder`
- `itemCount` ：列表的总项数。必须指定，否则默认无限生成
- `itemBuilder` ：每个 `item` 的构建函数，返回一个 `Widget`，接收 `context` 和 `index` 参数
- 示例：左侧分类导航栏组件
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SimpleListView());
  }
}

class SimpleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('侧边导航栏')),
      body: SizedBox(
        width: 80, // 设置整个 ListView 的宽度为 80
        child: ListView.builder(
          // itemCount：列表中一共有多少项（例如 20 项）
          itemCount: 20,

          // itemBuilder：每当 ListView 需要构建一项时，会调用这个函数
          // 参数说明：
          // context：上下文对象
          // index：当前是第几个列表项（从 0 开始）
          // 返回值必须是一个 Widget（列表中显示的每一项）
          itemBuilder: (context, index) {
            return Container(
              height: 80, // 每项高度为 80
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Colors.yellow,
              ),
              child: Center(child: Text('第 $index 项')),
            );
          },
        ),
      ),
    );
  }
}
```

### `GridView.builder`
- 示例：使用 `GridView.builder` 构建 3 列网格
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GridExample(),
    );
  }
}

class GridExample extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("3列网格")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,     // 每行显示3个，也就是3列布局
            crossAxisSpacing: 10,     // 水平间距
            mainAxisSpacing: 10,       // 垂直间距
            childAspectRatio: 1.0,     // 宽高比
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.teal[100 * ((index % 8) + 1)],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  items[index],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

```

### `ScrollController`
####
| 功能          | 说明                                                                                            |
| ----------- | --------------------------------------------------------------------------------------------- |
| **获取滚动位置**  | `controller.offset`（当前偏移值）                      |
| **滚动到指定位置** | `controller.jumpTo(offset)`：直接跳转，无动画<br>`controller.animateTo(offset, duration, curve)`：带动画滚动 |
| **监听滚动事件**  | `controller.addListener(() { ... })`：每次滚动时都会触发，可用于监听滚动距离、触底等                                  |

---
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScrollController Demo',
      home: ScrollDemo(),
    );
  }
}

class ScrollDemo extends StatefulWidget {
  @override
  _ScrollDemoState createState() => _ScrollDemoState();
}

class _ScrollDemoState extends State<ScrollDemo> {
  final ScrollController _scrollController = ScrollController();

  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();

    // 添加滚动监听器
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    // 释放控制器
    _scrollController.dispose();
    super.dispose();
  }

  // 滚动到底部
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  // 滚动到顶部
  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollController 示例'),
      ),
      body: Column(
        children: [
          // 显示当前滚动位置
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('当前滚动位置: ${_scrollOffset.toStringAsFixed(1)}'),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 50,
              itemBuilder: (context, index) => ListTile(
                title: Text('Item $index'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _scrollToTop,
            child: Icon(Icons.arrow_upward),
            tooltip: '滚动到顶部',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _scrollToBottom,
            child: Icon(Icons.arrow_downward),
            tooltip: '滚动到底部',
          ),
        ],
      ),
    );
  }
}
```
#### 🧠 小提示：

* 结合 `controller.position.maxScrollExtent` 可判断是否滚动到底部；
* 使用 `controller.dispose()` 释放资源，避免内存泄露；
* 可在 `initState()` 中初始化监听器。
---

### `CustomScrollView`
```dart
```

### `NestedScrollView`
```dart
```


## 3.4 Material Design组件
### `AppBar`
```dart
```

### `BottomNavigationBar`
```dart
```

### `FloatingActionButton`
```dart
```

### `ProgressIndicator`
```dart
```

### `Card`
```dart
```

### `ListTile`
```dart
```

### `TabBar`
```dart
```

### `TabBarView`
```dart
```

### `AlertDialog`
```dart
```

## 3.5 交互组件
### `GestureDetector`
```dart
```

### `InkWell`
```dart
```

### `IconButton`
```dart
```

### `ElevatedButton`
```dart
```

### `TextButton`
```dart
```

### `TextField`
```dart
```

### `TextEditingController`
```dart
```

## 3.6 其它
### `Text` 和 `SelectableText`
```dart
```

### `Icon`
```dart
```

### `Stack`
```dart
```

### `Positioned`
```dart
```

### `AnimatedOpacity`
```dart
```

### `AnimatedPositioned`
```dart
```

### `SliverList`
```dart
```

### `SliverGrid`
```dart
```

### `SliverAppBar`
```dart
```


# 4. **响应式布局**

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

