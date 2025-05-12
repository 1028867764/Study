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

## 2.2 `StatelessWidget`
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

## 2.3 `StatefulWidget`（重点）
### 2.3.1 介绍
- **定义**：`StatefulWidget` 是有状态的 `Widget`，即它们可以在生命周期中随状态变化而重新构建。它由两个部分组成，一个是 `StatefulWidget` 本身，另一个是与之关联的 `State` ，`State` 包含了可变状态信息，并且可以在其生命周期内改变。
- **特点**
    - **`StatefulWidget`**：**不可变**（immutable），仅负责创建 `State`（通过 `createState()`）。
    - **`State`**：**可变**，负责管理动态状态和 UI 更新（如 `initState()`、`build()`、`setState()`、`dispose()`、`didUpdateWidget()`、`deactivate()`）。 
    - **状态改变时重新构建**：`setState()` 方法会触发 Flutter 调用 `State` 的 `build()` 方法，更新 UI。
- **适用场景**：适用于需要动态变化的内容，如表单输入、动画、计数器、需要和用户进行交互的复杂 UI 等。

### 2.3.2 **示意图：创建一个有状态的 `Widget()` 对象**
```dart
class Aaa extends StatefulWidget {
  @override // 重写父类的 createState()
  State<Aaa> createState() => _BbbState();
}

class _BbbState extends State<Aaa> {
  // 其它生命周期方法...
}


// 其它地方可以直接调用已经封装好的 widget 对象 Aaa()，不一定要声明变量接收保存
// Aaa() 是一个可以被 Flutter 框架识别并调用内置 build 方法实现渲染的widget
```

### 2.3.3 **`StatefulWidget` 生命周期**

在自定义的 `StatefulWidget` 组件对象中，生命周期分为以下几个阶段：

1. **`createState()`**：需要重写覆盖父类的方法 [必学]

2. **`initState()`**：需要调用父类的方法 [必学]

3. **`build()`**：需要重写覆盖父类的方法 [必学]

4. **`didChangeDependencies()`**：需要调用父类的方法 [选学]

5. **`deactivate()`**：需要调用父类的方法 [选学]

6. **`dispose()`**：需要调用父类的方法 [必学]

- ⚠️ 注意 ⚠️： **`setState()`**：并不是生命周期的一个阶段，它是一个管理状态的方法，用于触发 State 类的重新构建 [必学]
---
#### 2.3.3.1 **其它注意点**

* `initState()` 只会调用一次，适合做一次性初始化。
* `dispose()` 用来释放资源，避免内存泄漏。
* 在 `setState()` 中不做耗时操作，避免 UI 阻塞。
* `build()` 会频繁调用，不要在里面进行状态改变（比如不要在 `build()` 中调用 `setState()`）。

---

### 2.3.4 示例：完整的生命周期

```dart
import 'package:flutter/material.dart';

class LifecycleExample extends StatefulWidget {
  @override
  State<LifecycleExample> createState() => _LifecycleExampleState();
  //📌 Flutter 框架调用 createState(), 用于创建与 StatefulWidget 关联的 State 对象
}

class _LifecycleExampleState extends State<LifecycleExample> {
  String _text = 'I am a StatefulWidget';
  int count = 0;
  String _number = '';

  @override
  void initState() { //📌 initState() 只会被调用一次，通常用于初始化操作
   //📌 调用父类的 initState() 方法，确保父类的初始化操作被执行
    super.initState();
    //📌 初始化操作，如数据加载、订阅事件等
    _number = count.toString();
    print("initState: 组件被创建"); 
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies: 依赖发生变化");
  } // 依赖变化时调用

  //📌 build() 是构建 UI 的方法，首次插入组件树时会被调用一次（"初次构建"）
  //📌 当调用 setState() 时也会再次调用 build()（"重新构建"）
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
  } //📌 build() 被 Flutter 框架调用以渲染界面
  //📌 二次触发机制：setState() 或 didChangeDependencies()
//📌 用户点击 ElevatedButton() → 回调 _changeText() → 执行 setState() → 标记状态更新 → 下一帧重新调用 build() → UI 更新

  void _changeText() {
 //📌 当我们调用 setState() 时，它会标记当前的 State 对象为脏的（即需要重新构建 UI），并触发 Flutter 调用 build() 方法来重新渲染界面。   
    setState(() { 
      DateTime now = DateTime.now();
      _text =
          '状态已更新: ${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
      count++;
      _number = count.toString();
      print('setState 被调用，UI 即将更新');
    }); // 刷新 UI
  }

  //当组件从 widget 树中被移除但未销毁时调用 deactivate()（如导航时页面切换）
  //deactivate() 可能会被再次插入树中（会再调用 build）
  @override
  void deactivate() {
    super.deactivate();
    print("deactivate: 组件被移除"); // 从树中移除时调用
  }

  @override
  void dispose() { //📌 永久移除并销毁时调用 dispose()（如页面关闭或应用退出）
    //📌 清理你自己添加的资源
    super.dispose(); //📌 调用父类的 dispose 方法，清理框架层的资源
    print("dispose: 组件销毁，资源清理"); 
  }
}

void main() => runApp(MaterialApp(home: LifecycleExample()));
```
这个代码示例展示了 Flutter 中 `StatefulWidget` 的生命周期如何工作。当你运行这个代码时，组件会经历一系列生命周期方法的调用。以下是对这个过程的详细解释：

#### 🔍 怎么理解这个过程？

1. **`createState()`**

   * 这是 `StatefulWidget` 的第一次调用，用于创建与 `StatefulWidget` 关联的 `State` 对象。在这里，`LifecycleExample` 创建了 `_LifecycleExampleState` 对象，并在后续生命周期中对它进行操作。

2. **`initState()`**

   * 组件的初始化方法，只会在组件首次被插入树时调用一次。
   * 这里的 `initState` 主要用于初始化数据，比如将 `count` 转换为字符串并赋值给 `_number`，同时输出 `"initState: 组件被创建"` 来提示初始化。
   * 注意：你可以在这里进行一些初始化操作，比如数据加载，监听器注册等。

3. **`didChangeDependencies()`**

   * 每当组件的依赖发生变化时（例如 `InheritedWidget` 数据发生变化），这个方法会被调用。它在 `initState()` 之后第一次调用，且每当依赖变化时都会调用。
   * 在这个例子中，它打印 `"didChangeDependencies: 依赖发生变化"`，但是这个示例没有展示实际的依赖变化。

4. **`build()`**

   * `build()` 方法用于描述组件的 UI。当第一次构建界面时，它会被调用一次。
   * 在 `build()` 中，Flutter 框架会根据当前的 `State` 对象来绘制 UI。这里会输出 `"build: 构建 UI"` 来提示当前正在构建 UI。
   * 之后，每当调用 `setState()` 或依赖发生变化时，`build()` 会被重新调用，UI 会重新渲染。

5. **点击按钮触发 `setState()`**

   * 当用户点击 "Change Text" 按钮时，会调用 `_changeText()` 方法，进而调用 `setState()`。
   * `setState()` 会标记 `State` 对象为 "脏的"（需要重新构建）。它会触发重新调用 `build()` 方法来更新 UI。
   * 在 `setState()` 中，组件的 `_text` 状态和 `count` 计数器被更新，并将新的文本显示出来。

6. **`deactivate()`**

   * `deactivate()` 会在组件从树中被移除时调用（比如页面切换时）。
   * 在这个例子中，当组件不再显示时，`deactivate()` 会被调用并输出 `"deactivate: 组件被移除"`。
   * 如果该组件稍后重新插入到树中，`build()` 会再次被调用。

7. **`dispose()`**

   * `dispose()` 是当组件从树中被永久移除时调用的生命周期方法。通常用于清理资源，比如取消事件监听器，释放动画控制器等。
   * 在这个例子中，`dispose()` 会在组件销毁时输出 `"dispose: 组件销毁，资源清理"`。

#### 简化流程

1. **首次构建时：**

   * `createState()`
   * `initState()`
   * `didChangeDependencies()`
   * `build()`（首次构建 UI）

2. **点击按钮后：**

   * `setState()` 被调用，更新状态
   * 触发 `build()` 方法重新构建 UI

3. **页面切换时：**

   * `deactivate()`（从树中移除）
   * 如果该组件重新插入，`build()` 会再次调用

4. **页面销毁时：**

   * `dispose()`（清理资源）

通过这个过程，Flutter 管理了状态的变化和界面的更新。在 `setState()` 触发时，Flutter 会检查哪些部分需要重新构建，并高效地更新 UI。

---

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

`build` 函数是 `Widget` 类中的一个抽象方法，所有 `widget` 都必须实现它。换句话说，所有的 `widget` （无论有无状态）内部都必须有 `build` 方法，因为当 Flutter 需要渲染一个 `widget` 时，会调用它的 `build` 方法（否则 Flutter 无法渲染）。

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
在 `StatefulWidget` 中，`build` 方法位于对应的 `State` 类中：
```dart
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  // build 方法位于对应的 State 类中
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

##### 1. **调用 `runApp()`**

* **`runApp()`** 是 Flutter 应用的入口函数，它会启动应用并把指定的 Widget 树传递给 Flutter 引擎进行渲染。
* 在这个例子中，`runApp()` 接收 `MaterialApp` 作为根 Widget，而 `MaterialApp` 中的 `home` 参数则传入了 `Banana()`。

##### 2. **创建 `Banana` 实例**

* `Banana` 是一个 `StatefulWidget`，当 `Banana()` 被传入 `MaterialApp` 时，Flutter 会执行 `createState()` 方法来创建 `Banana` 组件的状态对象。

##### 3. **执行 `createState()`**

* `createState()` 方法返回了 `_BananaState` 实例。`_BananaState` 是与 `Banana` 组件关联的状态类，负责管理组件的状态和渲染。
* 在这一步，`Banana` 的状态对象（`_BananaState`）被创建。

##### 4. **`_BananaState` 的生命周期开始**

* 当 `Banana` 的 `State` 被创建后，框架会调用 `State` 类的 `build()` 方法来渲染 UI。
* 在 `build()` 方法中，`Scaffold` 组件构建了应用的 UI，其中包含了一个 `AppBar` 和一个带有黄色背景的 `Container`，并且在 `Container` 中显示了文本 `'好棒哦'`。

##### 5. **渲染 UI**

* `build()` 方法返回一个新的 Widget 树（`Scaffold`），这个 Widget 树描述了该页面的 UI。
* Flutter 框架会根据这个 Widget 树渲染界面并显示在屏幕上。

##### 6. **生命周期完整性**

* 在 `State` 对象的生命周期中，`initState()` 会在 `build()` 之前调用，但是在这个例子中 `initState()` 没有被覆盖，所以它没有被触发。
* 如果你添加了 `setState()` 调用，`build()` 方法会被重新调用，从而更新 UI。

##### 总结

1. **`runApp()`** 启动应用并传入 `MaterialApp`，它包含了 `Banana()` 作为 `home` 页面。
2. **`createState()`** 被调用，创建 `Banana` 组件的状态对象 `_BananaState`。
3. **`_BananaState` 的 `build()`** 被调用，构建并返回 UI。
4. 最终，Flutter 框架渲染并显示 `Scaffold`，其中包含了 `AppBar` 和 `Container`。

通过这种方式，Flutter 会根据 `StatefulWidget` 的状态和生命周期管理 UI 的更新和重新渲染。

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
### 3.1.1 `Scaffold`
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

### 3.1.2 `Container` 和 `Text` 
#### 3.1.2.1 `Container` 和 `Text` 的示例代码
`Container` 常常搭配 `Text` 使用
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
        appBar: AppBar(title: Text('Container的示例代码')),
        body: Container(
          alignment: Alignment.center,
          child: Container(
            color: Colors.yellow,
            width: 100,
            height: 100,
            child: Text('请在这里输入你想展示的字'),
          ),
        ),
      ),
    );
  }
}
```

#### 3.1.2.2 `Container` 的基本属性

