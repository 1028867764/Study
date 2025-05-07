以下是对 Dart 官方文档核心内容的总结，涵盖基础语法、核心特性及进阶用法，适合快速掌握 Dart 语言的关键知识点：

---

# **1. 基础语法**
## **开始**
### **1.1.1 Hello World**
```dart
void main() {
  print('Hello, World!');
}
```
- `main()` 是程序入口，无返回值时自动推断为 `void`。
- `print()` 用于输出内容到控制台。

### **1.1.2 注释**
在 Dart 中，注释的使用方法和大多数编程语言类似。Dart 支持单行注释、多行注释和文档注释，下面是具体的说明和使用示例：

#### 1. **单行注释（Single-line comments）**

单行注释用于对代码中的某一行或部分进行简单说明。你可以在代码中使用 `//` 来标记单行注释。

```dart
// 这是一个单行注释
int a = 10; // 这是对代码后面部分的注释
```

#### 2. **多行注释（Multi-line comments）**

多行注释可以用于注释掉多行代码或对复杂的代码块进行说明。使用 `/*` 和 `*/` 来标记多行注释。

```dart
/*
这是一个多行注释
可以注释掉多行代码
或者解释较长的内容
*/
int a = 10;
int b = 20;
```

#### 3. **文档注释（Documentation comments）**

文档注释是 Dart 中用于生成文档的注释，通常用于函数、类和库的说明。文档注释使用 `///`（单行）或 `/** */`（多行）来创建，并且通常会与 Dart 的文档生成工具（如 `dartdoc`）结合使用。

- ##### 单行文档注释（以 `///` 开头）

```dart
/// 计算两个整数的和
/// [a] 和 [b] 是要相加的两个整数
/// 返回它们的和
int add(int a, int b) {
  return a + b;
}
```

- ##### 多行文档注释（以 `/**` 和 `*/` 包围）

```dart
/**
 * 计算两个整数的和。
 * 
 * [a] 和 [b] 是要相加的两个整数。
 * 返回它们的和。
 */
int add(int a, int b) {
  return a + b;
}
```

#### 4. **注释的最佳实践**

* **清晰明了**：注释应该简洁明了，不要解释显而易见的代码。只有在代码的意图或实现比较复杂时，才需要添加注释。
* **文档注释**：对于公共函数、类或库，使用文档注释（`///`）详细说明它们的功能和用法。这样有助于生成自动化文档，并让其他开发者容易理解代码的目的。
* **不要滥用注释**：尽量避免在代码中大量使用注释，而是通过命名清晰的变量和函数来提高代码的可读性。注释的目的是为了解释不直观的部分，而不是用来解释显而易见的内容。

#### 5. **生成文档**

使用 Dart 的 `dartdoc` 工具，你可以生成项目的文档。`dartdoc` 会提取文档注释并生成 HTML 格式的文档。

```bash
dart pub global activate dartdoc  # 激活 dartdoc
dart doc  # 生成文档
```

生成的文档通常包括你在代码中使用 `///` 和 `/** */` 注释的部分。

---

#### 总结

* **单行注释**：`//`，适用于简短说明。
* **多行注释**：`/* ... */`，适用于多行或块状注释。
* **文档注释**：`///` 或 `/** ... */`，用于自动生成文档，描述函数、类或库的用途。

注释是代码的重要组成部分，它帮助你和团队成员更好地理解和维护代码。


## **1.2 变量与类型**

### 1.2.1 变量声明与初始化
- **变量声明**：在Dart中，使用`var`关键字来声明一个变量，Dart会自动推断出变量类型。例如：
```dart
var num = 123; // Dart自动推断num为int类型
var str = 'Hello'; // Dart自动推断str为String类型
```
也可以在声明变量时明确指定其类型，这样能让代码更易于理解，并且在编译时检查到类型错误。示例如下：
```dart
String greeting = 'Hello Dart';
int age = 20;
```
Dart 2.12版本引入了空安全特性，如果变量可能含有空值，需要在类型后面加一个问号`?`。例如：
```dart
String? nullableString = null;
```
如果一个变量在初始化后值不再改变，可以使用`final`或`const`声明它。`final`的值只能被设定一次，而`const`是一个编译时常量。例如：
```dart
final pi = 3.14159;
const gravity = 9.8;
```
需要注意的是，`final`和`const`的区别在于，`final`的值可以在声明时不初始化，之后再赋值一次；而`const`必须在声明时初始化，并且其值在编译时就确定。

### 1.2.2 变量类型
#### 1.2.2.1 基本数据类型
- **数字类型（`num`）**：Dart中的数字类型分为`int`（整数）和`double`（浮点数），`num`是它们的父类。例如：
```dart
int a = 10; // 整数
double b = 10.5; // 浮点数
```
Dart还支持基本的数值运算，如加法、减法、乘法和除法等。此外，还有一些常用的方法，例如：
```dart
print(3.141592653.toStringAsFixed(3)); // 保留3位小数，输出3.142
print(6 ~/ 5 ); // 整除运算，输出1
```
- **字符串类型（`String`）**：用于表示文本数据，可以使用单引号或双引号创建字符串，也支持多行字符串。例如：
```dart
String greeting = 'Hello, Dart!';
String multiline = '''
Dart is a great programming language.
It is easy to learn and powerful.
''';
```
字符串是不可变的，一旦创建，其内容无法改变，若要更改内容，需生成新的字符串。
- **布尔类型（`bool`）**：只有两个取值`true`和`false`，常用于控制程序的执行流。例如：
```dart
bool isTrue = true;
bool isFalse = false;
print(isTrue && isFalse); // 输出false
```
- **列表（`List`）**：用于表示数组，是一种可变的、有序的集合，可以包含任何类型的对象。列表的索引从零开始，支持添加、删除和修改元素等操作。例如：
```dart
List fruits = ['Apple', 'Banana', 'Cherry'];
fruits.add('Mango'); // 添加元素
fruits = 'Blueberry'; // 修改元素
```
- **映射（`Map`）**：是一种键值对存储的集合，每个键都是唯一的，可以通过键来快速查找对应的值。例如：
```dart
Map ages = {'Alice': 25, 'Bob': 30};
print(ages['Alice']); // 输出25
ages['Charlie'] = 35; // 添加元素
```

#### 1.2.2.2 特殊数据类型
- **`dynamic`类型**：允许动态改变类型的变量，可以表示任何类型的值。在编译时不进行类型检查，允许在运行时动态改变类型，但使用时绕过了类型安全，要小心使用。例如：
```dart
dynamic value = 'Hello';
print(value); // 输出: Hello
value = 42;
print(value); // 输出: 42
```
- **`Object`类型**：是所有对象的父类，与Java中的`Object`类似。可以将`Object`类型的变量赋值为任何类型的对象，但在使用时，静态类型检查会更严格。

### 1.2.3 类型判断与转换
- **类型判断**：使用`is`和`is!`进行类型检查和类型非检查。例如：
```dart
int number = 100;
print(number is num); // true
print(number is! String); // true
```
- **类型转换**：Dart提供了一些内置方法来进行类型转换。例如，数字与字符串的转换可以使用`toString()`、`int.parse()`和`double.parse()`方法；列表与字符串的转换可以利用`join()`和`split()`方法。

## **1.3 数据类型**

### **1.3.1 基本数据类型**
#### **1.3.1.1 数值类型**
- **`int`**  
  整数类型，支持二进制、八进制、十进制和十六进制表示：
  ```dart
  int a = 42;          // 十进制
  int b = 0b1010;      // 二进制 (10)
  int c = 0o12;        // 八进制 (10)
  int d = 0xA;         // 十六进制 (10)
  ```

- **`double`**  
  浮点数类型（64位双精度）：
  ```dart
  double e = 3.14;
  double f = 2e3;      // 科学计数法 (2000.0)
  ```

#### **1.3.1.2 文本类型**
在 Dart 中，字符串是非常常用的数据类型。Dart 提供了许多强大的方法来操作字符串，涵盖了创建、访问、修改、搜索、格式化等多种常见操作。

##### 1. **字符串的创建**

```dart
String str1 = 'Hello, Dart!';  // 使用单引号
String str2 = "Hello, Dart!";  // 使用双引号
String str3 = '''Hello,
Dart!''';  // 使用三引号（多行字符串）
String str4 = """Hello,
Dart!""";  // 使用三引号（多行字符串）
```

##### 2. **字符串拼接**

```dart
String str1 = 'Hello';
String str2 = 'Dart';
String result = str1 + ', ' + str2 + '!';  // 使用 `+` 拼接
print(result);  // 输出: Hello, Dart!

// Dart 还支持使用插值操作（更推荐）
String result2 = '$str1, $str2!';
print(result2);  // 输出: Hello, Dart!
```

##### 3. **字符串长度**

```dart
String str = 'Hello, Dart!';
int length = str.length;
print(length);  // 输出: 13
```

##### 4. **访问字符串的单个字符**

```dart
String str = 'Hello, Dart!';
print(str[0]);  // 输出: H (访问第一个字符)
print(str[str.length - 1]);  // 输出: ! (访问最后一个字符)
```

##### 5. **查找子字符串**

```dart
String str = 'Hello, Dart!';
print(str.contains('Dart'));  // 输出: true（检查是否包含子字符串）
print(str.indexOf('Dart'));  // 输出: 7（返回子字符串的起始位置，-1表示找不到）
print(str.startsWith('Hello'));  // 输出: true（检查是否以某个子字符串开头）
print(str.endsWith('!'));  // 输出: true（检查是否以某个子字符串结尾）
```

##### 6. **提取子字符串**

