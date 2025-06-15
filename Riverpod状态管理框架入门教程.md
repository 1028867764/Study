
# Riverpod 知识大纲

## 1. Riverpod 简介

### 1.1 什么是 Riverpod？

**Riverpod** 是 Flutter 的现代响应式状态管理库，由 [Remi Rousselet](https://github.com/rrousselGit) 开发，它是 Provider 的后续作品，但不依赖 `BuildContext`，拥有更高的灵活性、类型安全性与测试友好性。

主要特性包括：

* ✅ 完全脱离 `BuildContext`，不再依赖 Widget 树
* ✅ 更强的类型系统和编译期检查
* ✅ 易于测试，支持模块化设计
* ✅ 支持同步和异步状态管理

示例：最简单的 Riverpod 应用

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 定义一个只读的 Provider，提供一个字符串
final helloProvider = Provider((ref) => 'Hello Riverpod!');

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(helloProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Demo')),
      body: Center(child: Text(text)),
    );
  }
}
```


---

### 1.2 与 Provider 的区别

| 对比项               | Provider     | Riverpod       |
| ----------------- | ------------ | -------------- |
| 是否依赖 BuildContext | ✅ 是          | ❌ 否            |
| 类型安全              | 一般           | ✅ 编译期强类型       |
| 支持热重载             | 部分情况下失效      | ✅ 稳定支持         |
| 测试友好性             | 需搭配上下文或 mock | ✅ 可单独测试业务逻辑    |
| 支持异步/组合           | 部分           | ✅ 全面内建支持       |
| 状态生命周期管理          | 较弱           | ✅ 可自动销毁、作用域更灵活 |

#### 关键差异解释：

* ✅ **无需 `BuildContext`**：你可以在服务层、ViewModel、异步回调中访问状态，无需通过 Widget 层传递。
* ✅ **模块化更清晰**：Provider 可以自由组合、传参（使用 `.family`）。
* ✅ **异步支持原生化**：直接使用 `FutureProvider`/`StreamProvider` 管理异步状态。

示例：Provider 与 Riverpod 对比（更新计数器）

```dart
// 使用 StateProvider 实现计数器
final counterProvider = StateProvider<int>((ref) => 0);

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text('Count: $count', style: const TextStyle(fontSize: 24)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```



---

### 1.3 Riverpod 的优势与适用场景

#### ✅ 优势总结

* **彻底解耦 UI 与状态逻辑**：你可以在任意地方访问状态，独立测试逻辑。
* **支持组合、依赖注入**：Provider 可以依赖其他 Provider。
* **自动生命周期管理**：使用 `autoDispose` 后，状态可在不使用时自动释放。
* **完整异步支持**：内建 `FutureProvider` / `AsyncValue`。
* **良好测试支持**：通过 `ProviderContainer` 可在测试中模拟状态。

#### 🧭 典型使用场景

* 中大型 Flutter 项目
* 需要复杂状态交互或异步请求
* 关注架构清晰性和可维护性
* 团队开发、模块化协作
* 测试覆盖率要求高的项目


当然可以，以下是整理完善后的 Markdown 内容，包括各个 `Provider` 类型的用途说明以及 `ref` 的常见用法，并附上简单代码示例，方便你直接复制使用：

---

## 2. 基础概念

### 2.1 Provider 类型总览

#### ✅ `Provider<T>`

用于提供一个只读的值，适合用于不变的数据（如配置、常量）。

```dart
final greetingProvider = Provider<String>((ref) => 'Hello, Riverpod!');

Widget build(BuildContext context, WidgetRef ref) {
  final greeting = ref.watch(greetingProvider);
  return Text(greeting);
}
```

---

#### ✅ `StateProvider<T>`

用于提供一个可读写的状态，适合简单的本地状态管理。

```dart
final counterProvider = StateProvider<int>((ref) => 0);

Widget build(BuildContext context, WidgetRef ref) {
  final count = ref.watch(counterProvider);
  return Column(
    children: [
      Text('Count: $count'),
      ElevatedButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: Text('Increment'),
      ),
    ],
  );
}
```

---

#### ✅ `FutureProvider<T>`

处理异步计算，例如从网络加载数据。

```dart
final userProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 1));
  return 'User Loaded';
});