| 属性名               | 类型                | 说明                 |
| ----------------- | ----------------- | ------------------ |
| `width`           | `double`          | 宽度                 |
| `height`          | `double`          | 高度                 |
| `margin`          | `EdgeInsets`      | 外边距（容器与外部元素之间的距离）  |
| `padding`         | `EdgeInsets`      | 内边距（容器内内容与边界之间的距离） |
| `decoration`      | `BoxDecoration`   | 背景装饰（颜色、圆角、阴影、边框等） |
| └─ `color`        | `Color`           | 背景颜色               |
| └─ `borderRadius` | `BorderRadius`    | 圆角处理，可整体或分别设置四个角   |
| └─ `boxShadow`    | `List<BoxShadow>` | 阴影效果，模糊半径、颜色等      |
| `child`           | `Widget`          | 容器内的子组件            |

---
```dart
Container(
  width: 200, // 宽
  height: 200, // 高
  margin: EdgeInsets.all(10), // 外边距
  padding: EdgeInsets.only(left: 10, top: 5, right: 0, bottom: 0), // 内边距
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

#### 3.1.2.3 `Container` 的 `alignment` 属性和 `Center` 组件
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

#### 3.1.2.4 `Container` 的其它属性
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

#### 3.1.2.5 `Container` 常用属性总结
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

#### 3.1.2.6 `Text` 和 `SelectableText`
下面是 `Text` 和 `SelectableText` 在 Flutter 中常用的属性对比说明，包括它们各自支持的主要功能，方便你快速查阅和理解。

---

##### 3.1.2.6.1  `Text` 常用属性

| 属性名               | 类型              | 说明                                 |
| ----------------- | --------------- | ---------------------------------- |
| `data`            | `String`        | 要显示的文本内容                           |
| `style`           | `TextStyle`     | 设置字体大小、颜色、粗细、行距等                   |
| `textAlign`       | `TextAlign`     | 文本对齐方式：`left`、`right`、`center` 等   |
| `maxLines`        | `int`           | 最多显示几行文本                           |
| `overflow`        | `TextOverflow`  | 超出部分的显示方式：`clip`、`ellipsis`、`fade` |
| `softWrap`        | `bool`          | 是否自动换行                             |
| `textScaleFactor` | `double`        | 缩放比例（如用于响应系统字体缩放）                  |
| `textDirection`   | `TextDirection` | 文本方向（如从左到右或从右到左）                   |
| `locale`          | `Locale`        | 文本本地化区域设置                          |
| `strutStyle`      | `StrutStyle`    | 控制行高和排版的高级属性                       |

---

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text 属性演示',
      home: TextDemoPage(),
    );
  }
}

class TextDemoPage extends StatelessWidget {
  final String longText = 'Hello, Flutter! 这是一个演示 Text 组件属性的例子。'
      '请注意文字对齐、颜色、大小、缩放、截断等效果。这个文本会很长，以便演示截断和换行。';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text 属性演示')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              longText,
              style: TextStyle(
                fontSize: 18,        // 字体大小
                color: Colors.blue,  // 字体颜色
              ),
              textAlign: TextAlign.center,       // 文本居中对齐
              maxLines: 2,                       // 最多显示2行
              overflow: TextOverflow.ellipsis,   // 超出部分用 ... 省略
              softWrap: true,                    // 自动换行
              textScaleFactor: 1.2,              // 缩放比例（系统文字缩放影响）
            ),
            SizedBox(height: 20),
            Text(
              '属性说明：\n'
              'fontSize = 18\n'
              'color = blue\n'
              'textAlign = center\n'
              'maxLines = 2\n'
              'overflow = ellipsis\n'
              'softWrap = true\n'
              'textScaleFactor = 1.2',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
```

##### 3.1.2.6.2  `SelectableText` 常用属性

```dart
SelectableText(
  'This is selectable',
  style: TextStyle(fontSize: 18),
  textAlign: TextAlign.center,
  showCursor: true,
  cursorColor: Colors.red,
  cursorWidth: 2.0,
  toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
  onTap: () => print('点击了文本'),
)
```

| 属性名                          | 类型               | 说明               |
| ---------------------------- | ---------------- | ---------------- |
| `data`                       | `String`         | 要显示的可选中文本        |
| `style`                      | `TextStyle`      | 字体样式             |
| `textAlign`                  | `TextAlign`      | 对齐方式             |
| `showCursor`                 | `bool`           | 是否显示光标（默认 false） |
| `cursorColor`                | `Color`          | 光标颜色             |
| `cursorWidth`                | `double`         | 光标宽度             |
| `toolbarOptions`             | `ToolbarOptions` | 允许的操作（复制、全选等）    |
| `onTap`                      | `VoidCallback`   | 点击回调             |
| `textDirection`              | `TextDirection`  | 文本方向             |
| `maxLines`                   | `int`            | 最多显示多少行          |
| `scrollPhysics`              | `ScrollPhysics`  | 滚动行为控制（适用于长文本）   |
| `textScaleFactor`            | `double`         | 缩放比例             |
| `enableInteractiveSelection` | `bool`           | 是否启用选择（默认为 true） |

---

##### 3.1.2.6.3 总结建议

* ✅ 你只显示文字、不需要用户复制、编辑：用 `Text`。
* ✅ 你希望用户能长按选择或复制内容：用 `SelectableText`。

### 3.1.3 `Padding`
```dart
Padding(
  padding: EdgeInsets.all(16), // 四周16像素边距
  child: Text('Hello, Flutter!'),
)
```

### 3.1.4 `ConstrainedBox`
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

### 3.1.5 `SizedBox`
```dart
SizedBox(width: 50), // 水平占位空白
SizedBox(height: 80), // 垂直占位空白
```

### 3.1.6 `ClipRRect`
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

### 3.1.7 组件的 `key` 属性
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
### 3.2.1 `Row` 和 `Column`
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

### 3.2.2 `Row` 和 `Column` 常用属性总结
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

### 3.2.3 `Expanded` 和 `Spacer`
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

### 3.2.4 `Wrap`
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

### 3.2.5 `IntrinsicWidth` 和 `IntrinsicHeight`
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
### 3.3.1 `SingleChildScrollView`
`SingleChildScrollView` 是 Flutter 中用于 **使单个子组件可以滚动** 的组件，适用于内容不确定或内容可能超出屏幕但不需要复杂列表的情况。

---

#### 3.3.1.1 基本用法

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

#### 3.3.1.2 核心特点

| 特性        | 说明                                  |
| --------- | ----------------------------------- |
| 只能有一个子组件  | 一般配合 `Column`、`Row`、`Container` 等使用 |
| 适合少量可滚动内容 | 比如表单、静态布局超出屏幕的情况                    |
| 默认垂直方向滚动  | 可通过 `scrollDirection` 修改为水平         |

---

#### 3.3.1.3 示例代码

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

#### 3.3.1.4 注意事项：

* 不适合用于大量子组件（请使用 `ListView`）。
* 子组件不能有无限高度（如 `Column` + 未限制高度的 `Expanded` 可能报错）。

### 3.3.2 `ListView.builder`
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

### 3.3.3 `ListTile`
在 Flutter 中，`ListTile` 是一个非常常用的组件，它用来构建「列表中的一行内容」，比如设置页面的每一项、消息列表、联系人条目等。它已经封装好了一整套常见的布局：**图标 + 标题 + 副标题 + 尾部图标/按钮**。

---

#### 3.3.3.1 基本用法

```dart
ListTile(
  leading: Icon(Icons.account_circle),     // 左侧图标
  title: Text('张三'),                     // 主标题
  subtitle: Text('Flutter 开发者'),        // 副标题
  trailing: Icon(Icons.arrow_forward_ios), // 右侧图标
  onTap: () {
    print('点击了张三');
  },
)
```

效果：
- 👤 张三
- Flutter 开发者 → ➡️

---

#### 3.3.3.2 常用参数说明

| 参数          | 说明              |
| ----------- | --------------- |
| `leading`   | 左侧部件（通常是图标或头像）  |
| `title`     | 主标题（必须）         |
| `subtitle`  | 副标题（可选）         |
| `trailing`  | 右侧部件（如箭头、按钮、数字） |
| `onTap`     | 点击事件            |
| `selected`  | 是否选中（配合颜色等状态）   |
| `dense`     | 紧凑模式            |
| `enabled`   | 是否启用（默认启用）      |
| `tileColor` | 背景颜色            |

---

#### 3.3.3.3 实用示例合集

##### 3.3.3.3.1 简单条目

```dart
ListTile(
  title: Text('设置'),
  onTap: () => print('点击设置'),
)
```

##### 3.3.3.3.2 设置页面样式

```dart
ListTile(
  leading: Icon(Icons.settings),
  title: Text('设置'),
  trailing: Icon(Icons.arrow_forward_ios),
  onTap: () => print('点击设置'),
)
```

##### 3.3.3.3.3  联系人样式

```dart
ListTile(
  leading: CircleAvatar(
    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
  ),
  title: Text('李四'),
  subtitle: Text('在线中...'),
  trailing: Icon(Icons.chat),
  onTap: () => print('开始聊天'),
)
```

##### 3.3.3.3.4  禁用状态（不可点击）

```dart
ListTile(
  title: Text('不可用项'),
  enabled: false,
)
```

---

#### 3.3.3.4 搭配 `Card` 使用

```dart
Card(
  child: ListTile(
    leading: Icon(Icons.email),
    title: Text('邮箱'),
    subtitle: Text('example@example.com'),
    trailing: Icon(Icons.edit),
    onTap: () => print('点击邮箱卡片'),
  ),
)
```

---

#### 3.3.3.5 多个 `ListTile` 构建列表

```dart
ListView(
  children: [
    ListTile(title: Text('项 1')),
    Divider(),
    ListTile(title: Text('项 2')),
    Divider(),
    ListTile(title: Text('项 3')),
  ],
)
```

---

#### 3.3.3.5 总结

* `ListTile` 是构建标准列表项最方便的方式；
* 你可以快速构建包含图标、标题、说明、按钮的列表结构；
* 配合 `ListView`、`Card`、`Divider` 可以构建完整页面。

### 3.3.4 `GridView.builder`
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

### 3.3.5 `ScrollController`
#### 3.3.5.1
| 功能          | 说明                                                                                            |
| ----------- | --------------------------------------------------------------------------------------------- |
| **获取滚动位置**  | `controller.offset`（当前偏移值） |
| **获取最大滚动距离**  | `controller.position.maxScrollExtent`：获取可滚动的最大距离（内容总高度 - 视口高度），用于判断是否触底。 |
| **滚动到指定位置** | `controller.jumpTo(offset)`：直接跳转，无动画<br>`controller.animateTo(offset, duration, curve)`：带动画滚动 |
| **监听滚动事件**  | `controller.addListener(() { ... })`：每次滚动时都会触发，可用于监听滚动距离、触底等 |
| **释放控制器资源**  | `controller.dispose()`：释放 `ScrollController` 占用的资源（移除监听器，避免内存泄漏）。 |

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
#### 3.3.5.2 小提示：

* 结合 `controller.position.maxScrollExtent` 可判断是否滚动到底部；
* 使用 `controller.dispose()` 释放资源，避免内存泄露；
* 可在 `initState()` 中初始化监听器。
---

### 3.3.6 `CustomScrollView`

#### 3.3.6.1 `CustomScrollView` 是什么？

在 Flutter 中，`CustomScrollView` 是一个可以组合多个 **sliver**（“滑块”）的滚动视图。通过它你可以创建灵活而强大的滚动界面，比如带有可折叠 AppBar 的列表、网格等。

---

#### 3.3.6.2 常用的 Sliver 类型：

| Sliver 组件            | 作用说明                   |
| -------------------- | ---------------------- |
| `SliverAppBar`       | 可滚动的 AppBar，支持折叠       |
| `SliverList`         | 列表                     |
| `SliverGrid`         | 网格布局                   |
| `SliverToBoxAdapter` | 将普通 Widget 放入 sliver 中 |

---