```dart
String str = 'Hello, Dart!';
String substr = str.substring(7);  // 提取从索引7开始到结尾的子字符串
print(substr);  // 输出: Dart!

String substr2 = str.substring(0, 5);  // 提取从索引0到索引5的子字符串（不包括索引5）
print(substr2);  // 输出: Hello
```

##### 7. **替换字符串中的某些部分**

```dart
String str = 'Hello, Dart!';
String replaced = str.replaceAll('Dart', 'Flutter');
print(replaced);  // 输出: Hello, Flutter!
```

##### 8. **拆合字符串 `.split(',')` vs `.join(',')`**

```dart
//拆
String str = 'Hello, Dart, Flutter!';
List<String> parts = str.split(',');  // 按逗号分割字符串
print(parts);  // 输出: [Hello,  Dart,  Flutter!]

//合
List<String> list = ['a', 'b'];
String joined = list.join(','); // 转为字符串 "a,b"
```

##### 9. **去除空白字符**

```dart
String str = '   Hello, Dart!   ';
String trimmed = str.trim();  // 去除前后空白
print(trimmed);  // 输出: Hello, Dart!
```

##### 10. **字符串转换大小写**

```dart
String str = 'Hello, Dart!';
String upper = str.toUpperCase();  // 转为大写
String lower = str.toLowerCase();  // 转为小写
print(upper);  // 输出: HELLO, DART!
print(lower);  // 输出: hello, dart!
```

##### 11. **检查字符串是否为空**

```dart
String str = 'Hello, Dart!';
bool isEmpty = str.isEmpty;  // 检查是否为空字符串
print(isEmpty);  // 输出: false

String str2 = '';
bool isEmpty2 = str2.isEmpty;  // 检查是否为空字符串
print(isEmpty2);  // 输出: true

String? str = 'Hello';
if (str?.isNotEmpty == true) {
   print('字符串不为空');
 } else {
   print('字符串为空');
}
```
同理，还可以推广到集合，例如`List.isEmpty`、`List.isNotEmpty`、`Map.isEmpty`、`Map.isNotEmpty`等等


##### 12. **使用正则表达式进行字符串匹配**

```dart
String str = 'abc123def';
RegExp exp = RegExp(r'\d+');  // 匹配数字
Iterable<Match> matches = exp.allMatches(str);
for (var match in matches) {
  print(match.group(0));  // 输出: 123
}
```

##### 13. **字符串插值**

Dart 中的字符串插值非常直观和简单，允许直接在字符串中嵌入变量和表达式。你可以使用 `${}` 来插入表达式。

```dart
String name = 'Alice';
int age = 25;
String introduction = 'My name is $name and I am $age years old.';
print(introduction);  // 输出: My name is Alice and I am 25 years old.

String moreInfo = 'In 5 years, I will be ${age + 5} years old.';  // 使用表达式
print(moreInfo);  // 输出: In 5 years, I will be 30 years old.
```

##### 14. **常用的字符串方法**

| 方法              | 描述           |
| --------------- | ------------ |
| `toUpperCase()` | 转换为大写字母      |
| `toLowerCase()` | 转换为小写字母      |
| `trim()`        | 去除字符串两端的空白字符 |
| `isEmpty`       | 判断字符串是否为空    |
| `isNotEmpty`    | 判断字符串是否不为空    |
| `replaceAll()`  | 替换所有匹配的子字符串  |
| `split()`       | 按分隔符拆分字符串    |
| `contains()`    | 检查是否包含子字符串   |
| `substring()`   | 提取子字符串       |
| `indexOf()`     | 查找子字符串的索引位置  |
| `startsWith()`  | 判断是否以某个字符串开头 |
| `endsWith()`    | 判断是否以某个字符串结尾 |

---

##### 15. **示例：综合字符串操作**

```dart
void main() {
  String str = '  Dart is awesome!  ';

  // 去除两端空格并转换为大写
  String modified = str.trim().toUpperCase();
  print(modified);  // 输出: DART IS AWESOME!

  // 替换字符串中的某些字符
  String replacedStr = modified.replaceAll('DART', 'FLUTTER');
  print(replacedStr);  // 输出: FLUTTER IS AWESOME!

  // 分割字符串
  List<String> words = str.split(' ');
  print(words);  // 输出: [Dart, is, awesome!]

  // 使用插值
  String name = 'Alice';
  String greeting = 'Hello, $name! Welcome to Dart.';
  print(greeting);  // 输出: Hello, Alice! Welcome to Dart.
}
```

---

#### **1.3.1.3 布尔类型**
- **`bool`**  
  只有 `true` 和 `false` 两个值，用于条件判断：
  ```dart
  bool isActive = true;
  if (isActive) print('Active');
  ```

---

### **1.3.2 集合类型**
#### **1.3.2.1 `List`（数组）**
有序可变的集合，支持泛型：  

在 Dart 中，`List` 是一个非常常用的数据结构，用于存储有序的元素集合。Dart 提供了丰富的内置方法来操作 `List`，包括添加、删除、查找、排序等。下面是一些常见的 `List` 方法和操作的示例：

##### 1. **创建 List**

```dart
List<int> numbers = [1, 2, 3, 4, 5];  // 使用字面量创建 List
List<String> names = ['Alice', 'Bob', 'Charlie'];  // 使用字面量创建 String 类型的 List

// 使用构造函数创建空 List
List<int> emptyList = List<int>.empty();
List<int> filledList = List<int>.filled(5, 0);  // 创建一个长度为 5，且每个元素初始化为 0 的 List
```

##### 2. **访问 List 元素**

```dart
List<String> names = ['Alice', 'Bob', 'Charlie'];
print(names[0]);  // 输出: Alice
print(names.length);  // 输出: 3，List 的长度
```

##### 3. **添加元素**

* `add()`：添加一个元素到 List 的末尾。
* `addAll()`：将另一个 List 的所有元素添加到当前 List。
* `insert()`：在指定位置插入一个元素。
* `insertAll()`：在指定位置插入多个元素。

```dart
List<int> numbers = [1, 2, 3];

// 添加单个元素到末尾
numbers.add(4);
print(numbers);  // 输出: [1, 2, 3, 4]

// 添加多个元素
numbers.addAll([5, 6]);
print(numbers);  // 输出: [1, 2, 3, 4, 5, 6]

// 在指定位置插入一个元素
numbers.insert(2, 10);  // 在索引 2 位置插入 10
print(numbers);  // 输出: [1, 2, 10, 3, 4, 5, 6]

// 在指定位置插入多个元素
numbers.insertAll(4, [7, 8]);
print(numbers);  // 输出: [1, 2, 10, 3, 7, 8, 4, 5, 6]
```

##### 4. **删除元素**

* `remove()`：删除第一个匹配的元素。
* `removeAt()`：删除指定位置的元素。
* `removeLast()`：删除 List 中的最后一个元素。
* `removeWhere()`：删除符合条件的所有元素。
* `clear()`：清空 List 中的所有元素。

```dart
List<int> numbers = [1, 2, 3, 4, 5];

// 删除指定的元素
numbers.remove(3);  // 删除第一个匹配的 3
print(numbers);  // 输出: [1, 2, 4, 5]

// 删除指定位置的元素
numbers.removeAt(2);  // 删除索引为 2 的元素（元素 4）
print(numbers);  // 输出: [1, 2, 5]

// 删除最后一个元素
numbers.removeLast();  // 删除最后一个元素 5
print(numbers);  // 输出: [1, 2]

// 删除符合条件的元素
numbers.removeWhere((element) => element % 2 == 0);  // 删除所有偶数
print(numbers);  // 输出: [1]
```

##### 5. **查找元素**

* `indexOf()`：查找某个元素首次出现的索引，如果未找到则返回 -1。
* `lastIndexOf()`：查找某个元素最后一次出现的索引。
* `contains()`：判断 List 中是否包含某个元素。

```dart
List<String> names = ['Alice', 'Bob', 'Charlie'];

// 查找元素的索引
print(names.indexOf('Bob'));  // 输出: 1

// 查找元素的最后索引
print(names.lastIndexOf('Alice'));  // 输出: 0

// 判断元素是否存在
print(names.contains('Charlie'));  // 输出: true
```

##### 6. **排序和反转**

* `sort()`：对 List 进行排序。
* `reversed`：反转 List 的顺序。

```dart
List<int> numbers = [5, 3, 8, 1, 2];

// 排序
numbers.sort();
print(numbers);  // 输出: [1, 2, 3, 5, 8]

// 反转
var reversed = numbers.reversed;
print(reversed);  // 输出: (8, 5, 3, 2, 1)
```

##### 7. **转换和映射**

* `map()`：通过给 List 中的每个元素应用一个函数来转换元素。
* `where()`：过滤 List 中符合条件的元素。
* `toSet()`：将 List 转换为 Set，去除重复的元素。

```dart
List<int> numbers = [1, 2, 3, 4, 5];

// 使用 map() 转换元素
var doubled = numbers.map((e) => e * 2).toList();
print(doubled);  // 输出: [2, 4, 6, 8, 10]

// 使用 where() 过滤元素
var evenNumbers = numbers.where((e) => e % 2 == 0).toList();
print(evenNumbers);  // 输出: [2, 4]

// 转换为 Set（去重）
List<int> numbersWithDuplicates = [1, 2, 2, 3, 3, 4];
var uniqueNumbers = numbersWithDuplicates.toSet().toList();
print(uniqueNumbers);  // 输出: [1, 2, 3, 4]
```

##### 8. **其他常用方法**

* `forEach()`：遍历 List 中的每个元素。
* `join()`：将 List 中的元素连接为一个字符串。
* `first`：获取 List 中的第一个元素。
* `last`：获取 List 中的最后一个元素。
* `isEmpty`：判断 List 是否为空。