Widget build(BuildContext context, WidgetRef ref) {
  final userAsync = ref.watch(userProvider);

  return userAsync.when(
    data: (data) => Text(data),
    loading: () => CircularProgressIndicator(),
    error: (err, stack) => Text('Error: $err'),
  );
}
```

---

#### ✅ `StreamProvider<T>`

监听一个流（stream），适合用于实时数据（如 socket、倒计时）。

```dart
final timeProvider = StreamProvider<int>((ref) async* {
  int i = 0;
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    yield i++;
  }
});

Widget build(BuildContext context, WidgetRef ref) {
  final time = ref.watch(timeProvider);

  return time.when(
    data: (val) => Text('Time: $val'),
    loading: () => CircularProgressIndicator(),
    error: (err, _) => Text('Error: $err'),
  );
}
```

---

#### ✅ `StateNotifierProvider<TNotifier, TState>`

适合管理复杂的业务逻辑状态。

```dart
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() => state++;
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);

Widget build(BuildContext context, WidgetRef ref) {
  final count = ref.watch(counterNotifierProvider);
  return ElevatedButton(
    onPressed: () => ref.read(counterNotifierProvider.notifier).increment(),
    child: Text('Count: $count'),
  );
}
```

---

#### ✅ `ChangeNotifierProvider`

与旧有的 `ChangeNotifier` 类兼容，适用于已有 Flutter 项目迁移。

```dart
class MyModel extends ChangeNotifier {
  String value = 'Hello';
  void update(String val) {
    value = val;
    notifyListeners();
  }
}

final myModelProvider = ChangeNotifierProvider((ref) => MyModel());

Widget build(BuildContext context, WidgetRef ref) {
  final model = ref.watch(myModelProvider);
  return Text(model.value);
}
```

---

### 2.2 `ref` 的作用

| 方法          | 说明                     |
| ----------- | ---------------------- |
| `.read()`   | 获取 provider 的当前值（不会重建） |
| `.watch()`  | 监听 provider 的变化（自动重建）  |
| `.listen()` | 监听 provider 的变化（手动处理）  |

#### ✅ `.read()`

```dart
onPressed: () {
  final notifier = ref.read(counterNotifierProvider.notifier);
  notifier.increment();
}
```

#### ✅ `.watch()`

```dart
Widget build(BuildContext context, WidgetRef ref) {
  final count = ref.watch(counterNotifierProvider);
  return Text('Count: $count');
}
```

#### ✅ `.listen()`

```dart
@override
void initState() {
  super.initState();
  ref.listen<int>(
    counterNotifierProvider,
    (previous, next) {
      print('Count changed: $next');
    },
  );
}
```



---

## 3. 基本用法

### 3.1 创建 Provider

创建一个 `Provider` 通常使用 `Provider`、`StateProvider`、`FutureProvider` 等类型来提供数据。

```dart
// 创建一个简单的 provider 提供一个常量值
final helloProvider = Provider<String>((ref) => 'Hello, Riverpod!');
```

### 3.2 在 Widget 中使用 Provider

#### ✅ 使用 `Consumer`

`Consumer` 允许我们在某个 widget 内部监听 provider 的变化。适用于在局部范围内使用 `Provider`。

```dart
Widget build(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final greeting = ref.watch(helloProvider);
      return Text(greeting);
    },
  );
}
```

#### ✅ 使用 `ConsumerWidget`

`ConsumerWidget` 是一个更简洁的方式，适用于需要读取 provider 的 `Widget`。`ConsumerWidget` 会自动管理 `ref`。

```dart
class HelloWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = ref.watch(helloProvider);
    return Text(greeting);
  }
}
```

#### ✅ 使用 `ref.watch()` 和 `ref.read()`

* `ref.watch()`：监听并自动重建 widget。
* `ref.read()`：获取当前值，不会触发重建。

```dart
// 使用 ref.watch()
Widget build(BuildContext context, WidgetRef ref) {
  final greeting = ref.watch(helloProvider);
  return Text(greeting); // 自动重建
}