#### 3.3.6.3 一个简单的示例：

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('标题'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text('列表项 #$index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
#### 3.3.6.4 使用场景：

* 需要一个可折叠的头部（比如图片 + 标题）
* 在一个页面中组合列表、网格、普通 Widget 等多种布局
* 实现复杂的滚动效果，比如动态加载、吸顶效果等

### 3.3.7 `NestedScrollView`
在 Flutter 中，`NestedScrollView` 是一个用于处理 **嵌套滚动** 的控件，尤其适合实现 **AppBar + TabBar + 每个 Tab 内有自己的滚动内容** 的场景。

---

#### 3.3.7.1 它解决了什么问题？

当你使用 `TabBarView` + 每个页面都是 `ListView` 或 `GridView` 时，普通的 `CustomScrollView` 无法处理「外部滚动+内部滚动」的配合，比如：

* 顶部 `AppBar` 折叠时，内部的 `ListView` 能接管滚动。
* `TabBar` 吸顶不动，下面是每个 Tab 的内容滚动。

---

#### 3.3.7.2 关键点说明：

| 属性/方法                             | 说明                                 |
| --------------------------------- | ---------------------------------- |
| `headerSliverBuilder`             | 构建顶部可滚动区域（如 SliverAppBar + TabBar） |
| `body`                            | 通常是 TabBarView，每个 tab 是一个列表或其他滚动内容 |
| `pinned: true`                    | AppBar 固定在顶部                       |
| `TabBar` 放在 `SliverAppBar.bottom` | 才能实现吸顶效果                           |

---

#### 3.3.7.3 基本结构示例

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NestedScrollViewExample(),
    );
  }
}

class NestedScrollViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.0,
                pinned: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('NestedScrollView 示例'),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                    Tab(text: 'Tab 3'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: List.generate(3, (index) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 30,
                itemBuilder: (context, i) {
                  return ListTile(title: Text('第 $index 页 - 项目 $i'));
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
```

## 3.4 Material Design组件
### 3.4.1 `AppBar`
`AppBar` 是 Flutter 中一个非常常见的组件，它通常用于显示应用程序的顶部栏。`AppBar` 是一个 **Material Design 风格** 的组件，通常包含应用的标题、图标、按钮等元素。

#### 3.4.1.1 **基本用法**

`AppBar` 通常作为 `Scaffold` 的 `appBar` 属性来使用，定义在 `Scaffold` 内部。以下是最基本的 `AppBar` 用法：

```dart
AppBar(
  title: Text('My App'), // 标题
)
```

---

#### 3.4.1.2 **常用参数**

| 参数                | 说明                                 |
| ----------------- | ---------------------------------- |
| `title`           | 显示在 `AppBar` 中的标题，一般是一个 `Text` 小部件 |
| `backgroundColor` | `AppBar` 的背景颜色                     |
| `leading`         | `AppBar` 左侧的部件，通常是一个图标按钮（例如返回按钮）   |
| `actions`         | `AppBar` 右侧的部件，可以放置按钮、图标等          |
| `elevation`       | `AppBar` 的阴影效果，默认值为 4.0            |
| `centerTitle`     | 是否将标题居中显示，默认为 `true`               |

---

#### 3.4.1.3 **简单示例**

这是一个包含标题和背景颜色的简单 `AppBar` 示例：

```dart
Scaffold(
  appBar: AppBar(
    title: Text('我的应用'),
    backgroundColor: Colors.blue, // 设置背景颜色
  ),
  body: Center(
    child: Text('内容区'),
  ),
);
```

---

#### 3.4.1.4 **带图标和按钮的 AppBar**

你还可以在 `AppBar` 中放置图标按钮，常见的操作如搜索、设置、返回等按钮。可以通过 `leading` 和 `actions` 来实现。

```dart
Scaffold(
  appBar: AppBar(
    title: Text('我的应用'),
    backgroundColor: Colors.blue,
    leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        // 菜单按钮被点击时的操作
        print('菜单按钮点击');
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // 搜索按钮被点击时的操作
          print('搜索按钮点击');
        },
      ),
    ],
  ),
  body: Center(
    child: Text('内容区'),
  ),
);
```

#### 3.4.1.5 解释：

* `leading`：在左侧放置一个 `menu` 图标按钮。
* `actions`：在右侧放置一个 `search` 图标按钮。

---

#### 3.4.1.6 **带有返回按钮的 AppBar**

如果你需要在 `AppBar` 中显示一个返回按钮，可以通过 `leading` 来放置一个返回图标按钮：

```dart
Scaffold(
  appBar: AppBar(
    title: Text('我的页面'),
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // 返回按钮的点击事件
        Navigator.pop(context); // 返回到上一页面
      },
    ),
  ),
  body: Center(
    child: Text('内容区'),
  ),
);
```

在这个例子中，`Navigator.pop(context)` 会关闭当前页面并返回上一页。

---

#### 3.4.1.7 **总结**

`AppBar` 是 Flutter 中一个非常强大的组件，具有高度的可定制性。你可以根据需要选择不同的颜色、图标和操作按钮，使得应用的顶部栏符合你的需求。

如果你有特殊需求，比如实现一个带有滚动效果的 `AppBar` 或者需要更复杂的布局，`AppBar` 也有很多高级用法，可以通过 `FlexibleSpaceBar` 或其他自定义部件来进一步扩展。

### 3.4.2 `BottomNavigationBar`
`BottomNavigationBar` 是 Flutter 中一个常用的底部导航栏组件，通常用于应用的底部，提供多个导航选项，用户可以通过点击底部图标快速切换页面。

#### 3.4.2.1 **基本用法**

`BottomNavigationBar` 通过 `Scaffold` 的 `bottomNavigationBar` 属性来使用，它可以包含多个 `BottomNavigationBarItem`，每个项对应一个标签和一个图标。

---

#### 3.4.2.2 **常用参数**

| 参数                    | 说明                                           |
| --------------------- | -------------------------------------------- |
| `currentIndex`        | 当前选中的索引，默认为 0                                |
| `onTap`               | 用户点击底部导航项时的回调函数                              |
| `items`               | `BottomNavigationBarItem` 的列表，包含多个选项         |
| `selectedItemColor`   | 选中项的颜色（图标和文本）                                |
| `unselectedItemColor` | 未选中项的颜色（图标和文本）                               |
| `type`                | `BottomNavigationBarType`，定义导航栏的类型（固定、启用动画等） |
| `backgroundColor`     | 底部导航栏的背景颜色                                   |

---

#### 3.4.2.3 **简单示例**

这是一个基本的 `BottomNavigationBar` 示例，包含 3 个导航项：

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavigationExample(),
    );
  }
}

class BottomNavigationExample extends StatefulWidget {
  @override
  _BottomNavigationExampleState createState() => _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _currentIndex = 0; // 当前选中的索引

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // 更新索引
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar 示例'),
      ),
      body: Center(
        child: Text('当前选中项: $_currentIndex'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // 当前选中的索引
        onTap: _onItemTapped, // 点击时的回调函数
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '搜索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '个人中心',
          ),
        ],
      ),
    );
  }
}
```

---

#### 3.4.2.4 **关键点解释**

* `currentIndex`：当前选中的导航项的索引（从 0 开始），当用户点击导航项时，会更新为该项的索引。
* `onTap`：用户点击底部导航项时会触发的回调函数，接收点击项的索引作为参数。
* `items`：这是一个 `BottomNavigationBarItem` 列表，每个 `BottomNavigationBarItem` 可以包含图标和标签。

---

#### 3.4.2.5 **更多自定义**

##### 1. **自定义选中和未选中项的颜色**

可以通过 `selectedItemColor` 和 `unselectedItemColor` 来控制选中项和未选中项的颜色：

```dart
BottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: _onItemTapped,
  selectedItemColor: Colors.blue,  // 选中项的颜色
  unselectedItemColor: Colors.grey, // 未选中项的颜色
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: '搜索',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: '个人中心',
    ),
  ],
)
```

##### 2. **固定的底部导航栏（不使用动画）**

通过设置 `type` 为 `BottomNavigationBarType.fixed`，可以确保底部导航栏不会使用动画效果：

```dart
BottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: _onItemTapped,
  type: BottomNavigationBarType.fixed, // 固定模式（没有动画）
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: '搜索',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: '个人中心',
    ),
  ],
)
```

##### 3. **带有背景颜色的底部导航栏**

你还可以自定义底部导航栏的背景颜色：

```dart
BottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: _onItemTapped,
  backgroundColor: Colors.black, // 设置底部导航栏的背景颜色
  selectedItemColor: Colors.white, // 选中项的颜色
  unselectedItemColor: Colors.grey, // 未选中项的颜色
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: '搜索',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: '个人中心',
    ),
  ],
)
```
---

#### 3.4.2.6 **总结**

`BottomNavigationBar` 是实现底部导航非常方便的组件，适用于具有多个页面的应用。你可以通过以下几种方式进行自定义：

* 选中项和未选中项的颜色
* 底部导航栏的背景颜色
* 添加不同的导航项
* 通过 `onTap` 控制页面切换

### 3.4.3 `FloatingActionButton`
`FloatingActionButton` 是 Flutter 中一个常用的浮动按钮，通常用于执行最主要的操作。它通常位于屏幕的右下角，具有 **圆形** 和 **浮动** 的视觉效果，非常适合用来执行关键功能，比如添加、编辑或提交。

#### 3.4.3.1 **基本用法**

`FloatingActionButton` 是 `Scaffold` 中的一个属性，它显示在屏幕的右下角，通常用于触发应用中的主要操作。

```dart
Scaffold(
  appBar: AppBar(
    title: Text('FloatingActionButton 示例'),
  ),
  body: Center(
    child: Text('点击浮动按钮'),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      // 按钮点击时的操作
      print('浮动按钮被点击');
    },
    child: Icon(Icons.add), // 按钮上的图标
  ),
);
```

---

#### 3.4.3.2 **常用参数**

| 参数                | 说明                     |
| ----------------- | ---------------------- |
| `onPressed`       | 按钮被点击时的回调函数            |
| `child`           | 按钮中的小部件，通常是一个图标或文本     |
| `backgroundColor` | 按钮的背景颜色                |
| `foregroundColor` | 按钮内容的颜色（如图标或文本）        |
| `elevation`       | 按钮的阴影效果，默认为 6.0        |
| `shape`           | 按钮的形状，默认为圆形，可以设置为其他形状  |
| `mini`            | 是否显示为迷你按钮（默认为 `false`） |

---

#### 3.4.3.3 **简单示例**