```dart
List<String> names = ['Alice', 'Bob', 'Charlie'];

// 遍历每个元素
names.forEach((name) => print(name));

// 将 List 中的元素连接为字符串
String result = names.join(', ');
print(result);  // 输出: Alice, Bob, Charlie

// 获取第一个和最后一个元素
print(names.first);  // 输出: Alice
print(names.last);   // 输出: Charlie

// 判断 List 是否为空
print(names.isEmpty);  // 输出: false
```

#### **1.3.2.2 `Map`**
键值对集合，键唯一：  

在 Dart 中，`Map` 是一种非常重要的数据结构，用于存储键值对。`Map` 提供了丰富的内置方法来操作和访问数据。下面是一些常见的 `Map` 方法和操作的示例。

##### 1. **创建 Map**

```dart
// 使用字面量创建 Map
Map<String, int> scores = {
  'Alice': 90,
  'Bob': 85,
  'Charlie': 88,
};

// 使用构造函数创建空 Map
Map<String, int> emptyMap = Map<String, int>();

// 使用 Map.from() 来创建一个新的 Map，复制另一个 Map 的内容
Map<String, int> copyMap = Map.from(scores);
```

##### 2. **访问 Map 元素**

```dart
Map<String, int> scores = {
  'Alice': 90,
  'Bob': 85,
  'Charlie': 88,
};

// 通过键访问值
print(scores['Alice']);  // 输出: 90

// 获取 Map 的长度
print(scores.length);  // 输出: 3

// 检查键是否存在
print(scores.containsKey('Bob'));  // 输出: true
print(scores.containsKey('David'));  // 输出: false

// 检查值是否存在
print(scores.containsValue(88));  // 输出: true
```

##### 3. **添加元素**

* `addAll()`：将另一个 `Map` 的键值对添加到当前 `Map`。
* `putIfAbsent()`：只有在指定键不存在时才添加键值对。
* `[]=`：通过键添加或更新值。

```dart
Map<String, int> scores = {
  'Alice': 90,
  'Bob': 85,
};

// 添加一个新键值对
scores['Charlie'] = 88;
print(scores);  // 输出: {Alice: 90, Bob: 85, Charlie: 88}

// 使用 addAll() 添加多个键值对
scores.addAll({'David': 92, 'Eve': 87});
print(scores);  // 输出: {Alice: 90, Bob: 85, Charlie: 88, David: 92, Eve: 87}

// 使用 putIfAbsent() 只有键不存在时才添加
scores.putIfAbsent('Frank', () => 80);
print(scores);  // 输出: {Alice: 90, Bob: 85, Charlie: 88, David: 92, Eve: 87, Frank: 80}
```

##### 4. **删除元素**

* `remove()`：根据键删除一个键值对。
* `removeWhere()`：根据条件删除符合条件的所有键值对。
* `clear()`：删除 `Map` 中的所有键值对。

```dart
Map<String, int> scores = {
  'Alice': 90,
  'Bob': 85,
  'Charlie': 88,
};

// 删除指定的键值对
scores.remove('Bob');
print(scores);  // 输出: {Alice: 90, Charlie: 88}

// 使用 removeWhere() 删除符合条件的键值对
scores.removeWhere((key, value) => value < 90);  // 删除值小于 90 的键值对
print(scores);  // 输出: {Alice: 90}

// 清空 Map
scores.clear();
print(scores);  // 输出: {}
```

##### 5. **查找元素**

* `keys`：返回 `Map` 中所有的键。
* `values`：返回 `Map` 中所有的值。
* `forEach()`：遍历 `Map` 中的每个键值对。

```dart
Map<String, int> scores = {
  'Alice': 90,
  'Bob': 85,
  'Charlie': 88,
};

// 获取所有的键
print(scores.keys);  // 输出: (Alice, Bob, Charlie)

// 获取所有的值
print(scores.values);  // 输出: (90, 85, 88)

// 遍历 Map
scores.forEach((key, value) {
  print('$key: $value');
});
// 输出:
// Alice: 90
// Bob: 85
// Charlie: 88
```

##### 6. **修改元素**

* `update()`：更新指定键的值。
* `updateAll()`：更新所有键值对，根据给定的函数更新值。

```dart
Map<String, int> scores = {
  'Alice': 90,
  'Bob': 85,
  'Charlie': 88,
};

// 更新指定键的值
scores.update('Alice', (value) => value + 5);
print(scores);  // 输出: {Alice: 95, Bob: 85, Charlie: 88}

// 如果指定键不存在，则可以提供一个默认值
scores.update('David', (value) => value + 5, ifAbsent: () => 100);
print(scores);  // 输出: {Alice: 95, Bob: 85, Charlie: 88, David: 100}

// 使用 updateAll() 更新所有值
scores.updateAll((key, value) => value + 2);
print(scores);  // 输出: {Alice: 97, Bob: 87, Charlie: 90, David: 102}
```

##### 7. **其他常用方法**

* `isEmpty`：判断 `Map` 是否为空。
* `isNotEmpty`：判断 `Map` 是否不为空。
* `addEntries()`：添加多个键值对。
* `putIfAbsent()`：当指定的键不存在时，添加一个键值对。

```dart
Map<String, int> scores = {
  'Alice': 90,
  'Bob': 85,
  'Charlie': 88,
};

// 判断 Map 是否为空
print(scores.isEmpty);  // 输出: false

// 判断 Map 是否不为空
print(scores.isNotEmpty);  // 输出: true

// 使用 addEntries() 添加多个键值对
scores.addEntries([
  MapEntry('David', 92),
  MapEntry('Eve', 87)
]);
print(scores);  // 输出: {Alice: 90, Bob: 85, Charlie: 88, David: 92, Eve: 87}
```

##### 8. **Map 复制与转换**

* `Map.from()`：从已有的 `Map` 创建一个新的 `Map`。
* `Map.of()`：从已有的键值对集合创建 `Map`。

```dart
Map<String, int> scores = {
  'Alice': 90,
  'Bob': 85,
  'Charlie': 88,
};

// 使用 Map.from() 创建新的 Map
Map<String, int> copiedScores = Map.from(scores);
print(copiedScores);  // 输出: {Alice: 90, Bob: 85, Charlie: 88}

// 使用 Map.of() 创建新的 Map
Map<String, int> newScores = Map.of({'David': 92, 'Eve': 87});
print(newScores);  // 输出: {David: 92, Eve: 87}
```

##### 总结

Dart 的 `Map` 提供了丰富的操作方法来处理键值对。常见的操作包括：

* **添加元素**：使用 `[]=`、`addAll()` 和 `putIfAbsent()`。
* **删除元素**：使用 `remove()`、`removeWhere()` 和 `clear()`。
* **查找元素**：使用 `containsKey()`、`containsValue()`、`keys` 和 `values`。
* **修改元素**：使用 `update()` 和 `updateAll()`。
* **遍历 Map**：使用 `forEach()`。
* **复制与转换**：使用 `Map.from()` 和 `Map.of()`。


#### **1.3.2.3 `Set`**
无序且不重复的集合：
```dart
Set<String> uniqueItems = {'a', 'b', 'c'};
uniqueItems.add('a'); // 无效（重复值）
print(uniqueItems);   // {a, b, c}
```

---

### **1.3.3 特殊数据类型**
#### **1.3.3.1 `dynamic`**
动态类型，绕过编译时类型检查（慎用）：
```dart
dynamic value = 42;
value = 'Hello';      // 合法但可能引发运行时错误
```

#### **1.3.3.2 `Object?`**
所有类型的超类，支持可空性（需启用空安全）：
```dart
Object? obj = null;   // 允许 null
if (obj is String) {
  print(obj.toUpperCase()); // 安全类型转换
}
```

---

### **1.3.4 类型安全与空安全**
- **类型推断**：Dart 会自动推断变量类型（如 `var x = 10` 推断为 `int`）。
- **非空断言**：在变量后加 `!` 告诉 Dart 该值不为 `null`（需确保安全）：
  ```dart
  String? nullableStr;
  print(nullableStr!.length); // 若 nullableStr 为 null 会抛出异常
  ```
- **空合并运算符**：`??` 提供默认值：
  ```dart
  String? name;
  print(name ?? 'Anonymous'); // 输出 'Anonymous'
  ```

---

### **1.3.5 类型转换**
- **数值与字符串**：
  ```dart
  int num = int.parse('123');    // 字符串转 int
  double d = double.parse('3.14');
  String s = 100.toString();     // int 转字符串
  ```
- **集合转换**：
  ```dart
  List<String> list = ['a', 'b'];
  String joined = list.join(','); // 转为字符串 "a,b"
  List<String> split = 'a,b'.split(','); // 字符串转列表
  ```

---

### **1.3.6 注意事项**
- **不可变性**：`String`、`List` 等基础类型默认不可变，修改需重新赋值。
- **性能优化**：频繁修改 `List` 时，可预分配容量：`List<int> list = List.filled(100, 0);`。

通过掌握这些数据类型和特性，可以高效编写安全且易维护的 Dart 代码！

---

## **1.4 运算符（Operators）**
---

### 1.4.1 算术运算符（Arithmetic Operators）

| 运算符  | 描述            | 示例（`a = 10, b = 3`） | 结果         |
| ---- | ------------- | ------------------- | ---------- |
| `+`  | 加法            | `a + b`             | `13`       |
| `-`  | 减法            | `a - b`             | `7`        |
| `*`  | 乘法            | `a * b`             | `30`       |
| `/`  | 除法（返回 double） | `a / b`             | `3.333...` |
| `~/` | 整除            | `a ~/ b`            | `3`        |
| `%`  | 取余（模）         | `a % b`             | `1`        |

---

### 1.4.2 关系运算符（Relational / Comparison Operators）