// 使用 ref.read()
Widget build(BuildContext context, WidgetRef ref) {
  final greeting = ref.read(helloProvider);
  return Text(greeting); // 不会重建 widget
}
```

### 3.3 使用 `ref.listen()` 做副作用响应

`ref.listen()` 用于监听 provider 的变化并执行副作用。适合处理例如 API 调用、日志记录等副作用操作。

```dart
// 在 StatefulWidget 中使用 ref.listen()
@override
void initState() {
  super.initState();
  ref.listen<int>(
    counterNotifierProvider,
    (previous, next) {
      if (next >= 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Counter reached 10!')),
        );
      }
    },
  );
}

// 使用时，只需要在 `build` 方法内监听并触发变化
Widget build(BuildContext context, WidgetRef ref) {
  final count = ref.watch(counterNotifierProvider);
  return Column(
    children: [
      Text('Count: $count'),
      ElevatedButton(
        onPressed: () => ref.read(counterNotifierProvider.notifier).increment(),
        child: Text('Increment'),
      ),
    ],
  );
}
```

#### ✅ 常见副作用：只在特定条件下执行

你可以在监听时判断变化，例如在状态达到某个值时执行某个操作：

```dart
// 只在 counter 达到 5 时执行
ref.listen<int>(
  counterNotifierProvider,
  (previous, next) {
    if (next == 5) {
      print('Counter reached 5!');
    }
  },
);
```


---

## 4. 状态管理进阶

### 4.1 使用 `StateProvider` 管理简单状态

`StateProvider` 用于管理简单的本地状态，适合不涉及复杂逻辑的状态。

```dart
final counterProvider = StateProvider<int>((ref) => 0);

Widget build(BuildContext context, WidgetRef ref) {
  final count = ref.watch(counterProvider);
  return Column(
    children: [
      Text('Count: $count'),
      ElevatedButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: Text('Increment'),
      ),
    ],
  );
}
```

### 4.2 使用 `StateNotifierProvider` 管理复杂状态

`StateNotifierProvider` 用于管理更复杂的状态逻辑，适合有多个状态、变更逻辑或需要封装方法的场景。

#### *创建 `StateNotifier` 类*

```dart
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0); // 初始值

  void increment() {
    state++; // 更新状态
  }

  void decrement() {
    state--; // 更新状态
  }

  void reset() {
    state = 0; // 重置状态
  }
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);

Widget build(BuildContext context, WidgetRef ref) {
  final count = ref.watch(counterNotifierProvider);

  return Column(
    children: [
      Text('Count: $count'),
      ElevatedButton(
        onPressed: () => ref.read(counterNotifierProvider.notifier).increment(),
        child: Text('Increment'),
      ),
      ElevatedButton(
        onPressed: () => ref.read(counterNotifierProvider.notifier).decrement(),
        child: Text('Decrement'),
      ),
      ElevatedButton(
        onPressed: () => ref.read(counterNotifierProvider.notifier).reset(),
        child: Text('Reset'),
      ),
    ],
  );
}
```

#### *状态监听与刷新*

`StateNotifierProvider` 会自动刷新 UI，当状态发生变化时，相关的 widget 会重新构建。

```dart
ref.listen<int>(
  counterNotifierProvider,
  (previous, next) {
    // 执行副作用，如日志记录等
    print('Counter changed: $next');
  },
);
```

---

### 4.3 使用 `NotifierProvider`（Riverpod 2.x 推荐）

`NotifierProvider` 是 Riverpod 2.x 中的新特性，它简化了状态管理的实现。

#### *`Notifier` 类的定义*

```dart
class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0; // 初始值

  void increment() {
    state++; // 更新状态
  }

  void decrement() {
    state--; // 更新状态
  }

  void reset() {
    state = 0; // 重置状态
  }
}

final counterNotifierProvider = NotifierProvider<CounterNotifier, int>(
  () => CounterNotifier(),
);