这是一个基本的 `FloatingActionButton` 示例，点击按钮时会执行一个操作（如打印日志）。

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FloatingActionButton 示例'),
        ),
        body: Center(
          child: Text('点击按钮'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('浮动按钮点击');
          },
          child: Icon(Icons.add), // 按钮上的图标
        ),
      ),
    );
  }
}
```

---

#### 3.4.3.4 **带图标和颜色的浮动按钮**

你可以通过 `child` 来设置按钮的内容，通常是一个图标或文本。此外，还可以设置按钮的背景颜色、前景颜色等属性。

```dart
Scaffold(
  appBar: AppBar(
    title: Text('浮动按钮颜色示例'),
  ),
  body: Center(
    child: Text('点击浮动按钮'),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      print('按钮被点击');
    },
    child: Icon(Icons.add),
    backgroundColor: Colors.blue, // 设置背景颜色
    foregroundColor: Colors.white, // 设置图标颜色
  ),
);
```

---

#### 3.4.3.5 **迷你浮动按钮**

你可以通过设置 `mini: true` 来创建一个迷你版本的浮动按钮，通常用于需要节省空间或显示更多控件的场景。

```dart
Scaffold(
  appBar: AppBar(
    title: Text('迷你浮动按钮示例'),
  ),
  body: Center(
    child: Text('点击迷你浮动按钮'),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      print('迷你按钮被点击');
    },
    child: Icon(Icons.add),
    mini: true, // 设置为迷你按钮
  ),
);
```

---

#### 3.4.3.6 **自定义形状的浮动按钮**

通过 `shape` 参数，你可以自定义浮动按钮的形状。默认是圆形按钮，但你可以设置为矩形、圆角矩形等。

```dart
Scaffold(
  appBar: AppBar(
    title: Text('自定义形状浮动按钮示例'),
  ),
  body: Center(
    child: Text('点击自定义形状浮动按钮'),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      print('自定义形状按钮被点击');
    },
    child: Icon(Icons.add),
    shape: RoundedRectangleBorder( // 设置矩形形状
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
```

---

#### 3.4.3.7 **总结**

`FloatingActionButton` 是一个非常灵活且常用的按钮组件，适合用于应用中的重要操作。你可以通过以下方式定制按钮的外观和行为：

* 改变按钮的颜色
* 使用迷你按钮
* 自定义按钮形状
* 为按钮添加图标或文本

### 3.4.4 `CircularProgressIndicator`
#### 3.4.4.1 按一下加载一下 —— Flutter 初学者必学交互操作

在手机 App 中，我们经常会遇到这样的操作场景：

> 用户点击一个按钮，出现加载动画，几秒后显示结果。

在 Flutter 中，这可以通过以下两个核心知识点实现：

* `CircularProgressIndicator`：圆形加载动画
* `Future.delayed` + `setState()`：模拟加载过程并刷新界面

---

#### 3.4.4.2 效果图解

```
[ 点击按钮 ]
      ↓
[ 显示加载圈 ]
      ↓ 0.5 秒后
[ 显示“加载完成！”]
```

---

#### 3.4.4.3 关键组件介绍

| 名称                          | 用法说明              |
| --------------------------- | ----------------- |
| `CircularProgressIndicator` | 显示加载动画（小圈圈转啊转）    |
| `ElevatedButton`            | 用户点击的按钮           |
| `setState()`                | 用来刷新界面            |
| `Future.delayed()`          | 延迟一段时间后执行操作（模拟加载） |

---

#### 3.4.4.4 示例：按一下加载一下（加载 0.5 秒）

下面是一个完整、最简单的例子，适合新手直接练习：

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingDemo(),
    );
  }
}

class LoadingDemo extends StatefulWidget {
  @override
  _LoadingDemoState createState() => _LoadingDemoState();
}

class _LoadingDemoState extends State<LoadingDemo> {
  bool _isLoading = false; // 控制是否显示加载动画
  String _text = '点击按钮开始加载'; // 显示提示文字

  void _onButtonPressed() {
    setState(() {
      _isLoading = true;    // 显示加载圈
      _text = '';           // 清空文字
    });

    // 模拟加载过程：0.5 秒后恢复
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;   // 停止加载
        _text = '加载完成！🎉'; // 显示结果
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('按一下加载一下')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 如果在加载就显示圆圈，否则显示提示文字
            _isLoading
                ? CircularProgressIndicator()
                : Text(
                    _text,
                    style: TextStyle(fontSize: 22),
                  ),
            SizedBox(height: 30),
            // 按钮：在加载中禁用
            ElevatedButton(
              onPressed: _isLoading ? null : _onButtonPressed,
              child: Text('点击加载'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

#### 3.4.4.5 小结

| 技能点                               | 说明               |
| --------------------------------- | ---------------- |
| 状态管理（`setState`）                  | 改变界面内容（加载圈 → 文字） |
| 加载动画（`CircularProgressIndicator`） | 提示用户正在加载         |
| 异步操作（`Future.delayed`）            | 模拟网络请求或耗时操作      |

---

如果你刚开始学 Flutter，这个例子可以帮你练习：

* 按钮交互
* 动态更新界面
* 控制加载状态



### 3.4.5 `TabBar` 和 `TabBarView` 和 `TabController`
在 Flutter 中，`TabBar` 是用于创建顶部标签切换导航的组件，通常与 `TabBarView` 一起使用，实现多个页面（或内容区域）之间的切换。

---

#### 3.4.5.1 最基本的结构（必须和 TabController 一起使用）

```dart
DefaultTabController(
  length: 3, // 标签数量
  child: Scaffold(
    appBar: AppBar(
      title: Text('TabBar 示例'),
      bottom: TabBar(
        tabs: [
          Tab(text: '首页'),
          Tab(text: '消息'),
          Tab(text: '我的'),
        ],
      ),
    ),
    body: TabBarView(
      children: [
        Center(child: Text('首页内容')),
        Center(child: Text('消息内容')),
        Center(child: Text('我的内容')),
      ],
    ),
  ),
)
```

---

#### 3.4.5.2 常用属性

##### TabBar

| 参数                     | 说明                       |
| ---------------------- | ------------------------ |
| `tabs`                 | 标签列表（一般是 `Tab` 或 Widget） |
| `isScrollable`         | 是否可以滑动                   |
| `indicatorColor`       | 指示器颜色                    |
| `labelColor`           | 选中标签颜色                   |
| `unselectedLabelColor` | 未选中标签颜色                  |
| `indicatorWeight`      | 指示器高度                    |

##### TabBarView

| 参数         | 说明               |
| ---------- | ---------------- |
| `children` | 每个标签对应的内容 Widget |
| `physics`  | 滚动方式（可禁止滑动等）     |

---

#### 3.4.5.3 示例：图标 + 文字标签

```dart
TabBar(
  tabs: [
    Tab(icon: Icon(Icons.home), text: '首页'),
    Tab(icon: Icon(Icons.message), text: '消息'),
    Tab(icon: Icon(Icons.person), text: '我的'),
  ],
)
```

---

#### 3.4.5.4 示例：可滑动的 TabBar

```dart
TabBar(
  isScrollable: true, // 标签很多时可滑动
  tabs: List.generate(10, (index) => Tab(text: '标签$index')),
)
```

---

#### 3.4.5.5 示例：嵌套在页面中间而不是 AppBar（常用于分类页）

```dart
DefaultTabController(
  length: 2,
  child: Column(
    children: [
      TabBar(
        tabs: [Tab(text: '男装'), Tab(text: '女装')],
      ),
      Expanded(
        child: TabBarView(
          children: [
            Center(child: Text('男装内容')),
            Center(child: Text('女装内容')),
          ],
        ),
      ),
    ],
  ),
)
```

---

#### 3.4.5.6 总结

* `TabBar` 是顶部导航栏，搭配 `TabBarView` 实现内容切换；
* 必须嵌套在 `DefaultTabController` 或自己手动控制的 `TabController` 中；
* 非常适合分类导航、页面切换、顶部多标签等 UI 场景。

### 3.4.6 `AlertDialog`
在 Flutter 中，`AlertDialog` 是一个用于展示弹出式对话框的组件，常用于提示信息、确认操作、用户选择等。

比如：

* 提醒用户是否要删除？
* 提交成功提示
* 登录失败提示等。

---

#### 3.4.6.1 最基本用法：显示一个对话框
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'AlertDialog 示例', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('提示'),
            content: Text('你确定要删除吗？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // 关闭弹窗
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  // 删除操作逻辑
                  print('用户点击了确定');
                  Navigator.pop(context); // 关闭弹窗
                },
                child: Text('确定'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AlertDialog 示例')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showDeleteDialog(context),
          child: Text('删除数据'),
        ),
      ),
    );
  }
}
```

---

#### 3.4.6.2 解释各部分

| 部位        | 说明             |
| --------- | -------------- |
| `title`   | 标题（可选）         |
| `content` | 内容区域（可放文字、图片等） |
| `actions` | 底部按钮列表（可放多个按钮） |

---

#### 3.4.6.3 示例：单个按钮的提示框

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('成功'),
    content: Text('你的资料已提交成功！'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('好的'),
      ),
    ],
  ),
);
```

---

#### 3.4.6.4 示例：带图标和自定义内容

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Row(
      children: [
        Icon(Icons.warning, color: Colors.red),
        SizedBox(width: 8),
        Text('警告'),
      ],
    ),
    content: Text('该操作不可恢复，确定继续吗？'),
    actions: [
      TextButton(
        child: Text('取消'),
        onPressed: () => Navigator.pop(context),
      ),
      ElevatedButton(
        child: Text('删除'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          // 删除操作
          Navigator.pop(context);
        },
      ),
    ],
  ),
);
```

---

#### 3.4.6.5 总结

* `AlertDialog` 是显示提示框的首选组件；
* 用 `showDialog` 方法打开；
* 可以显示标题、内容、多个按钮；
* 通常搭配 `TextButton`, `ElevatedButton` 作为交互项。

---

📌 **注意：** 弹框不会自动消失，除非你手动调用 `Navigator.pop(context)` 来关闭。

## 3.5 交互组件
### 3.5.1 `GestureDetector`
`GestureDetector` 是 Flutter 中用来监听用户手势的一个非常强大的组件，它能够识别多种用户交互行为（如点击、滑动、拖动、缩放等），并且可以在任何 Widget 上应用，因此非常适合用来创建自定义的交互体验。

#### 3.5.1.1 **常见手势识别**

* **Tap（点击）**
* **DoubleTap（双击）**
* **LongPress（长按）**
* **Pan（拖动）**
* **Scale（缩放）**
* **Vertical/Horizontal Drag（竖直/水平拖动）**

---

#### 3.5.1.2 最基本的用法（点击事件）

```dart
GestureDetector(
  onTap: () {
    print('点击了区域');
  },
  child: Container(
    padding: EdgeInsets.all(20),
    color: Colors.blue,
    child: Text('点击我', style: TextStyle(color: Colors.white)),
  ),
)
```

#### 3.5.1.3 解释：

* 当用户点击这个 `Container` 时，会触发 `onTap` 事件，控制台会输出“点击了区域”。

---

#### 3.5.1.4 常用手势处理

##### 1. **单击（Tap）**

```dart
GestureDetector(
  onTap: () {
    print('单击事件');
  },
  child: Container(
    padding: EdgeInsets.all(20),
    color: Colors.green,
    child: Text('单击我'),
  ),
)
```

##### 2. **双击（DoubleTap）**

```dart
GestureDetector(
  onDoubleTap: () {
    print('双击事件');
  },
  child: Container(
    padding: EdgeInsets.all(20),
    color: Colors.orange,
    child: Text('双击我'),
  ),
)
```

##### 3. **长按（LongPress）**

```dart
GestureDetector(
  onLongPress: () {
    print('长按事件');
  },
  child: Container(
    padding: EdgeInsets.all(20),
    color: Colors.purple,
    child: Text('长按我'),
  ),
)
```

##### 4. **拖动（Pan）**

```dart
GestureDetector(
  onPanUpdate: (details) {
    print('拖动位置: ${details.localPosition}');
  },
  child: Container(
    padding: EdgeInsets.all(20),
    color: Colors.red,
    child: Text('拖动我'),
  ),
)
```

* `onPanUpdate` 会在拖动时触发，每次更新都会获取当前位置。

##### 5. **缩放（Scale）**

```dart
GestureDetector(
  onScaleUpdate: (details) {
    print('缩放比例: ${details.scale}');
  },
  child: Container(
    padding: EdgeInsets.all(20),
    color: Colors.blueAccent,
    child: Text('缩放我'),
  ),
)
```

* `onScaleUpdate` 用于处理缩放手势，`details.scale` 给出了缩放的比例。

---

#### 3.5.1.5 **高级示例：图片拖动和缩放**

下面是一个结合了拖动和缩放的完整示例：