| 运算符  | 描述   | 示例（`a = 10, b = 3`） | 结果      |
| ---- | ---- | ------------------- | ------- |
| `==` | 等于   | `a == b`            | `false` |
| `!=` | 不等于  | `a != b`            | `true`  |
| `>`  | 大于   | `a > b`             | `true`  |
| `<`  | 小于   | `a < b`             | `false` |
| `>=` | 大于等于 | `a >= b`            | `true`  |
| `<=` | 小于等于 | `a <= b`            | `false` |

---

### 1.4.3 逻辑运算符（Logical Operators）

| 运算符  | 描述     | 示例（`a = true, b = false`） | 结果      |     |   |     |        |
| ---- | ------ | ------------------------- | ------- | --- | - | --- | ------ |
| `&&` | 与（AND） | `a && b`                  | `false` |     |   |     |       |
| `\|\|`   |  或（OR）      | `a \|\| b`        | `true` |
| `!`  | 非（NOT） | `!a`                      | `false` |     |   |     |        |

---

### 1.4.4 赋值运算符（Assignment Operators）

| 运算符   | 描述    | 示例（`a = 10`） | 结果    |
| ----- | ----- | ------------ | ----- |
| `=`   | 赋值    | `a = 10`     | `10`  |
| `+=`  | 加后赋值  | `a += 2`     | `12`  |
| `-=`  | 减后赋值  | `a -= 2`     | `8`   |
| `*=`  | 乘后赋值  | `a *= 2`     | `20`  |
| `/=`  | 除后赋值  | `a /= 2`     | `5.0` |
| `~/=` | 整除后赋值 | `a ~/= 3`    | `3`   |
| `%=`  | 取余后赋值 | `a %= 3`     | `1`   |

---


### 1.4.5 条件运算符（Conditional Operators）

- 三元运算符

```dart
var result = condition ? expr1 : expr2;
```

- 空值合并运算符（`??`）

```dart
String? name;
var finalName = name ?? '默认名';
```

- 空值赋值运算符（`??=`）

```dart
String? name;
name ??= '默认名';
```

---

### 1.4.6 类型运算符（Type Operators）

| 运算符   | 描述       | 示例               | 结果      |
| ----- | -------- | ---------------- | ------- |
| `is`  | 是否某类型    | `a is String`    | `true`  |
| `is!` | 不是某类型    | `a is! int`      | `true`  |
| `as`  | 类型转换（强制） | `obj as MyClass` | 转换为指定类型 |

---

### 1.4.7 其他运算符

| 运算符  | 描述             | 示例                        |
| ---- | -------------- | ------------------------- |
| `..` | 级联操作符（链式调用）    | `a..method1()..method2()` |
| `?`  | 可空类型标记         | `String? name;`           |
| `!`  | 非空断言（确保非 null） | `name!`                   |

---

#### ✅ 示例：级联运算符使用

```dart
class Person {
  String? name;
  int? age;

  void setName(String name) => this.name = name;
  void setAge(int age) => this.age = age;
}

void main() {
  var p = Person()
    ..setName("小李")
    ..setAge(28);
}
```

---


# **2. 控制流**

## **2.1 条件语句**
### **2.1.1 `if-else`**
- **基本语法**：
  ```dart
  int score = 85;
  if (score >= 90) {
    print('优秀');
  } else if (score >= 60) {
    print('及格');
  } else {
    print('不及格');
  }
  ```
- **特点**：
  - 条件表达式必须是布尔值（Dart 无隐式类型转换，`if (score)` 会报错）。
  - 支持嵌套 `if-else`。

### **2.1.2 `switch-case`**
- **基本语法**：
  ```dart
  String day = 'Monday';
  switch (day) {
    case 'Monday':
      print('工作日');
      break;
    case 'Saturday':
    case 'Sunday': // 多条件合并
      print('周末');
      break;
    default:
      print('其他');
  }
  ```
- **关键点**：
  - **必须用 `break`**：否则会继续执行下一个 `case`（无穿透行为）。
  - 支持任意类型（如 `int`、`String`、对象等）。
  - Dart 3.0+ 支持更复杂的模式匹配（需启用实验性功能）。

---

### **2.1.3 `continue` vs `break`**

| 语句 | 作用 |
|------|------|
| `continue` | 跳过当前循环的剩余部分，进入下一次迭代 |
| `break` | 直接终止整个循环 |

**示例对比**
```dart
for (int i = 0; i < 5; i++) {
  if (i == 2) {
    continue; // 跳过 i=2，继续循环
  }
  if (i == 4) {
    break; // 终止整个循环
  }
  print(i); // 输出: 0, 1, 3
}
```
**说明**：
- `continue` 跳过 `i=2`，但循环继续执行。
- `break` 直接终止循环，不再执行后续迭代。

---

## **2.2 循环结构**
### **2.2.1 `for` 循环**
#### **2.2.1.1 传统 `for`**：
  ```dart
  for (int i = 0; i < 5; i++) {
    print(i); // 输出 0, 1, 2, 3, 4
  }
  ```

#### **2.2.1.2 `for-in` 遍历集合**：
```dart
  void main() {
  // for-in 遍历列表
  List<String> fruits = ['Apple', 'Banana'];

  for (var fruit in fruits) {
    print(fruit); // 输出 Apple, Banana
  }

  // for-in 遍历键值对
  Map<String, int> scores = {'Alice': 90, 'Bob': 85, 'Charlie': 95};

  for (var entry in scores.entries) {
    print('${entry.key}: ${entry.value}');
    // 输出:
    // Alice: 90
    // Bob: 85
    // Charlie: 95
  }
}
```

#### **2.2.1.3 `forEach` 遍历集合**：
```dart
void main() {
  // forEach 遍历列表
  List<String> fruits = ['Apple', 'Banana', 'Orange'];

  fruits.forEach((fruit) {
    print(fruit); // 依次输出: Apple, Banana, Orange
  });

  // forEach 遍历键值对
    Map<String, int> scores = {'Alice': 90, 'Bob': 85, 'Charlie': 95};

  scores.forEach((key, value) {
    print('$key: $value');
    // 输出:
    // Alice: 90
    // Bob: 85
    // Charlie: 95
  });
}
```

#### **2.2.1.4 `for-in` vs `forEach`**
- **优先用 `forEach`**：  
  当只需要简单遍历且无需中断时，`forEach` 更简洁：
  ```dart
  List<int> numbers = [1, 2, 3];
  numbers.forEach(print); // 直接传函数
  ```

- **用 `for-in` 处理复杂逻辑**：  
  需要中断循环或处理键值对时：
  ```dart
  for (var entry in scores.entries) {
    if (entry.value < 90) continue; // 跳过低分
    print('${entry.key} passed!');
  }
  ```

#### **2.2.1.5 `for-in` 嵌套循环遍历**



##### 示例 1：三维列表遍历（蔬菜分类）
```dart
void main() {
  // 定义一个三维列表，表示不同类别的蔬菜，每个类别下还有子类别
  List<List<List<String>>> vegetables = [
    // 叶菜类
    [
      ["小白菜", "大白菜"], // 小白菜和大白菜是叶菜类的子类别
      ["生菜", "油麦菜"]
    ],
    // 根茎类
    [
      ["胡萝卜", "白萝卜"],
      ["土豆", "红薯"] // 红薯也是根茎类蔬菜
    ],
    // 果菜类
    [
      ["西红柿", "黄瓜"],
      ["茄子", "辣椒"] // 辣椒属于果菜类
    ]
  ];

  print("=== 蔬菜分类遍历 ===");
  // 外层循环遍历每个大类别
  for (var bigCategory in vegetables) {
    // 中层循环遍历每个大类别下的子类别
    for (var subCategory in bigCategory) {
      // 内层循环遍历当前子类别的每种蔬菜
      for (var veg in subCategory) {
        print(veg); // 输出蔬菜名称
      }
    }
  }

  // 输出结果：
  // === 蔬菜分类遍历 ===
  // 小白菜
  // 大白菜
  // 生菜
  // 油麦菜
  // 胡萝卜
  // 白萝卜
  // 土豆
  // 红薯
  // 西红柿
  // 黄瓜
  // 茄子
  // 辣椒
}
```



##### 示例 2：嵌套循环应用（水果与饮料搭配）
```dart
void main() {
  // 定义水果列表
  List<String> fruits = ["苹果", "香蕉", "橙子"];
  // 定义饮料列表
  List<String> drinks = ["牛奶", "果汁", "茶"];

  print("\n=== 水果与饮料搭配推荐 ===");
  // 外层循环遍历每种水果
  for (var fruit in fruits) {
    // 内层循环遍历每种饮料
    for (var drink in drinks) {
      print("$fruit + $drink"); // 输出搭配组合
    }
  }

  // 输出结果：
  // === 水果与饮料搭配推荐 ===
  // 苹果 + 牛奶
  // 苹果 + 果汁
  // 苹果 + 茶
  // 香蕉 + 牛奶
  // 香蕉 + 果汁
  // 香蕉 + 茶
  // 橙子 + 牛奶
  // 橙子 + 果汁
  // 橙子 + 茶
}
```


##### 示例 3：树形结构遍历（饮品分类）
```dart
class DrinkNode {
  String name;
  List<DrinkNode> subTypes;

  DrinkNode(this.name, [this.subTypes = const []]);
}

void main() {
  // 构建饮品分类树
  DrinkNode root = DrinkNode("饮品", [
    DrinkNode("热饮", [
      DrinkNode("咖啡"),
      DrinkNode("茶")
    ]),
    DrinkNode("冷饮", [
      DrinkNode("碳酸饮料", [
        DrinkNode("可乐"),
        DrinkNode("雪碧")
      ]),
      DrinkNode("果汁")
    ])
  ]);

  print("\n=== 饮品分类遍历（先序） ===");
  void traverse(DrinkNode node) {
    if (node == null) return;
    print(node.name); // 先访问当前节点
    for (var child in node.subTypes) {
      traverse(child); // 递归遍历子节点
    }
  }
  traverse(root);

  // 输出结果：
  // === 饮品分类遍历（先序） ===
  // 饮品
  // 热饮
  // 咖啡
  // 茶
  // 冷饮
  // 碳酸饮料
  // 可乐
  // 雪碧
  // 果汁
}
```