Widget build(BuildContext context, WidgetRef ref) {
  final count = ref.watch(counterNotifierProvider);

  return Column(
    children: [
      Text('Count: $count'),
      ElevatedButton(
        onPressed: () => ref.read(counterNotifierProvider.notifier).increment(),
        child: Text('Increment'),
      ),
      ElevatedButton(
        onPressed: () => ref.read(counterNotifierProvider.notifier).decrement(),
        child: Text('Decrement'),
      ),
      ElevatedButton(
        onPressed: () => ref.read(counterNotifierProvider.notifier).reset(),
        child: Text('Reset'),
      ),
    ],
  );
}
```

#### *`build()` 生命周期方法*

在 `Notifier` 类中，`build()` 方法用于初始化状态，类似于 `StateNotifier` 的构造方法。

```dart
class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0; // 通过 `build()` 方法返回初始状态
}
```

---

### 4.4 使用 `AsyncNotifierProvider` 处理异步逻辑

`AsyncNotifierProvider` 是处理异步状态的推荐方式，适合用于处理网络请求、文件操作等异步操作。

#### *处理异步逻辑*

```dart
class DataNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Data Loaded';
  }
}

final dataNotifierProvider = AsyncNotifierProvider<DataNotifier, String>(
  () => DataNotifier(),
);

Widget build(BuildContext context, WidgetRef ref) {
  final dataAsync = ref.watch(dataNotifierProvider);

  return dataAsync.when(
    data: (data) => Text(data),
    loading: () => CircularProgressIndicator(),
    error: (error, stackTrace) => Text('Error: $error'),
  );
}
```

#### *异步操作的错误处理与加载状态*

`AsyncNotifierProvider` 提供了 `when` 方法来处理加载、成功和错误状态。

```dart
dataAsync.when(
  data: (data) => Text('Data: $data'),
  loading: () => CircularProgressIndicator(),
  error: (error, stackTrace) => Text('Error: $error'),
);
```


---

## 5. 异步状态处理

### 5.1 使用 `FutureProvider` 处理异步请求

`FutureProvider` 用于处理异步操作（如网络请求、数据库读取等），其返回值类型为 `AsyncValue<T>`，包含 `data`、`loading`、`error` 三种状态。

```dart
final userNameProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 2)); // 模拟延迟
  return 'Hello, Riverpod!';
});

Widget build(BuildContext context, WidgetRef ref) {
  final userNameAsync = ref.watch(userNameProvider);

  return userNameAsync.when(
    data: (name) => Text(name),
    loading: () => CircularProgressIndicator(),
    error: (err, stack) => Text('Error: $err'),
  );
}
```

---

### 5.2 使用 `AsyncValue` 进行状态判断

Riverpod 的异步状态封装在 `AsyncValue<T>` 中，提供了多个方法来方便状态判断：

#### ✅ `when`

最常用方式，分别处理 `loading`、`data` 和 `error`。

```dart
final quoteProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 1));
  return 'Stay hungry, stay foolish.';
});