```dart
class GestureExample extends StatefulWidget {
  @override
  _GestureExampleState createState() => _GestureExampleState();
}

class _GestureExampleState extends State<GestureExample> {
  double _scale = 1.0;
  double _posX = 0.0;
  double _posY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('手势示例')),
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _posX += details.localPosition.dx;
              _posY += details.localPosition.dy;
            });
          },
          onScaleUpdate: (details) {
            setState(() {
              _scale = details.scale;
            });
          },
          child: Transform(
            transform: Matrix4.identity()
              ..translate(_posX, _posY)
              ..scale(_scale),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/200'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

#### 3.5.1.6 **总结**

* `GestureDetector` 是非常灵活的手势识别工具，几乎可以处理所有常见的交互行为；
* 可以通过 `onTap`, `onLongPress`, `onPanUpdate`, `onScaleUpdate` 等来处理各种事件；
* `GestureDetector` 通常配合 `Transform`、`AnimatedContainer` 等组件使用，能做出更丰富的动画效果。

### 3.5.2 `InkWell`
在 Flutter 中，`InkWell` 是一个用于响应触摸事件的组件，和 `GestureDetector` 类似，但它有一个额外的好处：

> **✅ 当点击时，会自动显示水波纹（Material Design 风格的点击反馈效果）。**

---

#### 3.5.2.1 最基本的用法（点击水波纹）

```dart
InkWell(
  onTap: () {
    print('点击了');
  },
  child: Container(
    padding: EdgeInsets.all(20),
    color: Colors.blue,
    child: Text('点击我', style: TextStyle(color: Colors.white)),
  ),
)
```

⚠️ **注意**：为了能看到水波纹，`InkWell` 必须放在 `Material` 组件的子树中。

---

#### 3.5.2.2 推荐用法（包在 Material 里）

```dart
Material(
  color: Colors.transparent, // 不设置背景色就不会遮住子组件
  child: InkWell(
    onTap: () {
      print('点击了按钮');
    },
    child: Container(
      padding: EdgeInsets.all(20),
      child: Text('有水波纹的按钮'),
    ),
  ),
)
```

---

#### 3.5.2.3 InkWell 常见手势事件

| 属性               | 说明      |
| ---------------- | ------- |
| `onTap`          | 点击事件    |
| `onDoubleTap`    | 双击事件    |
| `onLongPress`    | 长按事件    |
| `onTapDown`      | 手指按下    |
| `onTapCancel`    | 手势取消    |
| `borderRadius`   | 水波纹圆角边框 |
| `splashColor`    | 水波纹颜色   |
| `highlightColor` | 点击时高亮颜色 |

---

#### 3.5.2.4 示例：圆角按钮带水波纹

```dart
Material(
  color: Colors.transparent,
  child: InkWell(
    onTap: () => print('圆角按钮点击'),
    borderRadius: BorderRadius.circular(12),
    splashColor: Colors.blue.withOpacity(0.3),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('圆角按钮'),
    ),
  ),
)
```

---

#### 3.5.2.5 与 GestureDetector 的区别？

| 特性             | InkWell  | GestureDetector  |
| -------------- | --------- | ----------------- |
| 支持水波纹动画        | ✅ 是的      | ❌ 没有              |
| 需要 Material 包裹 | ✅ 是的（必须）  | ❌ 不需要             |
| 更适合按钮场景        | ✅         | ❌                 |
| 更强的手势控制        | ❌（手势较少）   | ✅ 支持拖动/缩放等        |

---

#### 3.5.2.6 总结：

* 想要 **有点击水波纹**，用 `InkWell`；
* 想要更强的手势控制（如拖动、缩放等），用 `GestureDetector`；
* `InkWell` 要放在 `Material` 组件中才能正确显示水波纹。

### 3.5.3 `IconButton`
`IconButton` 是 Flutter 中一个常用的按钮组件，用来显示一个可点击的图标，常见于 AppBar、卡片右上角、工具栏等位置。

---

#### 3.5.3.1 最基本的用法

```dart
IconButton(
  icon: Icon(Icons.favorite),
  onPressed: () {
    print('点击了图标按钮');
  },
)
```

> 💡 默认只有图标，没有文字，适合做简洁操作（例如点赞、收藏、删除等）。

---

#### 3.5.3.2 常用参数

| 参数               | 说明                 |
| ---------------- | ------------------ |
| `icon`           | 要显示的图标（通常是 `Icon`） |
| `onPressed`      | 点击事件回调             |
| `tooltip`        | 长按时显示的提示文字（无障碍支持）  |
| `color`          | 图标颜色               |
| `iconSize`       | 图标大小（默认 24）        |
| `padding`        | 图标和边框之间的间距（默认 8.0） |
| `constraints`    | 限制按钮大小（用于控制边界尺寸）   |
| `splashColor`    | 点击时水波纹颜色           |
| `highlightColor` | 点击时高亮颜色            |

---

#### 3.5.3.3 示例：红色心形图标 + 提示文字

```dart
IconButton(
  icon: Icon(Icons.favorite, color: Colors.red),
  iconSize: 32,
  tooltip: '点赞',
  onPressed: () {
    print('点了喜欢');
  },
)
```

---

#### 3.5.3.4 示例：不可用状态（禁用按钮）

```dart
IconButton(
  icon: Icon(Icons.delete),
  onPressed: null, // 设置为 null 表示禁用
)
```

---

#### 3.5.3.5 示例：用于 AppBar 中

```dart
AppBar(
  title: Text('IconButton 示例'),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        print('点击了搜索');
      },
    ),
    IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        print('点击了更多');
      },
    ),
  ],
)
```

---

#### 3.5.3.6 示例：可切换状态的 IconButton（类似收藏）

```dart
class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
        color: isFavorited ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isFavorited = !isFavorited;
        });
      },
    );
  }
}
```

---

#### 3.5.3.7 总结：

* `IconButton` 是一个图标形式的按钮，简洁轻便；
* 可以用颜色、大小、提示文本自定义；
* 和 `AppBar`、`Card`、`ListTile` 等组件一起使用非常方便；
* 也可以配合 `StatefulWidget` 实现收藏、点赞等切换功能。

### 3.5.4 `TextButton`
`TextButton` 是 Flutter 中的一种扁平化按钮，它没有凸起的效果，通常用于 **没有背景色** 或 **强调文字的操作按钮**。与 `ElevatedButton` 不同，`TextButton` 通常用于需要简单交互的按钮，如取消、确认、或底部的操作按钮。

---

#### 3.5.4.1 最基本的用法

```dart
TextButton(
  onPressed: () {
    print('点击了 TextButton');
  },
  child: Text('点击我'),
)
```

> 💡 `TextButton` 本身没有背景色、阴影等，通常只展示一个文字。

---

#### 3.5.4.2 常用参数

| 参数             | 说明                          |
| -------------- | --------------------------- |
| `onPressed`    | 按钮点击事件回调（如果为 `null`，按钮会被禁用） |
| `child`        | 按钮的内容，可以是 `Text` 或其他 Widget |
| `style`        | 自定义按钮样式，例如文字颜色、点击效果等        |
| `onLongPress`  | 长按事件回调                      |
| `autofocus`    | 自动聚焦按钮                      |
| `focusNode`    | 定义按钮的焦点（用于键盘或屏幕导航）          |
| `clipBehavior` | 是否裁剪按钮（如设置为 `Clip.none`）    |

---

#### 3.5.4.3 示例：基本按钮

```dart
TextButton(
  onPressed: () {
    print('点击了按钮');
  },
  child: Text('基础文本按钮'),
)
```

---

#### 3.5.4.4 示例：自定义按钮颜色和字体样式

```dart
TextButton(
  onPressed: () {
    print('自定义样式按钮');
  },
  style: TextButton.styleFrom(
    primary: Colors.blue, // 文字颜色
    onSurface: Colors.grey, // 按钮禁用时的颜色
    textStyle: TextStyle(fontSize: 20), // 文字大小
  ),
  child: Text('自定义样式按钮'),
)
```

---

#### 3.5.4.5 示例：禁用按钮

```dart
TextButton(
  onPressed: null,  // 按钮不可用
  child: Text('禁用按钮'),
)
```

---

#### 3.5.4.6 示例：带图标的 `TextButton`

```dart
TextButton.icon(
  onPressed: () {
    print('点击了按钮');
  },
  icon: Icon(Icons.delete),
  label: Text('删除'),
)
```

> 💡 使用 `TextButton.icon` 可以在按钮上显示图标和文字。

---

#### 3.5.4.7 示例：长按事件

```dart
TextButton(
  onPressed: () {
    print('点击了按钮');
  },
  onLongPress: () {
    print('长按事件');
  },
  child: Text('长按我'),
)
```

---

#### 3.5.4.8 自定义按钮形状和点击效果

```dart
TextButton(
  onPressed: () {
    print('自定义点击效果');
  },
  style: TextButton.styleFrom(
    primary: Colors.white, // 按钮文字颜色
    backgroundColor: Colors.blue, // 背景颜色
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // 内边距
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // 圆角按钮
    ),
  ),
  child: Text('自定义按钮'),
)
```

---

#### 3.5.4.9 示例：用作 `AppBar` 的操作按钮

```dart
AppBar(
  title: Text('TextButton 示例'),
  actions: [
    TextButton(
      onPressed: () {
        print('点击了取消');
      },
      child: Text('取消', style: TextStyle(color: Colors.white)),
    ),
  ],
)
```

---

#### 3.5.4.10 总结

* `TextButton` 是一种 **扁平化按钮**，通常用于 **不需要背景色** 或 **强调文字** 的按钮；
* 支持通过 `style` 自定义文字颜色、点击效果、背景色等；
* 可以配合 `icon` 使用，形成图标 + 文字的组合按钮；
* 支持禁用状态、长按事件等交互；
* 适用于应用中的简单操作按钮（如确认、取消、底部操作栏按钮等）。




### 3.5.5 `ElevatedButton`
`ElevatedButton` 是 Flutter 中的一种按钮，它有一个 **凸起的效果**，常用于主要操作或强调的按钮（如提交、确认等）。它遵循 Material Design 设计规范，并且能够提供 **点击反馈效果**。

---

#### 3.5.5.1 最基本的用法

```dart
ElevatedButton(
  onPressed: () {
    print('点击了 ElevatedButton');
  },
  child: Text('点击我'),
)
```

> 💡 `ElevatedButton` 默认有一个 3D 凸起的效果，点击时会有水波纹的反馈效果。

---

#### 3.5.5.2 常用参数

| 参数             | 说明                          |
| -------------- | --------------------------- |
| `onPressed`    | 按钮点击事件回调（如果为 `null`，按钮会被禁用） |
| `child`        | 按钮的内容，可以是文本或其他 Widget（如图标）  |
| `style`        | 自定义按钮样式，例如颜色、边框、阴影等         |
| `onLongPress`  | 长按事件回调                      |
| `clipBehavior` | 是否裁剪按钮（如设置为 `Clip.none`）    |
| `autofocus`    | 自动聚焦按钮（在 `Focus` 可用时）       |
| `focusNode`    | 定义按钮的焦点（用于键盘或屏幕导航）          |

---

#### 3.5.5.3 示例：基本按钮

```dart
ElevatedButton(
  onPressed: () {
    print('按钮被点击');
  },
  child: Text('基本按钮'),
)
```

---

#### 3.5.5.4 示例：自定义按钮颜色和形状

```dart
ElevatedButton(
  onPressed: () {
    print('自定义颜色的按钮');
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.orange, // 按钮背景色
    onPrimary: Colors.white, // 按钮文本色
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // 圆角按钮
    ),
  ),
  child: Text('自定义按钮'),
)
```

---

#### 3.5.5.5 示例：禁用按钮

```dart
ElevatedButton(
  onPressed: null,  // 按钮不可用
  child: Text('禁用按钮'),
)
```

---

#### 3.5.5.6 示例：长按事件

```dart
ElevatedButton(
  onPressed: () {
    print('按钮点击');
  },
  onLongPress: () {
    print('长按按钮');
  },
  child: Text('长按我'),
)
```

---

#### 3.5.5.7 示例：带图标的按钮

```dart
ElevatedButton.icon(
  onPressed: () {
    print('按钮点击');
  },
  icon: Icon(Icons.add),
  label: Text('添加'),
)
```

---

#### 3.5.5.8 自定义按钮样式（如阴影）

```dart
ElevatedButton(
  onPressed: () {
    print('自定义阴影按钮');
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.blue, // 按钮背景色
    elevation: 10, // 阴影深度
  ),
  child: Text('自定义阴影按钮'),
)
```

---

#### 3.5.5.9 使用 `ElevatedButton` 和 `StatefulWidget` 进行状态切换（例如提交按钮）

```dart
class SubmitButton extends StatefulWidget {
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSubmitting
          ? null
          : () {
              setState(() {
                isSubmitting = true;
              });
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  isSubmitting = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('提交成功'),
                ));
              });
            },
      child: isSubmitting
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Text('提交'),
    );
  }
}
```

> 💡 这个例子演示了如何使用 `ElevatedButton` 来实现带有加载状态的提交按钮，点击按钮后，会禁用按钮并显示一个进度指示器，2秒后恢复。

---

#### 3.5.5.10 总结

* `ElevatedButton` 是一种 **凸起按钮**，常用于主要操作，如提交、确认、保存等；
* 它遵循 Material Design 设计规范，并且自带 **水波纹点击反馈**；
* 可以通过 `style` 自定义颜色、形状、阴影等；
* 支持图标和文本组合（`ElevatedButton.icon`）；
* 支持禁用、长按事件、动态显示加载等复杂交互。


### 3.5.6 `TextField`
`TextField` 是 Flutter 中用于**文本输入**的基础组件，常用于表单、搜索框、登录框等场景。

---

#### 3.5.6.1 最基本的用法

```dart
TextField(
  decoration: InputDecoration(
    hintText: '请输入内容',
  ),
)
```

> 💡 `TextField` 默认没有边框和样式，一般搭配 `InputDecoration` 使用。

---

#### 3.5.6.2 常用参数

| 参数             | 说明                           |
| -------------- | ---------------------------- |
| `controller`   | 控制输入内容，可获取或清空内容等             |
| `decoration`   | 输入框的装饰，常用于设置提示语、边框、图标等       |
| `keyboardType` | 键盘类型（如文本、数字、email、电话等）       |
| `obscureText`  | 是否隐藏输入（用于密码输入）               |
| `maxLines`     | 设置最大行数（默认 1，设为 `null` 可多行输入） |
| `onChanged`    | 输入内容改变时回调                    |
| `onSubmitted`  | 用户按下回车/确认时触发                 |
| `readOnly`     | 是否只读                         |
| `enabled`      | 是否可编辑                        |
| `textAlign`    | 设置文本对齐方式                     |

---

#### 3.5.6.3 示例：带控制器的输入框

```dart
final TextEditingController _controller = TextEditingController();