---

##### 关键点说明

1. **三维列表遍历**  
   - 结构：`List<List<List<T>>>` 表示分类数据
   - 应用：适合处理表格型数据（如超市货架分类）

2. **嵌套循环应用**  
   - 结构：`for-in` 嵌套 `for-in`
   - 应用：生成所有可能的组合（如菜单搭配）

3. **树形结构遍历**  
   - 结构：自定义类 + 递归
   - 应用：层级数据（如分类目录）

---

##### 输出结果对比

| 示例 | 数据结构 | 遍历方式 | 输出特点 |
|------|----------|----------|----------|
| 1    | 三维列表 | 顺序遍历 | 按类别分组输出 |
| 2    | 两个列表 | 笛卡尔积 | 生成所有组合 |
| 3    | 树形结构 | 递归先序 | 深度优先遍历 |


---

### **2.2.2 `while` 和 `do-while`**
- **`while`**（先判断条件）：
  ```dart
  int count = 0;
  while (count < 3) {
    print(count); // 输出 0, 1, 2
    count++;
  }
  ```
- **`do-while`**（至少执行一次）：
  ```dart
  int num = 0;
  do {
    print(num); // 输出 0
    num++;
  } while (num < 0); // 条件不满足，仅执行一次
  ```

---

## **2.3 断言（Debugging）**
- **基本语法**：
  ```dart
  int age = -5;
  assert(age >= 0, '年龄不能为负数'); // 抛出 AssertionError
  ```
- **特点**：
  - 仅在 **调试模式** 下生效（发布版本会被移除）。
  - 第二个参数为可选错误信息。
  - 常用于验证输入或中间状态。

---

## **2.4 控制流进阶技巧**
### **2.4.1 级联操作（Cascade）**
结合循环简化代码：
```dart
List<int> numbers = [1, 2, 3];
numbers..add(4) // 级联调用
       ..forEach(print); // 输出 1, 2, 3, 4
```

### **2.4.2 三元表达式（Ternary Operator）**
替代简单 `if-else`：
```dart
int a = 10, b = 20;
String result = (a > b) ? 'a大' : 'b大'; // 输出 'b大'
```

### **2.4.3 空安全与控制流**
Dart 3.0+ 支持更安全的空值处理：
```dart
String? name;
print(name?.toUpperCase() ?? '匿名'); // 输出 '匿名'（若 name 为 null）
```

---


## **2.5 注意事项**
### 2.5.1 **类型严格性**：  
   条件表达式必须返回布尔值，`if (score)` 会报错（需显式写 `if (score > 0)`）。
### 2.5.2 **`switch` 的局限性**：  
   Dart 不支持 `fall-through`（除非显式省略 `break`），但可通过 `case` 合并实现多条件。
### 2.5.3 **性能优化**：  
   - 避免在循环内重复计算（如 `for (int i = 0; i < list.length; i++)` 可缓存 `list.length`）。
   - 大集合遍历优先用 `for-in` 或 `forEach`（代码更简洁）。



---

# **3. 函数**

## **3.1 函数基础语法**
### **3.1.1 标准函数定义**
```dart
// 传统写法（多行）
int add(int a, int b) {
  return a + b;
}

// 箭头函数（单行，自动返回）
int multiply(int a, int b) => a * b;
```

### **3.1.2 函数类型**
- 显式声明函数类型变量：
  ```dart
  int Function(int, int) mathOperation = (a, b) => a + b;
  print(mathOperation(2, 3)); // 输出 5
  ```

---

## **3.2 参数类型**
### **3.2.1 必需参数**
- 直接声明的参数为必需参数：
  ```dart
  void greet(String name) {
    print('Hello, $name!');
  }
  greet('Dart'); // 正确
  // greet();    // 编译错误：缺少参数
  ```

### **3.2.2 可选参数**
#### **3.2.2.1 命名参数（`{param}`）**
- 用 `{}` 包裹，调用时可省略：
  ```dart
  void configure({bool debug = false, String? name}) {
    print('Debug: $debug, Name: $name');
  }
  
  configure(debug: true); // 输出: Debug: true, Name: null
  ```

#### **3.2.2.2 位置参数（`[param]`）**
- 用 `[]` 包裹，调用时按顺序可选：
  ```dart
  void log(String message, [int? code]) {
    print('$message (Code: $code)');
  }
  
  log('Error');          // 输出: Error (Code: null)
  log('Error', 404);     // 输出: Error (Code: 404)
  ```

### **3.2.3 默认值**
- 为可选参数设置默认值：
  ```dart
  void greet(String name, {int times = 1}) {
    for (int i = 0; i < times; i++) {
      print('Hello, $name!');
    }
  }
  
  greet('Dart');          // 输出 1 次
  greet('Dart', times: 3); // 输出 3 次
  ```

---

## **3.3 高级函数特性**
### **3.3.1 函数作为参数**
- 将函数作为参数传递：
  ```dart
  void execute(Function operation) {
    operation(5, 3);
  }
  
  execute((a, b) => print(a - b)); // 输出 2
  ```

### **3.3.2 匿名函数**
- 直接定义未命名的函数：
  ```dart
  var list = [1, 2, 3];
  list.forEach((item) => print(item)); // 输出 1, 2, 3
  ```

### **3.3.3 闭包（Closure）**
- 函数可捕获外部变量：
  ```dart
  int factor = 2;
  var multiplier = (int x) => x * factor;
  print(multiplier(5)); // 输出 10
  ```

---

## **3.4 函数返回值**
在Dart中，函数的返回值可以是多种类型，包括基本数据类型（如`int`、`double`等）、对象类型（如`String`、`Widget`等），当函数没有显式使用`return`语句返回值时，默认返回`null`。以下是一些不同返回值类型的函数示例：

### 3.4.1 返回`int`类型
```dart
// 计算两个整数的和
int add(int a, int b) {
  return a + b;
}

void main() {
  int result = add(3, 5);
  print(result); // 输出 8
}
```
在这个例子中，`add`函数的返回类型是`int`，它接收两个整数参数`a`和`b`，并返回它们的和。

### 3.4.2 返回`String`类型
```dart
// 拼接两个字符串
String joinStrings(String str1, String str2) {
  return str1 + str2;
}

void main() {
  String combined = joinStrings('Hello', ' World');
  print(combined); // 输出 Hello World
}
```
这里`joinStrings`函数的返回类型为`String`，它将传入的两个字符串拼接起来并返回结果。

### 3.4.3 返回`Widget`类型（以Flutter为例）
```dart
import 'package:flutter/material.dart';

// 创建一个简单的文本组件
Widget createTextWidget(String text) {
  return Text(text);
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: createTextWidget('Hello, Flutter!'),
      ),
    ),
  ));
}
```
在Flutter开发中，`Widget`是构建用户界面的基本单元。`createTextWidget`函数接收一个字符串参数，返回一个`Text`类型的`Widget`，用于在界面上显示文本。

### 3.4.4 隐式返回`null`的情况
```dart
// 根据条件返回不同的字符串，若不满足条件则隐式返回 null
String? findGreeting(String name) {
  if (name == 'Bob') {
    return 'Hello, Bob!';
  }
  // 没有 return 语句，隐式返回 null
}

void main() {
  String? greeting = findGreeting('Alice');
  print(greeting); // 输出 null
}
```
此例中，`findGreeting`函数只有在传入的`name`为`'Bob'`时才会返回一个字符串，其他情况下没有`return`语句，会隐式返回`null`。

### 3.4.5 返回`double`类型
```dart
// 计算两个数的平均值
double calculateAverage(double num1, double num2) {
  return (num1 + num2) / 2;
}

void main() {
  double average = calculateAverage(10.5, 20.5);
  print(average); // 输出 15.5
}
```
`calculateAverage`函数的返回类型是`double`，它接收两个双精度浮点数参数，计算并返回它们的平均值。

## **3.5 注意事项**
1. **参数顺序**：  
   命名参数 `{}` 必须在位置参数 `[]` 之后：
   ```dart
   // 正确
   void func(int a, {int b}) {}
   
   // 错误
   void func({int b}, int a) {} // 编译错误
   ```

2. **可选参数限制**：  
   命名参数不能有默认值的冲突（如两个同名参数）。

3. **箭头函数限制**：  
   箭头函数只能用于单行表达式，多行逻辑需用传统写法：
   ```dart
   // 错误示例
   int add(int a, int b) => {
     print('Adding...');
     a + b // 缺少分号或括号会报错
   };
   
   // 正确写法
   int add(int a, int b) {
     print('Adding...');
     return a + b;
   }
   ```

---

## **3.6 实际应用示例**
### **3.6.1 回调函数**
```dart
void fetchData(void Function(String) callback) {
  callback('Data loaded');
}

fetchData((data) => print(data)); // 输出: Data loaded
```

### **3.6.2 高阶函数（返回函数）**
```dart
Function createMultiplier(int factor) {
  return (int x) => x * factor;
}

var doubleIt = createMultiplier(2);
print(doubleIt(5)); // 输出 10
```

---

## **3.7 总结**
Dart 的函数设计灵活，支持：
- **简洁语法**（箭头函数、默认参数）
- **灵活调用**（命名参数、位置参数）
- **函数式编程**（闭包、高阶函数）

掌握这些特性可显著提升代码可读性和复用性！

---

# **4. 面向对象**