Widget build(BuildContext context, WidgetRef ref) {
  final quote = ref.watch(quoteProvider);

  return quote.when(
    data: (text) => Text(text),
    loading: () => CircularProgressIndicator(),
    error: (e, _) => Text('出错啦：$e'),
  );
}
```

---

#### ✅ `maybeWhen`

只处理感兴趣的状态，其他走 `orElse`。

```dart
Widget build(BuildContext context, WidgetRef ref) {
  final quote = ref.watch(quoteProvider);

  return quote.maybeWhen(
    data: (text) => Text(text),
    orElse: () => Text('Loading or error...'),
  );
}
```

---

#### ✅ `map`

使用 `map` 可以访问 `AsyncData`、`AsyncLoading`、`AsyncError` 类型，适用于更复杂的分支控制。

```dart
Widget build(BuildContext context, WidgetRef ref) {
  final quote = ref.watch(quoteProvider);

  return quote.map(
    data: (data) => Text(data.value),
    loading: (_) => CircularProgressIndicator(),
    error: (err) => Text('Oops: ${err.error}'),
  );
}
```

---

#### ✅ `whenOrNull`

只处理部分状态，不需要 `orElse`。

```dart
Widget build(BuildContext context, WidgetRef ref) {
  final quote = ref.watch(quoteProvider);

  final onlyData = quote.whenOrNull(
    data: (text) => Text('Quote: $text'),
  );

  return onlyData ?? Text('没有数据');
}
```

---




## 6. Provider 生命周期与作用域

### 6.1 `ProviderScope` 的作用

`ProviderScope` 是 Riverpod 的入口容器，所有 Provider 都必须在它的作用域内使用。它管理 Provider 的生命周期、依赖关系、缓存等。

在 `main.dart` 中通常这样使用：

```dart
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```

你也可以通过嵌套 `ProviderScope` 实现局部作用域（例如用户切换登录状态时重置状态）：

```dart
ProviderScope(
  overrides: [
    userProvider.overrideWithValue(null),
  ],
  child: LoginPage(),
)
```

---

### 6.2 Provider 的缓存与失效策略

默认情况下，Provider 是 **懒加载的**，只有当被监听或读取时才会创建，并且会自动缓存。

**缓存策略：**

* Provider 的值在没有被使用时不会立刻销毁。
* 如果没有使用 `autoDispose` 修饰，Provider 在不再使用后会继续保留，直到应用关闭。

```dart
final timeProvider = Provider<DateTime>((ref) {
  print('Provider initialized');
  return DateTime.now();
});
```

在多次使用 `ref.watch(timeProvider)` 时，只初始化一次，除非手动刷新或作用域被销毁。

---

### 6.3 自动销毁（autoDispose）

使用 `autoDispose` 修饰的 Provider，在其不再被使用时会自动清除并在下次使用时重新创建。

```dart
final autoDisposeProvider = Provider.autoDispose<int>((ref) {
  print('AutoDisposed provider created');
  return 100;
});
```

**场景示例：**
在页面跳转后不再需要某些 Provider 时，使用 `autoDispose` 可以节省内存，避免无用数据残留。

---

### 6.4 `ref.onDispose()` 注册清理函数

当你使用 `autoDispose` 或需要在 Provider 销毁时执行清理逻辑，可以通过 `ref.onDispose()` 注册一个回调函数。

```dart
final timerProvider = Provider.autoDispose<Timer>((ref) {
  final timer = Timer.periodic(Duration(seconds: 1), (timer) {
    print('Tick...');
  });

  ref.onDispose(() {
    timer.cancel();
    print('Timer disposed');
  });

  return timer;
});
```

在该 Provider 不再被监听时，会自动调用 `onDispose` 中注册的清理函数。

---

✅ 总结：

| 功能              | 使用方式                      | 是否自动清理 | 应用场景         |
| --------------- | ------------------------- | ------ | ------------ |
| `ProviderScope` | Widget 包裹                 | 否      | 管理作用域、注入依赖   |
| 默认 Provider     | `Provider<T>`             | 否      | 长期共享数据       |
| `autoDispose`   | `Provider.autoDispose<T>` | ✅      | 页面级、临时资源     |
| 清理函数            | `ref.onDispose()`         | ✅      | 定时器、控制器等资源释放 |




---

## 7. Provider 的嵌套与组合

### 7.1 Provider 的依赖注入

当一个 Provider 依赖其他 Provider 时，可以使用 `ref.watch()` 在其构建逻辑中注入依赖。

```dart
final nameProvider = Provider<String>((ref) => 'Alice');

final greetingProvider = Provider<String>((ref) {
  final name = ref.watch(nameProvider);
  return 'Hello, $name!';
});
```

使用：

```dart
class GreetingWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = ref.watch(greetingProvider);
    return Text(greeting);
  }
}
```

### 7.2 参数化 Provider（family）

使用 `.family` 可以让 Provider 接收参数，从而支持动态创建。

```dart
final userNameProvider = Provider.family<String, int>((ref, userId) {
  return 'User #$userId';
});
```

使用：

```dart
class UserNameWidget extends ConsumerWidget {
  final int userId;

  UserNameWidget(this.userId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userNameProvider(userId));
    return Text(name);
  }
}
```

### 7.3 条件刷新（select）

使用 `ref.watch().select()` 只监听状态中的部分字段，减少不必要的 rebuild。

```dart
final userProvider = StateProvider<User>((ref) {
  return User(name: 'Alice', age: 25);
});