TextField(
  controller: _controller,
  decoration: InputDecoration(labelText: '输入点什么'),
)
```

---

#### 3.5.6.4 示例：密码输入框

```dart
TextField(
  obscureText: true,
  decoration: InputDecoration(
    labelText: '密码',
    border: OutlineInputBorder(),
  ),
)
```

---

#### 3.5.6.5 示例：带边框、前缀图标和提示

```dart
TextField(
  decoration: InputDecoration(
    labelText: '用户名',
    hintText: '请输入用户名',
    prefixIcon: Icon(Icons.person),
    border: OutlineInputBorder(),
  ),
)
```

---

#### 3.5.6.6 示例：监听输入变化和提交

```dart
TextField(
  onChanged: (text) {
    print('输入变化: $text');
  },
  onSubmitted: (text) {
    print('用户提交: $text');
  },
)
```

---

#### 3.5.6.7 示例：多行文本框（如备注）

```dart
TextField(
  maxLines: 5,
  decoration: InputDecoration(
    labelText: '备注',
    border: OutlineInputBorder(),
  ),
)
```

---

#### 3.5.6.8 示例：设置为只读 + 点击事件（如选择日期）

```dart
TextField(
  readOnly: true,
  onTap: () {
    print('点击了只读输入框');
  },
  decoration: InputDecoration(
    labelText: '请选择日期',
    suffixIcon: Icon(Icons.calendar_today),
    border: OutlineInputBorder(),
  ),
)
```

---

#### 3.5.6.9 总结

* `TextField` 是输入文字的基础组件，通常结合 `TextEditingController` 一起使用；
* 可通过 `InputDecoration` 自定义边框、提示、图标等；
* 支持监听输入变化、控制是否只读或隐藏（密码）；
* 想实现更高级功能（如输入校验、自动完成、搜索建议）可以配合 `Form` 或第三方库。

### 3.5.7 `TextEditingController`
`TextEditingController` 是 Flutter 中用来**控制 `TextField` 输入内容**的控制器。你可以使用它来获取、设置、清空输入框中的文本，也可以监听文本变化。

---

#### 3.5.7.1 基本用法：获取输入内容

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'TextEditingController 示例', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();

  // 显示输入内容的弹窗
  void _showInputDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('输入结果'),
            content: Text(message.isEmpty ? '你还没有输入内容' : message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('关闭'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _textController.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TextEditingController 示例')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: '请输入内容',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String inputText = _textController.text;
                _showInputDialog(context, inputText);
              },
              child: Text('提交内容'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

#### 3.5.7.2 设置初始值

```dart
final TextEditingController _controller = TextEditingController(text: '默认值');
```

---

#### 3.5.7.3 清空输入框

```dart
_controller.clear();
```

你可以在点击按钮或图标时清除：

```dart
IconButton(
  icon: Icon(Icons.clear),
  onPressed: () {
    _controller.clear();
  },
)
```

---

#### 3.5.7.4 监听输入内容变化

```dart
_controller.addListener(() {
  print('当前输入：${_controller.text}');
});
```

你可以放在 `initState()` 中添加监听：

```dart
@override
void initState() {
  super.initState();
  _controller.addListener(() {
    print('输入内容变化：${_controller.text}');
  });
}
```

---

#### 3.5.7.5 示例：带清除按钮的输入框

```dart
TextField(
  controller: _controller,
  decoration: InputDecoration(
    labelText: '搜索',
    suffixIcon: IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        _controller.clear();
      },
    ),
  ),
)
```

---

#### 3.5.7.6 总结

| 功能     | 使用方法                                 |
| ------ | ------------------------------------ |
| 获取输入值  | `_controller.text`                   |
| 设置默认值  | `TextEditingController(text: '初始值')` |
| 清空内容   | `_controller.clear()`                |
| 监听内容变化 | `_controller.addListener(...)`       |
| 销毁释放资源 | `dispose()` 方法中调用 `.dispose()`       |

### 3.5.8 `Checkbox` 和 `Radio`
`Checkbox`（复选框）和 `Radio`（单选框）的示例代码
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CheckboxRadioExample()));
}

class CheckboxRadioExample extends StatefulWidget {
  const CheckboxRadioExample({super.key});
  @override
  State<CheckboxRadioExample> createState() => _CheckboxRadioExampleState();
}

class _CheckboxRadioExampleState extends State<CheckboxRadioExample> {
  // 多选：每个兴趣独立一个布尔变量
  bool likesMusic = false;
  bool likesTravel = false;

  // 单选：多个选项共享一个变量（表示当前选中项的值）
  String gender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("多选和单选演示")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ---------- 复选框区域（每个 Checkbox 对应一个状态变量） ----------
            Row(
              children: [
                // 音乐复选框：对应 likesMusic 变量
                Checkbox(
                  value:
                      likesMusic, // 这个值为 true 时，这个选项 “被选中” ；这个值为 false 时，这个选项 “不被选中”
                  onChanged: (bool? fuXuanValue) {
                    // 点击复选框后，fuXuanValue 会变成原值的反转：true 变 false，false 变 true
                    setState(() {
                      likesMusic = fuXuanValue!; // 非空断言
                    });
                  },
                ),
                Text("音乐"),

                SizedBox(width: 20),

                // 旅行复选框：对应 likesTravel 变量
                Checkbox(
                  value:
                      likesTravel, // 这个值为 true 时，这个选项 “被选中” ；这个值为 false 时，这个选项 “不被选中”
                  onChanged: (_) {
                    // 记得加'_'
                    // 功能与上面那个一样
                    setState(() {
                      likesTravel = !likesTravel; // 布尔值取反
                    });
                  },
                ),
                Text("旅行"),
              ],
            ),

            SizedBox(height: 20),

            // ---------- 单选框区域（所有 Radio 共享同一个 groupValue） ----------
            Row(
              children: [
                Text("性别："),

                // 男性单选按钮
                Radio<String>(
                  value: "male", // 这个选项的值
                  groupValue: gender, // 当前选中的值
                  // 若当前选中的值 == 这个选项的值，则这个选项 “被选中”，否则这个选项 “不被选中”
                  onChanged: (String? danXuanValue) { // 点击按钮，将 "male" 传入
                    setState(() {
                      gender = danXuanValue!; // 非空断言，将 "male" 赋值给 gender
                    });
                  },
                ),
                Text("男"),

                // 女性单选按钮
                Radio<String>(
                  value: "female", // 这个选项的值
                  groupValue: gender, // 当前选中的值
                  // 若当前选中的值 == 这个选项的值，则这个选项 “被选中”，否则这个选项 “不被选中”
                  onChanged: (String? value) { // 点击按钮，将 "female" 传入
                    setState(() {
                      gender = value!; // 将 "female" 赋值给 gender
                    });
                  },
                ),
                Text("女"),
              ],
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                String hobby = [
                  if (likesMusic) "音乐",
                  if (likesTravel) "旅行",
                ].join("、");
                String genderText = gender == "male" ? "男" : "女";

                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: Text("选择结果"),
                        content: Text("兴趣：$hobby\n性别：$genderText"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("关闭"),
                          ),
                        ],
                      ),
                );
              },
              child: Text("提交"),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3.5.9 `Switch`
完整示例：使用 `Switch` 实现开关功能
```dart
import 'package:flutter/material.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});
  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  // 初始化开关状态，默认为关闭（false）
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Switch 示例")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 文字说明当前状态
            Text(
              isDarkMode ? "暗黑模式已开启" : "暗黑模式已关闭",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),

            // Switch 控件：用于切换状态
            Switch(
              value: isDarkMode, // 显示当前的开关状态
              onChanged: (bool value) {
                // 当开关被点击时，更新状态，布尔值会被反转
                setState(() {
                  isDarkMode = value;
                });
              },
              activeColor: Colors.blue, // 激活状态时的颜色
              inactiveThumbColor: Colors.grey, // 不激活时的圆点颜色
              inactiveTrackColor: Colors.grey[300], // 不激活时的轨道颜色
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SwitchExample()));
}
```

### 3.5.10 交互组件小结
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '交互组件小结', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  bool likesMusic = false;
  bool likesTravel = false;
  String gender = "male";
  bool isDarkMode = false;

  @override
  void dispose() {
    _textController.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('交互组件小结')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                print('点击了GestureDetector');
              },
              child: Container(
                padding: EdgeInsets.all(20),
                color: Colors.blue,
                child: Text('点击我', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 10),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  print('点击了InkWell');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text('有水波纹的按钮'),
                ),
              ),
            ),
            SizedBox(height: 10),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                print('点击了IconButton');
              },
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                print('点击了TextButton');
              },
              child: Text('基础文本按钮'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: '请输入内容',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String input = _textController.text.trim();
                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: Text('你的输入'),
                        content: Text(input.isEmpty ? '你还没有输入内容' : input),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('关闭'),
                          ),
                        ],
                      ),
                );
              },
              child: Text('提交内容'),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: likesMusic,
                      onChanged: (bool? fuXuanValue) {
                        setState(() {
                          likesMusic = fuXuanValue!;
                        });
                      },
                    ),
                    Text("音乐"),

                    SizedBox(width: 20),

                    Checkbox(
                      value: likesTravel,
                      onChanged: (_) {
                        setState(() {
                          likesTravel = !likesTravel;
                        });
                      },
                    ),
                    Text("旅行"),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Text("性别："),

                    Radio<String>(
                      value: "male",
                      groupValue: gender,

                      onChanged: (String? danXuanValue) {
                        setState(() {
                          gender = danXuanValue!;
                        });
                      },
                    ),
                    Text("男"),

                    Radio<String>(
                      value: "female",
                      groupValue: gender,

                      onChanged: (String? value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text("女"),
                  ],
                ),

                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    String hobby = [
                      if (likesMusic) "音乐",
                      if (likesTravel) "旅行",
                    ].join("、");
                    String genderText = gender == "male" ? "男" : "女";

                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: Text("选择结果"),
                            content: Text("兴趣：$hobby\n性别：$genderText"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("关闭"),
                              ),
                            ],
                          ),
                    );
                  },
                  child: Text("提交"),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isDarkMode ? "暗黑模式已开启" : "暗黑模式已关闭",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),

                Switch(
                  value: isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## 3.6 其它
### 3.6.1 `Icon`
`Icon` 是 Flutter 中一个非常常用的 Widget，它用于显示图标。你可以使用 `Icon` 来展示 Material Design 图标或者自定义的图标。

#### 3.6.1.1 基本用法

```dart
Icon(Icons.home) // 使用内置的 home 图标
```

#### 3.6.1.2 详细解释

* **`Icons`**：这是一个包含了许多内置图标的类，比如 `Icons.home`、`Icons.star`、`Icons.search` 等。
* **`Icon`**：这是显示图标的 Widget。你可以通过它来指定图标的类型、大小、颜色等属性。

#### 3.6.1.3 常见属性

* **`icon`**：指定显示的图标。通常是 `Icons` 类中的一个图标常量。
* **`size`**：设置图标的大小，默认为 24.0。
* **`color`**：设置图标的颜色，默认为 `null`，即使用当前主题的颜色。
* **`semanticLabel`**：为图标提供语义标签，主要用于无障碍服务（例如屏幕阅读器）。
* **`weight`** 和 **`style`**：可以设置图标的粗细和样式。

#### 3.6.1.4 示例代码

```dart
Icon(
  Icons.favorite, // 图标
  color: Colors.red, // 图标颜色
  size: 30.0, // 图标大小
)
```

#### 3.6.1.5 使用 `Icon` 与其他 Widget 结合

你可以将 `Icon` 与 `Text` 或 `Button` 等其他 Widget 结合使用，常见的场景有：

* **IconButton**：一个带图标的按钮。
* **Row 或 Column**：可以水平或垂直排列多个图标。

#### 3.6.1.6 示例：`IconButton`

```dart
IconButton(
  icon: Icon(Icons.add),
  onPressed: () {
    print('Add button clicked');
  },
)
```

这样，你就可以在 UI 中显示图标，并为图标添加交互功能。`IconButton` 常用于触发某些操作，比如添加、删除、保存等。

### 3.6.2 `Stack` 和 `Positioned` 和 `CircleAvatar`
#### 3.6.2.1 Flutter 中的 `Stack` 是什么？

> `Stack` 是一个**可以让多个子组件层叠摆放**的布局组件，像是在做“组件叠叠乐”。
> 就像 Photoshop 的图层一样，前面的 Widget 会被后添加的盖住。

---

#### 3.6.2.2 示例代码：头像上叠加徽章

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 背景头像
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300'), // 随机头像
              ),
              // 右下角徽章
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.star, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

#### 3.6.2.3 关键知识点：

| 概念           | 说明                                                     |
| ------------ | ------------------------------------------------------ |
| `Stack`      | 子组件重叠摆放，后面的 Widget 会盖住前面的                              |
| `Positioned` | 精确控制子组件在 Stack 中的位置，如 `top`, `left`, `right`, `bottom` |
| `alignment`  | 控制未定位的子组件如何对齐（默认居中）                                    |

---

#### 3.6.2.4 Stack 的应用场景：

* 用户头像角标（在线状态、VIP徽章）
* 轮播图叠加标题或按钮
* 自定义卡片装饰（角标、标签）
* 游戏中人物叠层绘制

### 3.6.3 `AnimatedOpacity`
`AnimatedOpacity` 是 Flutter 中非常实用的**隐式动画组件**，可以让组件在一段时间内**平滑地改变透明度**，从而实现淡入淡出效果。

---

#### 3.6.3.1 作用

> `AnimatedOpacity` 允许你在透明度发生变化时，自动执行**动画过渡**，不用手动写动画控制器。

---

#### 3.6.3.2 基本语法

```dart
AnimatedOpacity({
  required double opacity,
  required Duration duration,
  Widget? child,
})
```

* `opacity`：目标透明度（0.0 = 完全透明，1.0 = 完全不透明）
* `duration`：动画持续时间
* `child`：要动画的组件

---

#### 3.6.3.3 示例代码：点击按钮让星星淡入淡出 ⭐️

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("🌟 AnimatedOpacity Demo")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Icon(Icons.star, color: Colors.amber, size: 100),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _visible = !_visible;
                  });
                },
                child: Text(_visible ? "🙈 隐藏星星" : "🌟 显示星星"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
---

#### 3.6.3.4 效果：

* 初始显示星星；
* 点击按钮，星星淡出；
* 再点一次，星星淡入；
* 动画持续 1 秒，非常丝滑 ✨

---

#### 3.6.3.5 常见用途：

| 场景        | 说明                          |
| --------- | --------------------------- |
| 页面元素淡入加载  | 比如欢迎页面的 Logo 出现             |
| 提示/警告淡出   | 用户点关闭后动画隐藏提示                |
| 组件过渡效果    | 不破坏原有布局                     |
| 聊天气泡、点赞动画 | 结合 `AnimatedOpacity` 与 Icon |

### 3.6.4 `AnimatedPositioned`
`AnimatedPositioned` 是 Flutter 中一个非常强大的组件，它是 `Positioned` 的动画版本，允许你在指定的时间内平滑地**更改子组件的位置**。这使得你可以在 UI 中实现平滑的动画效果，比如让一个元素从屏幕的一部分移动到另一部分。

---

#### 3.6.4.1 作用

> `AnimatedPositioned` 允许你在 `Stack` 布局中**动态改变子组件的位置**，并自动添加动画过渡效果。

---

#### 3.6.4.2 基本语法

```dart
AnimatedPositioned({
  required Duration duration,          // 动画持续时间
  required double top,                // 组件距父容器上边的距离
  required double left,               // 组件距父容器左边的距离
  required double right,              // 组件距父容器右边的距离
  required double bottom,             // 组件距父容器下边的距离
  required Widget child,              // 要进行动画的子组件
})
```

---

#### 3.6.4.3 示例：点击按钮让小球移动

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _top = 50.0;
  double _left = 50.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("🎯 AnimatedPositioned Demo")),
        body: Stack(
          children: [
            AnimatedPositioned(
              top: _top,
              left: _left,
              duration: Duration(seconds: 1),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _top = _top == 50.0 ? 200.0 : 50.0; // 移动
                    _left = _left == 50.0 ? 200.0 : 50.0; // 移动
                  });
                },
                child: Text("🎯 移动小球"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

#### 3.6.4.4 输出效果：

* 初始状态下，小球会在 `(50, 50)` 位置。
* 点击按钮时，小球会在 1 秒钟内平滑地**从 `(50, 50)` 移动到 `(200, 200)`**。
* 再次点击时，小球会返回原位。

---

#### 3.6.4.5 关键知识点：

* **`AnimatedPositioned`** 可以让你平滑地改变 `top`, `left`, `bottom`, `right` 等位置属性，动画持续时间由 `duration` 控制。
* 适用于 `Stack` 布局中的子组件。

---

#### 3.6.4.6 常见应用场景：

| 场景         | 说明                    |
| ---------- | --------------------- |
| 动态按钮位置     | 让按钮或图标在屏幕中平滑移动。       |
| 游戏中的角色位置变化 | 角色从一个位置滑动到另一个位置。      |
| 弹出菜单或动画标签  | 弹出菜单的位置动态改变，增强交互感。    |
| 动态显示/隐藏视图  | 页面元素的位置动态调整，比如对话框的弹出。 |

### 3.6.5 `Sliver` 系列
下面是一个结合了 `SliverAppBar`（可滚动吸顶头部）、`SliverGrid`（宫格菜单）、和 `SliverList`（列表内容）的大综合示例 —— 类似淘宝、美团首页的布局风格。

---

#### 3.6.5.1 示例：电商首页风格的 `Sliver` 综合布局

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<String> menuItems = List.generate(8, (i) => "📦 分类 ${i + 1}");
  final List<String> listItems = List.generate(20, (i) => "🛍 商品 ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            // 吸顶 AppBar
            SliverAppBar(
              pinned: true,
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('🛒 Sliver商城'),
                background: Image.network(
                  'https://picsum.photos/600/300?random',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 宫格菜单
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Card(
                      color: Colors.amber[100],
                      child: Center(child: Text(menuItems[index])),
                    );
                  },
                  childCount: menuItems.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
              ),
            ),

            // 间隔部分
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Center(
                  child: Text(
                    "🔥 热门商品",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            // 商品列表
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(listItems[index]),
                    subtitle: Text("描述内容..."),
                    trailing: Icon(Icons.arrow_forward_ios, size: 14),
                  );
                },
                childCount: listItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

#### 3.6.5.2 这个页面实现了：

| 区块                   | 功能说明                       |
| -------------------- | -------------------------- |
| `SliverAppBar`       | 可折叠的顶部 Banner 区域，滚动时吸顶     |
| `SliverGrid`         | 宫格菜单（分类入口）                 |
| `SliverToBoxAdapter` | 插入非 Sliver 内容（比如标题文字、分隔符等） |
| `SliverList`         | 商品信息列表，支持懒加载               |

---

#### 3.6.5.3 提示：

你可以用这种方式轻松扩展更多功能，比如添加 `SliverPersistentHeader`（吸顶标签）、动态 Banner、滑动加载更多等。

# 4. **响应式布局**
这是个很重要的主题，我们来详细讲讲 Flutter 中的 **响应式布局（Responsive Layout）**，特别是如何使用 `MediaQuery`、`LayoutBuilder` 以及响应式辅助组件来适配不同屏幕大小，比如手机、平板等。

---

## 4.1 `MediaQuery`
获取设备信息
```dart
@override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width = size.width;
  final height = size.height;

  return Text('屏幕宽度: $width, 高度: $height');
}
```

✅ 用于获取屏幕尺寸、像素密度、方向等。可根据宽度决定布局方案（如横向/竖向、单列/多列等）。

---

## 4.2 `LayoutBuilder`
根据父布局大小决定 UI
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return Column(children: [...]); // 手机布局
    } else {
      return Row(children: [...]); // 平板布局
    }
  },
);
```