## **4.1 类与对象（Class & Object）**
### **4.1.1 基础定义**
```dart
class Person {
  // 属性（字段）
  String name;
  int age;
  
  // 构造函数（语法糖）
  Person(this.name, this.age);
  
  // 方法
  void introduce() {
    print('I am $name, $age years old.');
  }
  
  // 命名构造函数; 初始化列表以冒号 ':' 开头
  Person.fromJson(Map<String, dynamic> json) 
      : name = json['name'] ?? 'Unknown',//变量赋值
        age = json['age'] ?? 0; // 变量赋值
} 

void main() {
  // 实例化对象
  var person1 = Person('Alice', 25);
  person1.introduce(); // 输出: I am Alice, 25 years old.
  
  // 使用命名构造函数
  var person2 = Person.fromJson({'name': 'Bob'});
  print(person2.name); // 输出: Bob
}
```

### **4.1.2 Getter/Setter**
```dart
class Circle {
  double _radius = 0; // 私有字段（约定用下划线前缀）
  
  // Getter
  double get radius => _radius;
  
  // Setter（带验证逻辑）
  set radius(double value) {
    if (value > 0) {
      _radius = value;
    } else {
      throw ArgumentError('Radius must be positive');
    }
  }
  
  // 计算面积
  double get area => 3.14159 * _radius * _radius;
}

void main() {
  var circle = Circle();
  circle.radius = 5; // 调用setter
  print(circle.area); // 输出: 78.53975
}
```

---

## **4.2 继承与混入（Inheritance & Mixin）**
### **4.2.1 单继承**
```dart
class Animal {
  void breathe() => print('Breathing...');
}

class Dog extends Animal {
  void bark() => print('Woof!');
  
  // 覆盖父类方法
  @override
  void breathe() {
    super.breathe(); // 调用父类方法
    print('Dog is panting');
  }
}

void main() {
  var dog = Dog();
  dog.breathe(); // 输出: Breathing... \n Dog is panting
  dog.bark();    // 输出: Woof!
}
```

### **4.2.2 混入（Mixin）**
```dart
mixin Flyable {
  void fly() => print('Flying...');
}

mixin Swimmable {
  void swim() => print('Swimming...');
}

class Duck extends Animal with Flyable, Swimmable {
  // 同时拥有飞行和游泳能力
}

void main() {
  var duck = Duck();
  duck.fly();  // 输出: Flying...
  duck.swim(); // 输出: Swimming...
}
```

---

## **4.3 构造函数进阶**
### **4.3.1 初始化列表**
```dart
class Point {
  final int x;
  final int y;
  
  // 初始化列表
  Point(this.x, this.y)
      : assert(x >= 0 && y >= 0, 'Coordinates must be positive');
}

void main() {
  var p = Point(1, 2); // 正常
  // var p = Point(-1, 2); // 抛出异常
}
```

### **4.3.2 常量构造函数**
```dart
class ImmutablePoint {
  final int x;
  final int y;
  
  // 常量构造函数
  const ImmutablePoint(this.x, this.y);
  
  // 静态常量实例
  static const zero = ImmutablePoint(0, 0);
}

void main() {
  var p1 = const ImmutablePoint(1, 2); // 编译时常量
  var p2 = ImmutablePoint.zero;        // 使用静态常量
}
```

---

## **4.4 抽象类与接口**
### **4.4.1 抽象类**
```dart
abstract class Shape {
  // 抽象方法（无实现）
  double getArea();
  
  // 具体方法
  void describe() => print('This is a shape');
}

class Rectangle implements Shape {
  final double width;
  final double height;
  
  Rectangle(this.width, this.height);
  
  @override
  double getArea() => width * height;
}

void main() {
  var rect = Rectangle(3, 4);
  print(rect.getArea()); // 输出: 12
}
```

### **4.4.2 接口实现**
```dart
class Printer {
  void printDocument(String content) => 
      print('Printing: $content');
}

class MultiFunctionDevice implements Printer {
  @override
  void printDocument(String content) {
    // 实现接口方法
    print('Advanced printing: $content');
  }
  
  // 可添加额外功能
  void scan() => print('Scanning...');
}
```

---

## **4.5 方法与运算符重载**
### **4.5.1 方法重载（Dart风格）**
```dart
class Calculator {
  // 方法1：两数相加
  int add(int a, int b) => a + b;
  
  // 方法2：三数相加（通过可选参数实现）
  int add(int a, int b, [int c = 0]) => a + b + c;
}

void main() {
  var calc = Calculator();
  print(calc.add(1, 2));    // 输出: 3
  print(calc.add(1, 2, 3)); // 输出: 6
}
```

### **4.5.2 运算符重载**
```dart
class Vector {
  final double x;
  final double y;
  
  Vector(this.x, this.y);
  
  // 重载加法运算符
  Vector operator +(Vector other) => 
      Vector(x + other.x, y + other.y);
      
  // 重载相等运算符
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Vector && 
           x == other.x && 
           y == other.y;
  }
  
  @override
  int get hashCode => Object.hash(x, y);
}

void main() {
  var v1 = Vector(1, 2);
  var v2 = Vector(3, 4);
  print(v1 + v2); // 输出: Vector(4, 6)
}
```

---

## **4.6 高级特性**
### **4.6.1 工厂构造函数**
```dart
class Logger {
  final String name;
  
  // 私有构造函数
  Logger._internal(this.name);
  
  // 工厂构造函数
  factory Logger(String name) {
    if (name.isEmpty) {
      return Logger._internal('Default');
    }
    return Logger._internal(name);
  }
}

void main() {
  var logger = Logger('');
  print(logger.name); // 输出: Default
}
```

### **4.6.2 枚举类型**
```dart
enum Color { red, green, blue }

void main() {
  var color = Color.red;
  
  // 获取所有枚举值
  print(Color.values); 
  
  // 获取枚举名称和索引
  print(color.name);   // 输出: red
  print(color.index);  // 输出: 0
  
  // 模式匹配
  switch (color) {
    case Color.red:
      print('Stop');
      break;
    case Color.green:
      print('Go');
      break;
  }
}
```

---

## **4.7 最佳实践**
### **4.7.1 命名规范**：
   - 类名：`PascalCase`（如 `UserAccount`）
   - 方法/变量：`camelCase`（如 `calculateTotal`）
   - 常量：`SCREAMING_SNAKE_CASE`（如 `MAX_RETRIES`）

### **4.7.2 空安全处理**：
   ```dart
   String? nullableString;
   print(nullableString?.length ?? 0); // 安全访问
   ```

### **4.7.3 不可变设计**：
   ```dart
   class ImmutablePoint {
     final double x;
     const ImmutablePoint(this.x);
   }
   ```

### **4.7.4 方法参数设计**：
   - 必需参数放在前面
   - 可选参数用 `{}` 或 `[]` 包裹
   - 避免过多可选参数（超过3个考虑使用对象封装）

---

## **4.8 实际应用示例**
### **4.8.1 数据模型类**
```dart
class User {
  final String id;
  final String name;
  final DateTime? createdAt;
  
  User({
    required this.id,
    required this.name,
    this.createdAt,
  });
  
  // 工厂构造函数（从JSON创建）
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
    );
  }
  
  // 转换为JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt?.toIso8601String(),
  };
}
```

### **4.8.2 响应式属性**
```dart
class Counter {
  int _value = 0;
  
  int get value => _value;
  
  set value(int newValue) {
    if (_value != newValue) {
      _value = newValue;
      _notifyListeners();
    }
  }
  
  final List<void Function()> _listeners = [];
  
  void addListener(void Function() listener) {
    _listeners.add(listener);
  }
  
  void _notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}
```





---

# **5. 异步编程**

## **5.0 为什么要异步编程？**

Dart采用单线程模型，这意味着所有代码都在一个主线程上顺序执行。在这样的模型下，异步编程显得尤为重要，主要体现在以下几个方面：

### 避免程序阻塞
在单线程环境中，如果执行耗时操作（如网络请求、文件读写等）时不采用异步编程，程序会被阻塞，无法响应其他事件。例如，在Flutter应用里，若从服务器获取数据时使用同步方式，界面会被冻结，用户无法进行其他操作，严重影响用户体验。而异步编程允许程序在等待耗时操作完成的同时继续执行其他任务，保证了程序的流畅性和响应性。就像厨师在烹饪一道菜时，利用异步编程可以让他在等待食材煮熟的时间里去准备下一道菜的食材，不会因为一道菜的烹饪而耽误其他工作。

### 提高程序性能
单线程模型下，异步编程能充分利用系统资源，提高程序的整体性能。通过事件循环机制，Dart可以在等待异步操作完成时执行其他任务，避免了资源的浪费。比如在进行网络请求时，使用异步编程可以让程序在等待服务器响应的同时处理其他事务，从而提高了程序的吞吐量和响应速度。以服务器处理多个请求为例，异步编程可以让服务器同时处理多个请求，而不是一个一个地等待每个请求完成后再处理下一个，大大提高了服务器的并发处理能力。

### 简化并发编程
Dart的单线程模型避免了多线程环境下的竞态条件和同步问题，开发者无需担心复杂的锁机制和线程安全问题。异步编程通过事件循环和队列机制，以一种简单而有序的方式处理并发任务。开发者只需要关注任务的执行顺序和依赖关系，而不需要手动管理线程的创建、销毁和同步，降低了开发难度和出错的可能性。例如，在Java等多线程语言中，开发者需要使用锁来保证线程安全，而在Dart中，由于是单线程模型，这些问题都得到了简化。