class User {
  final String name;
  final int age;
  User({required this.name, required this.age});
}
```

使用 `select` 只监听 `name` 字段：

```dart
class UserNameOnlyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userProvider.select((user) => user.name));
    return Text('Name: $name');
  }
}
```



---

## 8. Riverpod 与 UI 分离

### 8.1 MVVM 架构中的使用

在 MVVM（Model-View-ViewModel）架构中，我们可以将 ViewModel 抽离为一个独立的 Provider，让 UI 只负责展示和响应状态变化。

**ViewModel 示例：**

```dart
class CounterViewModel extends StateNotifier<int> {
  CounterViewModel() : super(0);

  void increment() => state++;
}
```

**Provider：**

```dart
final counterProvider = StateNotifierProvider<CounterViewModel, int>((ref) {
  return CounterViewModel();
});
```

**View（UI）：**

```dart
class CounterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final viewModel = ref.read(counterProvider.notifier);

    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: viewModel.increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

### 8.2 与 Repository 模式结合

Repository 模式可以用于抽象数据来源（如 API、数据库等），从而让 ViewModel 不直接依赖实现细节。

**Repository：**

```dart
class UserRepository {
  Future<String> fetchUserName() async {
    await Future.delayed(Duration(seconds: 1));
    return 'Alice';
  }
}
```

**Repository Provider：**

```dart
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
```

**ViewModel：**

```dart
final userNameProvider = FutureProvider<String>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return await repository.fetchUserName();
});
```

**View（UI）：**

```dart
class UserNameWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncName = ref.watch(userNameProvider);

    return asyncName.when(
      data: (name) => Text('Hello, $name'),
      loading: () => CircularProgressIndicator(),
      error: (e, _) => Text('Error: $e'),
    );
  }
}
```

### 8.3 将业务逻辑与 UI 解耦

通过 ViewModel 和 Provider，业务逻辑不再直接写在 Widget 中，实现了良好的分层。

**示例：表单验证逻辑放在 ViewModel 中**

```dart
class LoginViewModel extends StateNotifier<bool> {
  LoginViewModel() : super(false);

  void validate(String username, String password) {
    state = username == 'admin' && password == '1234';
  }
}

final loginProvider = StateNotifierProvider<LoginViewModel, bool>((ref) {
  return LoginViewModel();
});
```

**UI：**

```dart
class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isValid = ref.watch(loginProvider);
    final viewModel = ref.read(loginProvider.notifier);

    return Column(
      children: [
        TextField(controller: _usernameController),
        TextField(controller: _passwordController, obscureText: true),
        ElevatedButton(
          onPressed: () {
            viewModel.validate(
              _usernameController.text,
              _passwordController.text,
            );
          },
          child: Text('Login'),
        ),
        if (isValid) Text('Login Successful') else Text('Invalid credentials'),
      ],
    );
  }
}
```


---

## 9. 调试与测试

### 9.1 ProviderObserver 用于监听状态变化

`ProviderObserver` 可以帮助我们观察状态变化，便于调试。

```dart
class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    print('Provider ${provider.name ?? provider.runtimeType} changed: $previousValue → $newValue');
  }
}
```

**启用 Observer：**

```dart
void main() {
  runApp(
    ProviderScope(
      observers: [Logger()],
      child: MyApp(),
    ),
  );
}
```

### 9.2 使用 `container.read()` 进行单元测试

使用 `ProviderContainer` 可以在测试中手动读取、操作 Provider。

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

void main() {
  test('Counter Provider increments correctly', () {
    final container = ProviderContainer();

    expect(container.read(counterProvider), 0);

    container.read(counterProvider.notifier).state++;

    expect(container.read(counterProvider), 1);
  });
}
```

### 9.3 编写 `StateNotifier` 的测试用例

针对使用 `StateNotifier` 管理状态的逻辑，我们可以更方便地进行业务逻辑单元测试。

**ViewModel 示例：**

```dart
class CounterViewModel extends StateNotifier<int> {
  CounterViewModel() : super(0);

