以下是对 Dart 官方文档核心内容的总结，涵盖基础语法、核心特性及进阶用法，适合快速掌握 Dart 语言的关键知识点：

---

# **1. 基础语法**
## **1.1 Hello World**
```dart
void main() {
  print('Hello, World!');
}
```
- `main()` 是程序入口，无返回值时自动推断为 `void`。
- `print()` 用于输出内容到控制台。

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
```

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
```dart
List<int> numbers = [1, 2, 3];
numbers.add(4);       // 添加元素
numbers[0] = 10;      // 修改元素
print(numbers.length); // 长度
```

#### **1.3.2.2 `Set`**
无序且不重复的集合：
```dart
Set<String> uniqueItems = {'a', 'b', 'c'};
uniqueItems.add('a'); // 无效（重复值）
print(uniqueItems);   // {a, b, c}
```

#### **1.3.2.3 `Map`**
键值对集合，键唯一：
```dart
Map<String, int> scores = {'Alice': 90, 'Bob': 85};
scores['Charlie'] = 95; // 添加键值对
print(scores['Alice']); // 90
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
### **3.1 函数作为参数**
- 将函数作为参数传递：
  ```dart
  void execute(Function operation) {
    operation(5, 3);
  }
  
  execute((a, b) => print(a - b)); // 输出 2
  ```

### **3.2 匿名函数**
- 直接定义未命名的函数：
  ```dart
  var list = [1, 2, 3];
  list.forEach((item) => print(item)); // 输出 1, 2, 3
  ```

### **3.3 闭包（Closure）**
- 函数可捕获外部变量：
  ```dart
  int factor = 2;
  var multiplier = (int x) => x * factor;
  print(multiplier(5)); // 输出 10
  ```

---

## **3.4 函数返回值**
- 显式 `return` 或隐式返回 `null`：
  ```dart
  String? findName(int id) {
    if (id == 1) return 'Alice';
    // 无 return 时默认返回 null
  }
  
  print(findName(2)); // 输出 null
  ```

---

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

# **6. 错误处理**

## **6.1 异常基础**
### **6.1.1 抛出异常**
```dart
throw Exception('Something went wrong'); // 通用异常
throw FormatException('Invalid format'); // 特定类型异常
```

### **6.1.2 异常分类**
Dart 中所有异常均继承自 `Exception` 类，常见内置异常包括：
- `IOException`：输入/输出错误
- `FormatException`：数据格式错误
- `StateError`：对象状态不合法
- `TypeError`：类型不匹配

---

## **6.2 捕获异常**
### **6.2.1 基础捕获**
```dart
try {
  int result = 10 ~/ 0; // 触发 StateError
} catch (e) {
  print('Caught error: $e'); // 输出: Caught error: DivideByZeroError
}
```

### **6.2.2 类型化捕获**
```dart
try {
  var data = jsonDecode('invalid json');
} on FormatException catch (e) {
  print('JSON 解析错误: $e'); // 仅捕获 FormatException
} catch (e) {
  print('其他错误: $e'); // 捕获其他所有异常
}
```

### **6.2.3 捕获多个异常**
```dart
try {
  // 可能抛出多种异常的代码
} on IOException catch (e) {
  print('IO 错误: $e');
} on FormatException catch (e) {
  print('格式错误: $e');
} catch (e) {
  print('未知错误: $e');
}
```

### **6.2.4 `finally` 块**
```dart
StreamSubscription? subscription;
try {
  subscription = stream.listen((data) {});
} catch (e) {
  print('订阅失败: $e');
} finally {
  if (subscription != null) {
    subscription.cancel(); // 确保资源释放
  }
}
```

---

## **6.3 异常传播**
### **6.3.1 重新抛出异常**
```dart
void processData() {
  try {
    riskyOperation();
  } catch (e) {
    logError(e);
    rethrow; // 重新抛出当前异常
  }
}
```

### **6.3.2 抛出新异常**
```dart
void validateInput(String input) {
  if (input.isEmpty) {
    throw ArgumentError('输入不能为空'); // 抛出新异常
  }
}
```

---

## **6.4 自定义异常**
### **6.4.1 定义自定义异常类**
```dart
class PaymentFailedException implements Exception {
  final String message;
  PaymentFailedException(this.message);
  
  @override
  String toString() => 'PaymentFailedException: $message';
}

// 使用
throw PaymentFailedException('余额不足');
```

### **6.4.2 捕获自定义异常**
```dart
try {
  processPayment();
} on PaymentFailedException catch (e) {
  print('支付失败: ${e.message}');
}
```

---

## **6.5 异常处理最佳实践**
### **6.5.1 避免空捕获块**
❌ 错误示例：
```dart
try { /* ... */ } catch (e) {} // 隐藏错误！
```

✅ 正确做法：
```dart
try { /* ... */ } catch (e) {
  logError(e); // 至少记录错误
}
```

### **6.5.2 区分检查型和非检查型异常**
- **检查型异常**（Dart 中不存在，但可通过约定实现）：
  ```dart
  // 通过文档说明调用方必须处理的异常
  /// 可能抛出 [PaymentFailedException]
  Future<void> pay() async {
    if (balance < amount) {
      throw PaymentFailedException('余额不足');
    }
  }
  ```

- **非检查型异常**（运行时异常）：
  ```dart
  // 不强制要求捕获的异常
  int divide(int a, int b) {
    if (b == 0) throw StateError('除数不能为零');
    return a ~/ b;
  }
  ```

### **6.5.3 资源管理**
```dart
// 使用 try-finally 确保资源释放
var file = File('data.txt');
try {
  var contents = file.readAsStringSync();
  // 处理文件内容
} finally {
  file.closeSync(); // 确保关闭文件
}
```

### **6.5.4 异步代码中的异常**
```dart
Future<void> fetchData() async {
  try {
    var response = await http.get(Uri.parse('https://api.example.com'));
    response.bodyBytes; // 可能抛出异常
  } on SocketException catch (e) {
    print('网络连接失败: $e');
  } catch (e) {
    print('请求失败: $e');
  }
}
```

---

## **6.6 实际应用示例**
### **6.6.1 表单验证**
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

### **6.6.2 数据库操作**
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

### **6.6.3 API 调用封装**
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

## **6.7 注意事项**
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