### 保证UI响应性
在UI框架如Flutter中，单线程模型有助于保持UI更新的简洁性和一致性。所有的UI更新操作都在主线程上执行，异步编程可以确保在执行耗时操作时不会阻塞UI线程，从而保证界面的流畅响应。例如，当用户在Flutter应用中进行滑动、点击等操作时，异步编程可以让程序在后台处理数据，而不会影响界面的交互体验。如果使用同步编程，界面可能会因为耗时操作而卡顿，给用户带来不好的体验。

综上所述，尽管Dart是单线程模型，但异步编程在其中起着至关重要的作用，它可以让程序在单线程环境下实现高效的并发处理，提高程序的性能和响应能力，同时简化开发过程。

---

## **5.1 Future（未来值）**
### **5.1.1 基本概念**
`Future` 表示异步操作的结果，可能成功（返回值）或失败（抛出异常）。  
Dart 中大多数异步 API 都返回 `Future`。

### **5.1.2 创建 Future**
```dart
// 1. 使用 Future.value 创建已完成的 Future
Future<String> getUserName() => Future.value('Alice');

// 2. 使用 Future.delayed 模拟延迟操作
Future<void> delayedTask() async {
  await Future.delayed(Duration(seconds: 1));
  print('Delayed task completed');
}
```

### **5.1.3 处理 Future**
```dart
Future<int> calculate() async {
  return 42; // 等价于 return Future.value(42);
}

void main() async {
  // 方式1：then-catch
  calculate().then((result) {
    print('Result: $result');
  }).catchError((error) {
    print('Error: $error');
  });

  // 方式2：async-await（推荐）
  try {
    int result = await calculate();
    print('Result: $result');
  } catch (e) {
    print('Error: $e');
  }
}
```

### **5.1.4 链式调用**
```dart
Future<void> processUserData() async {
  final user = await fetchUser(); // 获取用户
  final posts = await fetchPosts(user.id); // 获取帖子
  await savePosts(posts); // 保存帖子
}
```

---

## **5.2 Stream（数据流）**
### **5.2.1 基本概念**
`Stream` 表示异步数据序列，适合处理连续事件（如实时更新、文件流等）。

### **5.2.2 创建 Stream**
```dart
// 1. 使用 Stream.fromIterable 创建静态流
Stream<int> countStream() => Stream.fromIterable([1, 2, 3]);

// 2. 使用 Stream.periodic 创建定时流
Stream<int> timerStream() => Stream.periodic(Duration(seconds: 1), (i) => i);

// 3. 自定义异步流
Stream<String> fetchDataStream() async* {
  yield 'Start';
  await Future.delayed(Duration(seconds: 1));
  yield 'Data loaded';
}
```

### **2.3 监听 Stream**
```dart
void main() {
  // 单次监听
  countStream().listen((data) {
    print('Received: $data');
  });

  // 持续监听（直到取消）
  final subscription = timerStream().listen((tick) {
    print('Tick: $tick');
    if (tick == 3) subscription.cancel(); // 取消监听
  });
}
```

### **2.4 转换 Stream**
```dart
Stream<int> transformStream(Stream<int> input) async* {
  await for (var value in input) {
    yield value * 2; // 对每个值进行转换
  }
}
```

---

## **5.3 async/await（异步语法糖）**
### **5.3.1 基本用法**
```dart
Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    final data = jsonDecode(response.body);
    print('Data: $data');
  } catch (e) {
    print('Failed to fetch data: $e');
  }
}
```

### **5.3.2 并行执行**
```dart
Future<void> fetchMultiple() async {
  // 方式1：顺序执行
  await fetchData1();
  await fetchData2();

  // 方式2：并行执行（推荐）
  final future1 = fetchData1();
  final future2 = fetchData2();
  await Future.wait([future1, future2]); // 等待所有完成
}
```

### **5.3.3 返回值处理**
```dart
Future<String> getUser() async {
  return 'Alice'; // 等价于 return Future.value('Alice');
}

void main() async {
  String user = await getUser();
  print(user); // 输出: Alice
}
```

---

## **5.4 异常处理**
### **5.4.1 Future 异常**
```dart
Future<void> riskyOperation() async {
  throw Exception('Something went wrong');
}

void main() {
  riskyOperation().catchError((error) {
    print('Caught error: $error');
  });
}
```

### **5.4.2 Stream 异常**
```dart
Stream<int> errorStream() async* {
  yield 1;
  throw Exception('Stream error');
}

void main() {
  errorStream().listen(
    (data) => print(data),
    onError: (error) => print('Stream error: $error'),
  );
}
```

---

## **5.5 高级特性**
### **5.5.1 FutureBuilder（Flutter 中使用）**
```dart
FutureBuilder<String>(
  future: fetchData(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return Text('Data: ${snapshot.data}');
    }
  },
)
```

### **5.5.2 StreamBuilder（Flutter 中使用）**
```dart
StreamBuilder<int>(
  stream: timerStream(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return Text('Waiting...');
    return Text('Tick: ${snapshot.data}');
  },
)
```

### **5.5.3 异步循环**
```dart
Stream<int> countForever() async* {
  int i = 0;
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    yield i++;
  }
}
```

---

## **5.6 最佳实践**
1. **优先使用 async-await**  
   比 `.then()` 链式调用更易读，避免回调地狱。

2. **错误处理**  
   始终用 `try-catch` 包裹异步代码，避免未捕获异常导致崩溃。

3. **取消 Stream 订阅**  
   在 Flutter 中，使用 `StreamSubscription` 的 `cancel()` 避免内存泄漏。

4. **避免阻塞**  
   不要在 `async` 函数中使用同步阻塞操作（如 `Thread.sleep`）。

5. **性能优化**  
   - 对多个独立 Future 使用 `Future.wait` 并行执行
   - 对高频 Stream 使用 `debounce` 或 `throttle`

---

## **5.7 实际应用示例**
### **5.7.1 网络请求封装**
```dart
Future<User> fetchUser(String id) async {
  final response = await http.get(Uri.parse('/users/$id'));
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw HttpException('Failed to load user');
  }
}
```

### **5.7.2 实时数据监听**
```dart
Stream<Position> watchLocation() async* {
  final location = Location();
  await location.serviceEnabled(); // 检查权限
  
  location.onLocationChanged.listen((position) {
    yield position; // 每次位置变化触发
  });
}
```

### **5.7.3 文件操作**
```dart
Future<void> writeFile(String path, String content) async {
  final file = File(path);
  await file.writeAsString(content);
}

Future<String> readFile(String path) async {
  final file = File(path);
  return await file.readAsString();
}
```



---

# **6. 异常处理**

## **6.1 认识"异常处理"**
在Dart编程里，异常处理是非常重要的，它能保障程序的稳定、可靠运行。以下从异常处理的原因、定义、优势、类型、处理机制几方面详细介绍：

### 异常处理的原因
程序在运行过程中，难免会遇到各种意外情况，如文件操作时可能遇到权限问题或文件不存在，网络请求时可能因网络不稳定或服务器错误导致失败，数据库交互时可能出现连接失败或查询错误等。若不进行异常处理，这些意外情况会引发程序崩溃，给用户带来不好的体验，还可能导致数据丢失或程序状态异常。异常处理可以捕获并处理这些意外情况，避免程序因未预料的错误而终止，增强程序的健壮性和可靠性。

### 异常的定义
异常是指程序执行过程中出现的错误或意外情况，它会打断程序的正常流程。在Dart中，异常是一个事件，当程序遇到异常时，后续代码将不会继续执行，除非该异常被捕获并处理。

### 异常处理的优势
- **提高程序稳定性**：通过捕获和处理异常，可防止程序因未预料的错误而崩溃，保证程序在遇到问题时仍能继续运行或优雅地退出。
- **增强错误报告**：能提供详细的错误信息，帮助开发者快速定位和修复问题，提高开发效率。
- **资源管理**：使用`finally`块可确保即使在发生异常的情况下，关键资源（如文件、数据库连接、网络连接等）也能得到适当的释放，避免资源泄漏。
- **错误日志记录**：便于查找程序出错原因，方便后续的调试和维护。

### 异常类型
Dart中的异常主要分为两类：
- **Error**：指程序中发生的严重错误，这类错误通常是不可恢复的，程序会立即终止。例如内存不足引发的错误。
- **Exception**：指程序中可以预见的异常，这类错误是可进行恢复的。例如网络中断导致的异常。

### 异常处理机制
Dart使用`try-catch-finally`结构来实现异常处理：
- **try块**：包含可能会抛出异常的代码。如果`try`块中的代码抛出异常，控制流会立即跳转到相应的`catch`块。
- **catch块**：用于捕获并处理异常。可以指定要捕获的异常类型，若不指定则捕获所有类型的异常。`catch`块可以接收一个参数（通常命名为`e`），该参数是捕获到的异常对象，可在其中记录日志、提示用户、执行回滚操作等。
- **finally块（可选）**：无论是否发生异常，`finally`块中的代码都会执行，常用于释放资源、关闭文件或网络连接等清理操作。

### 示例代码
```dart
void main() {
  try {
    // 可能会抛出异常的代码
    int result = 12 ~/ 0; 
  } catch (e) {
    // 捕获异常并处理
    print('发生了一个错误: $e'); 
  } finally {
    // 无论是否发生异常，这里的代码都会执行
    print('异常处理结束'); 
  }
}
```

在上述代码中，`try`块里的除法操作会抛出除以零的异常，该异常被`catch`块捕获并输出错误信息，最后`finally`块中的代码无论异常是否发生都会执行。

---

## **6.2 实际应用示例**
### **6.2.1 表单验证**
```dart
class FormValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '邮箱不能为空';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '邮箱格式不正确';
    }
    return null; // 无错误
  }
}

// 使用
final error = FormValidator.validateEmail('invalid-email');
if (error != null) {
  showError(error); // 自定义错误处理
}
```