  void increment() => state++;
}
```

**Provider：**

```dart
final counterProvider = StateNotifierProvider<CounterViewModel, int>((ref) {
  return CounterViewModel();
});
```

**测试用例：**

```dart
void main() {
  test('CounterViewModel increments state', () {
    final container = ProviderContainer();
    final viewModel = container.read(counterProvider.notifier);

    expect(container.read(counterProvider), 0);

    viewModel.increment();

    expect(container.read(counterProvider), 1);
  });
}
```


---

## 10. 常见问题与最佳实践

### 10.1 Provider 循环依赖如何解决

**问题描述：**
当两个 Provider 相互依赖时，会导致循环依赖错误。

**解决方案：**

* **重构依赖关系**：避免 Provider 直接相互依赖，尝试拆分逻辑。
* **延迟读取（`ref.read`）**：避免在 Provider 构造时立即调用 `ref.watch`，改为延迟调用。

```dart
final providerA = Provider<String>((ref) {
  // 不直接使用 watch，避免循环依赖
  final valueB = ref.read(providerB);
  return 'A uses $valueB';
});

final providerB = Provider<String>((ref) {
  final valueA = ref.read(providerA);
  return 'B uses $valueA';
});
```

注意：`ref.read` 只读取一次，不会订阅更新，避免死循环。

---

### 10.2 状态更新失败的原因排查

常见原因：

* **没有使用 `.notifier` 访问可变状态**，而是直接修改不可变的状态值。
* **在 Provider 外部修改状态**，而不是通过 StateNotifier 或 StateProvider 提供的方法。
* **Provider 生命周期问题**，比如 Provider 被错误地销毁。
* **异步操作未正确处理**，状态未及时更新。

示例正确修改状态：

```dart
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state = state + 1;
  }
}
```

UI 中：

```dart
ref.read(counterProvider.notifier).increment();
```

---

### 10.3 推荐的 Provider 架构组织方式

* **按功能模块划分**：每个模块包含自己的 Provider、Model、Repository。
* **状态与业务逻辑分离**：使用 `StateNotifier` 或 `ChangeNotifier` 管理状态。
* **Repository 层抽象数据访问**，ViewModel 只关心业务逻辑。
* **UI 只负责显示和事件响应，避免直接写复杂逻辑**。
* **使用 `.family` 和 `.autoDispose` 优化性能和内存管理**。

目录示例：

```
lib/
 ├── models/
 ├── repositories/
 ├── providers/
 ├── viewmodels/
 └── ui/