✅ `LayoutBuilder` 根据 **实际可用空间**（而不是屏幕）来构建响应式布局，适合组件内部自适应。

---

## 4.3 其他响应式辅助组件

| Widget                  | 作用说明                      |
| ----------------------- | ------------------------- |
| `AspectRatio`           | 保持子组件的宽高比                 |
| `FractionallySizedBox`  | 根据父组件宽高的百分比设置子组件大小        |
| `FittedBox`             | 自动缩放子组件以适应父组件             |
| `Expanded` / `Flexible` | 在 `Row`/`Column` 中按比例弹性布局 |
| `Wrap` / `Flow`         | 当空间不足时自动换行布局              |
| `OrientationBuilder`    | 根据横屏/竖屏调整 UI              |

---

## 4.4 实用响应式示例
### 4.4.1 `MediaQuery` 示例
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
    final pingMuSize = MediaQuery.of(context).size; // 获取屏幕尺寸

    return Scaffold(
      appBar: AppBar(title: Text('侧边导航栏')),
      body: SizedBox(
        width: pingMuSize.width * 0.4, // 设置整个 ListView 的宽度为屏幕宽度的 40%
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              height: 80, 
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
#### 应用场景
* 组件按百分比自适应屏幕的宽高度。
---

### 4.4.2 `LayoutBuilder` 示例
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth < 600
                ? _buildMobileLayout()
                : _buildTabletLayout();
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(child: Container(color: Colors.blue, height: 100)),
        Expanded(child: Container(color: Colors.green, height: 100)),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        Expanded(child: Container(color: Colors.blue, height: 200)),
        Expanded(child: Container(color: Colors.green, height: 200)),
      ],
    );
  }
}
```
#### 应用场景
* 小屏手机显示一列，大屏或横屏切换成多列。
* 横竖屏布局差异适配。
* 组件按百分比自适应父容器大小。
---

# 5. Flutter 路由与导航
## 5.1 基本路由管理
`Navigator.push` / `pop`
最基础的页面跳转方式，直接传入新页面 Widget。

```dart
// 跳转到新页面
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondPage()),
);

// 返回上一页
Navigator.pop(context);
```

👉 推荐用于**临时页面跳转**或无需统一路由管理的场景。

- 示例代码：从页面A跳转到页面B，并从B返回A
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: PageA()));
}

// 🅰️ 页面 A：起始页
class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('页面 A')),
      body: Center(
        child: ElevatedButton(
          child: Text('跳转到页面 B'),
          onPressed: () {
            // 使用 push 跳转到 PageB
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageB()),
            );
          },
        ),
      ),
    );
  }
}

// 🅱️ 页面 B：目标页
class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('页面 B')),
      body: Center(
        child: ElevatedButton(
          child: Text('返回页面 A'),
          onPressed: () {
            // 使用 pop 返回上一页
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
```
---

## 5.2 命名路由（推荐）：统一配置 + 使用简洁

### 5.2.1 配置（在 `MaterialApp` 中声明）

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomePage(),
    '/details': (context) => DetailsPage(),
  },
);
```

### 5.2.2 使用

```dart
Navigator.pushNamed(context, '/details');
Navigator.pop(context);
```

👉 命名路由让项目结构更清晰，适合中大型项目。

---

## 5.3 路由传参

### 5.3.1 方法一：**构造函数传参**

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailsPage(data: "Hello")),
);

class DetailsPage extends StatelessWidget {
  final String data;
  DetailsPage({required this.data});
}
```

### 5.3.2 方法二：**命名路由 + 参数（`onGenerateRoute`）**

```dart
MaterialApp(
  onGenerateRoute: (settings) {
    if (settings.name == '/details') {
      final args = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => DetailsPage(data: args),
      );
    }
    return null;
  },
);
```

使用：

```dart
Navigator.pushNamed(context, '/details', arguments: "Hello 参数");
```

---

## 5.4 嵌套路由（如底部导航 + 子页面）