### **6.2.2 数据库操作**
```dart
Future<void> saveUser(User user) async {
  try {
    await db.insert('users', user.toMap());
  } on SqliteException catch (e) {
    if (e.message.contains('UNIQUE constraint failed')) {
      throw UserAlreadyExistsException(user.id);
    }
    rethrow;
  }
}
```

### **6.2.3 API 调用封装**
```dart
Future<T> apiCall<T>(Future<T> Function() operation) async {
  try {
    return await operation();
  } on SocketException {
    throw NetworkException('网络连接失败');
  } on FormatException {
    throw ApiException('数据解析失败');
  } catch (e) {
    throw ApiError('请求失败: ${e.toString()}');
  }
}

// 使用
try {
  final user = await apiCall(() => fetchUser(1));
} on UserAlreadyExistsException {
  // 特定错误处理
} on NetworkException {
  // 网络错误处理
} catch (e) {
  // 其他错误处理
}
```

---

## **6.3 注意事项**
1. **不要捕获所有异常而不处理**  
   ❌ 错误示例：
   ```dart
   try { /* ... */ } catch (e) {} // 隐藏错误！
   ```
   ✅ 正确做法：
   ```dart
   try { /* ... */ } catch (e) {
     logError(e); // 至少记录错误
     rethrow; // 或适当处理
   }
   ```

2. **避免过度捕获**  
   只捕获你能处理的异常，让其他异常向上传播。

3. **异步代码中的异常传播**  
   ```dart
   // 错误：未处理的 Future 异常会导致应用崩溃
   fetchData(); // 未 await 或 .catchError()

   // 正确
   await fetchData().catchError((e) => print(e));
   ```

4. **Flutter 中的错误边界**  
   在 Flutter 中，使用 `runZonedGuarded` 捕获未处理的异常：
   ```dart
   void main() {
     runZonedGuarded(() {
       runApp(MyApp());
     }, (error, stack) {
       reportError(error, stack); // 上报错误
     });
   }
   ```


  

---

# **7. 核心库与工具**
- **标准库**：`dart:core`（基础功能）、`dart:io`（文件/网络）、`dart:async`（异步）。
- **包管理**：通过 `pubspec.yaml` 引入第三方库（如 `http`、`flutter`）。
- **文档工具**：`dartdoc` 生成 API 文档。

---

# **8. 高级特性**

## **8.1 枚举（Enum）**
### **8.1.1 基础用法**
```dart
enum Color { red, green, blue }

void main() {
  Color c = Color.red;
  print(c); // 输出: Color.red
  print(c.index); // 输出: 0（枚举值的索引）
}
```

### **8.1.2 增强型枚举（Dart 2.17+）**
```dart
enum Planet {
  mercury(3.303e+23, 2.4397e6),
  venus(4.869e+24, 6.0518e6),
  earth(5.976e+24, 6.37814e6);

  final double mass; // 质量（千克）
  final double radius; // 半径（米）

  const Planet(this.mass, this.radius);

  // 计算表面重力
  double surfaceGravity() => 
      6.67300E-11 * mass / (radius * radius);
}

void main() {
  print(Planet.earth.surfaceGravity()); // 输出: 9.81962...
}
```

### **8.1.3 枚举实用方法**
```dart
enum Status { pending, processing, completed }

void main() {
  // 获取所有枚举值
  print(Status.values); 
  
  // 通过名称查找
  print(Status.values.firstWhere(
    (e) => e.name == 'completed',
    orElse: () => Status.pending
  ));
  
  // 切换状态
  Status current = Status.pending;
  current = Status.values[(current.index + 1) % Status.values.length];
}
```

---

## **8.2 泛型（Generics）**
### **8.2.1 基础泛型**
```dart
// 泛型类
class Box<T> {
  T content;
  Box(this.content);
}

void main() {
  var intBox = Box(42);
  var strBox = Box('Hello');
  
  print(intBox.content.runtimeType); // 输出: int
  print(strBox.content.runtimeType); // 输出: String
}
```

### **8.2.2 泛型约束**
```dart
// 限制T必须是num或其子类
class NumericBox<T extends num> {
  T value;
  NumericBox(this.value);
  
  T add(T other) => value + other;
}

void main() {
  var box = NumericBox(5);
  print(box.add(3)); // 输出: 8
  
  // var invalid = NumericBox('text'); // 编译错误
}
```

### **8.2.3 泛型方法**
```dart
T firstElement<T>(List<T> list) => list.first;

void main() {
  print(firstElement([1, 2, 3])); // 输出: 1
  print(firstElement(['a', 'b'])); // 输出: a
}
```

### **8.2.4 泛型集合**
```dart
void main() {
  // 明确指定类型
  List<int> numbers = [1, 2, 3];
  
  // 类型推断
  var names = ['Alice', 'Bob']; // 推断为 List<String>
  
  // 原始类型（不推荐）
  var rawList = <dynamic>[1, 'two']; // 可包含任意类型
}
```

---

## **8.3 元数据（Metadata）**
### **8.3.1 内置注解**
```dart
// 标记方法已重写
@override
String toString() => 'Custom toString';

// 标记已弃用
@deprecated
void oldMethod() {}

// 条件编译（仅当dart.library.html存在时生效）
@JS()
external void jsFunction();

// 自定义注解
class ApiEndpoint {
  final String path;
  const ApiEndpoint(this.path);
}

@ApiEndpoint('/users')
class UserService {}
```

### **8.3.2 自定义注解处理**
```dart
// 定义注解
class Todo {
  final String author;
  final DateTime? dueDate;
  
  const Todo(this.author, {this.dueDate});
}

// 使用注解
@Todo('Alice', dueDate: DateTime(2023, 12, 31))
void implementFeature() {
  // 待实现功能
}

// 反射读取注解（需dart:mirrors，生产环境慎用）
// import 'dart:mirrors';
// 
// void checkAnnotations() {
//   var mirror = reflect(implementFeature) as ClosureMirror;
//   var classMirror = mirror.function.owner as ClassMirror;
//   var annotations = classMirror.metadata;
//   print(annotations); // 输出注解信息
// }
```

### **8.3.3 实际应用**
```dart
// API路由注解
class Route {
  final String path;
  const Route(this.path);
}

@Route('/login')
class LoginPage {}

// 自动生成路由表
List<RouteInfo> generateRoutes() {
  // 实际项目中通过代码生成工具实现
  return [];
}
```

---

## **8.4 反射（Reflection）**
### **8.4.1 基础用法（dart:mirrors）**
```dart
import 'dart:mirrors';

class Person {
  String name = 'Alice';
  int age = 30;
}

void main() {
  var p = Person();
  var mirror = reflect(p);
  
  // 获取类信息
  var classMirror = mirror.type;
  print(classMirror.simpleName); // 输出: Person
  
  // 获取字段
  for (var decl in classMirror.declarations.values) {
    if (decl is VariableMirror && !decl.isStatic) {
      var name = MirrorSystem.getName(decl.simpleName);
      var value = mirror.getField(decl.simpleName).reflectee;
      print('$name = $value');
    }
  }
}
```

### **8.4.2 动态调用方法**
```dart
class Calculator {
  int add(int a, int b) => a + b;
}

void main() {
  var calc = Calculator();
  var mirror = reflect(calc);
  
  // 获取方法
  var method = mirror.type.declarations[#add] as MethodMirror;
  
  // 调用方法
  var result = mirror.invoke(
    method.simpleName,
    [10, 20]
  ).reflectee;
  
  print(result); // 输出: 30
}
```

### **8.4.3 注意事项**
1. **性能影响**：反射比直接调用慢10-100倍
2. **AOT限制**：Flutter的AOT编译会移除反射代码
3. **替代方案**：
   ```dart
   // 使用代码生成而非反射
   // 例如：json_serializable、freezed等
   ```

---

## **8.5 最佳实践**
### **8.5.1 枚举使用建议**
- 优先使用增强型枚举（Dart 2.17+）
- 为枚举值添加有意义的计算属性
- 避免在枚举中存储大量数据

### **8.5.2 泛型设计原则**
- 为泛型参数添加有意义的名称（如`<TElement>`而非`<T>`）
- 合理使用泛型约束
- 避免过度复杂的嵌套泛型

### **8.5.3 元数据规范**
- 为自定义注解添加文档注释
- 使用常量构造函数
- 考虑通过代码生成工具处理注解

### **8.5.4 反射替代方案**
| 需求 | 推荐方案 |
|------|----------|
| 序列化/反序列化 | json_serializable |
| 依赖注入 | get_it, provider |
| 路由 | go_router, auto_route |
| ORM | floor, moor |

---

## **8.6 完整示例**
### **8.6.1 泛型+枚举组合**
```dart
enum Status { success, error }

class ApiResponse<T> {
  final T data;
  final Status status;
  final String? message;
  
  ApiResponse.success(this.data) 
      : status = Status.success,
        message = null;
  
  ApiResponse.error(this.message) 
      : status = Status.error,
        data = null as T;
}

void main() {
  var success = ApiResponse.success(42);
  var error = ApiResponse.error('Failed');
  
  if (success.status == Status.success) {
    print('Got data: ${success.data}');
  }
}
```

### **8.6.2 注解驱动开发**
```dart
// 定义验证注解
class Validate {
  final String rule;
  const Validate(this.rule);
}

// 使用注解
class User {
  @Validate(r'^[a-z]+$')
  String username;
  
  User(this.username);
}

// 模拟注解处理器
void validateUser(User user) {
  // 实际项目中通过代码生成实现
  print('Validating user...');
}
```



---

# **9. 最佳实践**
- **空安全**：启用空安全后，变量需显式标记可空（`?`）或非空。
- **代码风格**：遵循 [Dart 代码规范](https://dart.dev/guides/language/effective-dart/style)。
- **测试**：使用 `test` 包编写单元测试。

---