```

---

### 10.4 Riverpod 迁移建议（从 Provider / Riverpod v1）

* **命名空间变化**：Riverpod v2 移除了 `.read` 扩展，改为使用 `ref.read()`，所有访问统一通过 `ref` 完成。
* **ProviderScope 配置**更灵活，支持监听器等。
* **弃用 `ConsumerWidget` 中的 `watch`，改用 `ref.watch()`**。
* **更强大的 `family` 和 `autoDispose` 支持**。
* **建议逐步迁移，先替换主要 Provider，再更新依赖用法**。

简单迁移示例：

**Riverpod v1：**

```dart
final counterProvider = StateProvider<int>((ref) => 0);

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final count = watch(counterProvider).state;
    return Text('$count');
  }
}
```

**迁移到 Riverpod v2：**

```dart
final counterProvider = StateProvider<int>((ref) => 0);

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  }
}
```



---

## 11. Riverpod 与 Flutter 框架配合

### 11.1 与 `Navigator` 配合进行导航控制

使用 Riverpod 管理导航状态，可以让导航逻辑更集中、易测试。

```dart
final navigationProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(navigationProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Riverpod Navigator Example')),
      body: IndexedStack(
        index: pageIndex,
        children: [
          Center(child: Text('Page 0')),
          Center(child: Text('Page 1')),
          Center(child: Text('Page 2')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          ref.read(navigationProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

如果想结合 Flutter 的原生 `Navigator` 进行路由管理，也可以通过 Riverpod 维护路由状态，然后调用 `Navigator.of(context).push()`。

---

### 11.2 与 `ThemeMode` 配合切换主题

利用 Riverpod 统一管理主题状态，轻松实现主题切换。

```dart
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Riverpod Theme Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: ThemeSwitcherPage(),
    );
  }
}

class ThemeSwitcherPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Theme Switcher')),
      body: Center(
        child: SwitchListTile(
          title: Text('Dark Mode'),
          value: themeMode == ThemeMode.dark,
          onChanged: (value) {
            ref.read(themeModeProvider.notifier).state =
                value ? ThemeMode.dark : ThemeMode.light;
          },
        ),
      ),
    );
  }
}
```

---

### 11.3 与 `Form` 和表单状态结合使用

通过 Riverpod 管理表单字段状态，支持实时验证和状态共享。

```dart
final usernameProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');

class LoginForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final password = ref.watch(passwordProvider);

    bool isValid() {
      return username.isNotEmpty && password.length >= 6;
    }

    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            onChanged: (value) => ref.read(usernameProvider.notifier).state = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            onChanged: (value) => ref.read(passwordProvider.notifier).state = value,
          ),
          ElevatedButton(
            onPressed: isValid() ? () {
              // 处理登录逻辑
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in...')));
            } : null,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
```


---

## 12. Riverpod 最新版本（如 Riverpod 2.x）亮点

### 12.1 `Notifier` / `AsyncNotifier` 的统一 API

Riverpod 2.x 引入了新的 `Notifier` 和 `AsyncNotifier`，统一了同步和异步状态管理的 API，简化了代码结构。

* **Notifier** 用于同步状态管理，继承 `Notifier<T>`，重写 `build` 方法初始化状态。
* **AsyncNotifier** 用于异步状态管理，继承 `AsyncNotifier<T>`，支持异步 `build`。

示例：

```dart
import 'package:riverpod/riverpod.dart';

// 同步 Notifier 示例
class CounterNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

final counterProvider = NotifierProvider<CounterNotifier, int>(() => CounterNotifier());

// 异步 AsyncNotifier 示例
class AsyncUserNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    await Future.delayed(Duration(seconds: 1));
    return 'Alice';
  }

  Future<void> refreshUser() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // 模拟异步刷新
      await Future.delayed(Duration(seconds: 1));
      return 'Alice (updated)';
    });
  }
}

final asyncUserProvider = AsyncNotifierProvider<AsyncUserNotifier, String>(() => AsyncUserNotifier());
```

使用：

```dart
class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final notifier = ref.read(counterProvider.notifier);

    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: notifier.increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

---

### 12.2 `ProviderContainer` 统一控制容器

`ProviderContainer` 用于在没有 Flutter UI 的环境下（例如测试或后台任务）统一管理和访问 Provider。

示例：

```dart
void main() {
  final container = ProviderContainer();

  // 读取同步 Provider
  final count = container.read(counterProvider);
  print('Initial count: $count'); // 0

  // 访问 Notifier 修改状态
  final notifier = container.read(counterProvider.notifier);
  notifier.increment();

  print('After increment: ${container.read(counterProvider)}'); // 1

  // 读取异步 Provider (asyncUserProvider)
  container.listen<AsyncValue<String>>(asyncUserProvider, (previous, next) {
    print('Async user state changed: $next');
  });

  container.read(asyncUserProvider.future).then((user) {
    print('Async user loaded: $user');
  });
}
```

---

### 12.3 更好的类型推导与代码提示

Riverpod 2.x 对 Provider、Notifier 的泛型设计进行了改进，配合 Dart 的类型推导和 IDE 插件，带来更准确的代码补全和类型检查，减少类型错误。

示例：

```dart
final stringProvider = Provider<String>((ref) => 'Hello Riverpod');

final intProvider = Provider<int>((ref) => 42);

void example(WidgetRef ref) {
  // 类型推导自动生效
  String s = ref.watch(stringProvider);
  int i = ref.watch(intProvider);

  print('$s, number: $i');
}
```

在 IDE 中，你将获得更智能的代码提示，包括方法、字段和返回值类型提示，提升开发体验。