用于实现如 **TabBar / BottomNavigationBar** 切换，每个 tab 下有自己独立的导航栈。

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// 这是整个 App 的入口，配置了命名路由和首页
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '路由演示',
      debugShowCheckedModeBanner: false,
      // 设置首页路由
      initialRoute: '/',
      // 处理命名路由 + 路由参数传递
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          // 从命名路由中获取传入的参数（这里是 String）
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => DetailsPage(data: args),
          );
        }
        return null; // 其他情况返回 null
      },
      // 默认页面是底部导航主框架
      home: MainApp(),
    );
  }
}

// 这是底部导航的主结构，包含“首页”和“我的”两个 Tab
class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _index = 0; // 当前选中的 Tab 索引

  // 每个 Tab 对应一个 Navigator，互不干扰
  final _pages = [
    Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => HomeTab());
      },
    ),
    Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => ProfileTab());
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用 IndexedStack 保留每个页面的状态
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i), // 切换 Tab
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}

// -------------------- 首页 ------------------------

class HomeTab extends StatelessWidget {
  // 模拟商品数据
  final List<String> items = List.generate(5, (i) => "商品 ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(items[i]),
          // 点击每个商品跳转到详情页
          onTap: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: items[i], // 把商品名作为参数传递
            );
          },
        ),
      ),
    );
  }
}

// -------------------- 详情页 ------------------------

class DetailsPage extends StatelessWidget {
  final String data; // 接收传递过来的参数

  DetailsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('详情页')),
      body: Center(
        child: Text('你点击了：$data', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// -------------------- 我的页 ------------------------

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的')),
      body: Center(child: Text('这里是我的页面')),
    );
  }
}
```

📌 每个 Tab 有自己的 `Navigator`，互不干扰，可实现「底部导航+子页面跳转再返回」的复杂场景。

---

### 总结：哪种方式该用？

| 方式               | 适用场景                    |
| ---------------- | ----------------------- |
| `Navigator.push` | 简单跳转，小型页面               |
| 命名路由             | 中大型项目，集中式管理             |
| 参数传递             | 页面间通信                   |
| 嵌套路由             | TabBar、BottomNav 多导航栈管理 |

# 6. **常见的状态管理方案**

## **6.1 状态管理简介 - `setState` 的使用**
`setState` 是 Flutter 中最基础的状态管理方式，适用于组件内部状态的更新。当状态变化时，它会触发 UI 重新渲染，使界面与数据保持同步。

---

### **6.1.1 `setState` 的基本用法**
`setState` 是 `StatefulWidget` 管理状态的核心方法，用于更新状态并刷新 UI。

### **示例：计数器应用**
```dart
import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _count = 0; // 定义状态变量

  void _incrementCounter() {
    setState(() { // 调用 setState 更新状态
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('计数器')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('当前计数: $_count', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('点我+1'),
            ),
          ],
        ),
      ),
    );
  }
}
```
**运行效果：**
- 每次点击按钮，`_count` 增加 1，UI 自动更新。

---

### **6.1.2 `setState` 的工作原理**
1. **触发 UI 更新**：`setState` 会标记当前 `State` 对象为“脏”（dirty），告诉 Flutter 需要重新渲染。
2. **重建 Widget**：Flutter 会重新调用 `build()` 方法，基于新状态生成新的 UI。
3. **高效渲染**：Flutter 使用 Diff 算法比较新旧 Widget 树，只更新变化的部分。

---

### **6.1.3 适用场景**
✅ **适合**：
- 局部状态管理（如按钮点击、表单输入、动画控制）。
- 简单页面，状态较少的情况。

❌ **不适合**：
- 跨组件状态共享（如用户登录信息）。
- 复杂应用（状态较多时，`setState` 会导致代码臃肿）。

---

### **6.1.4 进阶用法**
#### **(1) 异步操作 + `setState`**
```dart
bool _isLoading = false;

Future<void> _fetchData() async {
  setState(() => _isLoading = true);
  await Future.delayed(Duration(seconds: 2)); // 模拟网络请求
  setState(() => _isLoading = false);
}
```
**用途**：在加载数据时显示 `CircularProgressIndicator`。

#### **(2) 表单输入控制**
```dart
TextEditingController _textController = TextEditingController();

TextField(
  controller: _textController,
  onChanged: (text) {
    setState(() {}); // 实时更新 UI（如显示字符数）
  },
)
```

---

### **6.1.5 常见问题**
#### **Q1: 为什么 `setState` 不生效？**
- 可能原因：
  - 在 `StatelessWidget` 中使用 `setState`（❌ 错误）。
  - 忘记包裹修改状态的代码（✅ 正确写法：`setState(() { _count++; })`）。

#### **Q2: `setState` 会导致整个页面刷新吗？**
- **不会**！Flutter 会智能比对 Widget 树，只更新变化的部分。

---

### **6.1.6 总结**
| 要点 | 说明 |
|------|------|
| **作用** | 更新 `StatefulWidget` 的局部状态并触发 UI 刷新。 |
| **适用场景** | 简单交互、动画、表单输入等。 |
| **替代方案** | 复杂应用建议使用 `Provider`、`Riverpod`、`Bloc` 等状态管理库。 |

**代码实践建议**：  
- 尽量拆分小部件，减少 `setState` 的影响范围。
- 避免在 `build()` 方法中调用 `setState`，否则会导致无限循环！

---

## **6.2 其它状态管理方案** 
- **`Provider` 状态管理** 适合小型项目（少于5个页面）
- **`Riverpod` 状态管理** 适合中型项目（5 - 20个页面）[Riverpod官方文档](https://riverpod.dev/zh-Hans/)
- **`Bloc` 架构** 适合大型项目（超过20个页面） 

# 7. **本地存储与数据库**
## **7.1 Shared Preferences**
### 7.1.1 什么是 SharedPreferences？

* 📦 一种 **轻量级本地存储**，用于保存用户设置、登录信息、开关状态等。
* 🧠 使用 **key-value 键值对** 形式保存数据（类似浏览器的 localStorage）。

---

### 7.1.2 示例：计数器 + SharedPreferences 持久化

#### 7.1.2.1 效果说明：

* 每点击一次按钮，计数 +1。
* 即使关闭 app，下次打开仍保留上次的计数。

---

#### 7.1.2.2 安装依赖：

在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
```

然后运行 `flutter pub get` 安装依赖。

---

#### 7.1.2.3 完整示例代码：

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences 示例',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _loadCount(); // 启动时加载计数值
  }

  // 加载本地保存的计数值
  void _loadCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = prefs.getInt('counter') ?? 0;
    });
  }

  // 增加计数并保存到本地
  void _incrementCounter() async {
    setState(() {
      _count++;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', _count); // 保存数据
  }

  // 清空计数
  void _resetCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('counter');
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('计数器 - 本地保存')),
      body: Center(
        child: Text('你按了 $_count 次', style: TextStyle(fontSize: 24)),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: '增加',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: '重置',
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
```

---

### 7.1.3 总结

| 操作                   | 方法                                |
| -------------------- | --------------------------------- |
| 获取实例                 | `SharedPreferences.getInstance()` |
| 保存值（int/String/bool） | `prefs.setInt('key', value)`      |
| 读取值                  | `prefs.getInt('key')`             |
| 删除值                  | `prefs.remove('key')`             |

## **7.2 其它数据库**

* 略，详见 [官方文档](https://docs.flutter.cn/)

# 8. **网络请求**

## 8.1 HTTP 请求

### 8.1.1 使用 `http` 包（适合入门）

#### 8.1.1.1 添加依赖：

在 `pubspec.yaml` 中：

```yaml
dependencies:
  http: ^0.13.6
```

---

### 8.1.2 示例1 获取 GitHub 用户信息（GET 请求）

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // 用于解析 JSON

void main() {
  runApp(MaterialApp(home: GitHubUserPage()));
}

class GitHubUserPage extends StatefulWidget {
  @override
  _GitHubUserPageState createState() => _GitHubUserPageState();
}

class _GitHubUserPageState extends State<GitHubUserPage> {
  String username = "octocat";
  String? name;
  String? avatarUrl;

  Future<void> fetchUser() async {
    final url = Uri.parse('https://api.github.com/users/$username');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body); // JSON -> Map
      setState(() {
        name = data['name'];
        avatarUrl = data['avatar_url'];
      });
    } else {
      print('请求失败: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GitHub 用户')),
      body: Center(
        child: name == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(avatarUrl!, width: 100),
                  SizedBox(height: 16),
                  Text('用户名：$name', style: TextStyle(fontSize: 20)),
                ],
              ),
      ),
    );
  }
}
```

### 8.1.3 示例2 

#### 8.1.3.1 目标效果：

点击按钮，发起网络请求，成功后显示 GitHub 用户名和头像。

---

#### 8.1.3.2 更直观的方式：从点击开始，一步步触发

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: MyNetworkExample()));
}

class MyNetworkExample extends StatefulWidget {
  @override
  _MyNetworkExampleState createState() => _MyNetworkExampleState();
}

class _MyNetworkExampleState extends State<MyNetworkExample> {
  String? name;
  String? avatar;
  bool isLoading = false;
  String? errorMessage;

  Future<void> _getUserData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final url = Uri.parse('https://api.github.com/users/octocat');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          name = data['name'];
          avatar = data['avatar_url'];
        });
      } else {
        setState(() {
          errorMessage = "请求失败：${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "请求出错：$e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🐙 GitHub 用户信息")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) CircularProgressIndicator(),

              if (errorMessage != null)
                Text(errorMessage!, style: TextStyle(color: Colors.red)),

              if (name != null && avatar != null)
                Column(
                  children: [
                    Image.network(avatar!, width: 100),
                    SizedBox(height: 10),
                    Text('用户名：$name', style: TextStyle(fontSize: 20)),
                  ],
                ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: isLoading ? null : _getUserData,
                child: Text("📡 获取 GitHub 用户信息"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

#### 8.1.3.3 学习关键点解释（适合初学者）：

| 步骤                            | 作用                                        |
| ----------------------------- | ----------------------------------------- |
| `http.post(url, body)`        | 向指定的 URL 发送 POST 请求，通常用于提交表单数据或者创建资源      |
| `http.get(url)`               | 向指定的 URL 发送 GET 请求，获取数据（如从 API 获取用户信息）    |
| `http.put(url, body)`         | 向指定的 URL 发送 PUT 请求，更新现有资源（通常是全部更新）        |
| `http.delete(url)`            | 向指定的 URL 发送 DELETE 请求，删除指定资源              |
| `http.patch(url, body)`       | 向指定的 URL 发送 PATCH 请求，部分更新现有资源             |
| `http.MultipartRequest`       | 用于上传文件，通过 Multipart 请求方式发送文件数据            |
| `jsonDecode(response.body)`   | 将 API 返回的 JSON 格式的字符串转为 Dart Map，以便处理响应数据 |
| `setState()`                  | 更新应用的状态并重新渲染 UI，确保数据显示更新（如显示用户信息）         |
| `CircularProgressIndicator()` | 显示加载动画，表示正在请求数据期间的加载状态                    |
| `try-catch-finally`           | 用于捕获异常，处理网络请求中的错误，确保 UI 不会崩溃并显示出错信息       |

---

#### 8.1.3.4 运行效果：

第一次点击按钮时，会显示加载动画，然后显示头像和用户名。如果请求失败（断网或 API 出错），会显示错误提示。

## 8.2 使用 Dio（功能更强大）

### 8.2.1 添加依赖：

```yaml
dependencies:
  dio: ^5.4.0
```

### 8.2.2 简单封装请求

```dart
import 'package:dio/dio.dart';

final dio = Dio();

Future<Map<String, dynamic>> fetchUser(String username) async {
  final response = await dio.get('https://api.github.com/users/$username');
  return response.data;
}
```

---

## 8.3 JSON 解析与数据处理

###  8.3.1 示例 JSON：

```json
{
  "name": "Banana",
  "price": 3.5,
  "inStock": true
}
```

---

### 8.3.2 定义模型类

```dart
class Product {
  final String name;
  final double price;
  final bool inStock;

  Product({required this.name, required this.price, required this.inStock});

  // 工厂方法：从 Map 创建对象
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      inStock: json['inStock'],
    );
  }

  // 可选：对象转 JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'inStock': inStock,
  };
}
```

---

### 8.3.3 使用示例：

```dart
final jsonStr = '{"name":"Banana","price":3.5,"inStock":true}';
final jsonMap = jsonDecode(jsonStr);
final product = Product.fromJson(jsonMap);

print(product.name); // 输出: Banana
```
