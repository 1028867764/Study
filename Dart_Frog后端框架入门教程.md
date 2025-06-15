

# 1. Dart Frog 简介

## 1.1 Dart Frog 是什么

Dart Frog 是一个用 Dart 语言编写的现代后端框架，专注于构建快速、可扩展的 HTTP API 服务。它设计简洁，支持灵活的路由和中间件，适合构建 RESTful API 和微服务。

特点：
- 使用 Dart 语言，天生支持异步和并发
- 简单且直观的路由文件结构
- 可组合的中间件系统
- 与 Flutter 生态紧密结合，便于全栈 Dart 开发

## 1.2 适用场景

- 构建 RESTful API 服务
- 微服务架构的服务端组件
- 与 Flutter 前端配合，实现全栈 Dart 应用
- 需要快速开发且性能良好的后端应用

## 1.3 与其他后端框架对比（如 Express, FastAPI）

| 特性       | Dart Frog                | Express (Node.js)           | FastAPI (Python)           |
|------------|-------------------------|-----------------------------|----------------------------|
| 语言       | Dart                    | JavaScript                  | Python                     |
| 性能       | 高（Dart VM性能优势）   | 较高                        | 非常高（基于 Starlette）   |
| 开发体验   | 强类型，良好IDE支持    | 动态类型，生态丰富          | 类型提示，自动生成文档     |
| 与Flutter整合 | 无缝衔接                | 需要额外配置                | 需要额外配置               |
| 学习曲线   | 适中                    | 低                          | 适中                       |

## 1.4 架构特点

- 基于文件路由，路由即文件
- 通过中间件链进行请求处理
- 支持异步请求处理，非阻塞 IO
- 请求和响应模型简单易用
- 轻量且模块化设计，易于扩展

## 1.5 生态和社区状况

- 由 Very Good Ventures 维护
- 社区相对较小，但增长快速
- 与 Flutter 和 Dart 社区紧密相关
- 官方文档活跃，GitHub仓库持续更新
- 提供多种示例项目和中间件扩展

---

### 简单示例：创建一个基础的 Dart Frog 路由

```dart
// routes/index.dart

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response.json(body: {'message': 'Hello from Dart Frog!'});
}
```

运行后访问 `/` 路径，将返回 JSON 响应：

```json
{
  "message": "Hello from Dart Frog!"
}
```


# 2. 环境准备

## 2.1 安装 Dart SDK

Dart SDK 是运行和开发 Dart 应用的基础。你可以从官网下载并安装：

- 官网地址：https://dart.dev/get-dart
- 支持 Windows、macOS、Linux 平台

安装完成后，打开终端，执行以下命令验证安装：

```bash
dart --version
````

如果输出 Dart 版本信息，说明安装成功。

---

## 2.2 Dart Frog CLI 安装与使用

Dart Frog 提供命令行工具方便项目创建和管理。

### 安装 Dart Frog CLI

```bash
dart pub global activate dart_frog_cli
```

确保 Dart 的全局包路径已加入系统 PATH：

* Linux/macOS 通常是 `~/.pub-cache/bin`
* Windows 需要手动添加环境变量

### 查看 Dart Frog CLI 版本

```bash
dart_frog --version
```

---

## 2.3 创建第一个 Dart Frog 项目

使用 Dart Frog CLI 快速创建新项目：

```bash
dart_frog create my_dart_frog_app
cd my_dart_frog_app
```

该命令会生成一个基础的项目结构，包括 `routes` 目录和示例代码。

---

## 2.4 运行开发服务器

进入项目目录，启动开发服务器：

```bash
dart_frog dev
```

你会看到类似的输出：

```
Starting Dart Frog server on http://localhost:8080
```

打开浏览器访问 [http://localhost:8080](http://localhost:8080) ，默认会看到示例返回的响应。

---

### 示例项目结构

```
my_dart_frog_app/
├── routes/
│   └── index.dart      # 主页路由处理
├── pubspec.yaml        # 项目配置文件
└── ...
```

### 示例代码 - 路由响应

`routes/index.dart`：

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response.json(body: {'message': 'Welcome to Dart Frog!'});
}
```

访问 [http://localhost:8080](http://localhost:8080) 会返回：

```json
{
  "message": "Welcome to Dart Frog!"
}
```



复制以上内容即可开始你的 Dart Frog 环境准备和第一个项目开发。

---

# 3. Dart Frog 项目结构

## 3.1 `routes/` 目录说明

`routes/` 目录是 Dart Frog 项目的核心目录，用于定义应用的路由。  
每个文件或文件夹对应一个路由路径。例如：  
- `routes/index.dart` 对应根路径 `/`  
- `routes/users.dart` 对应 `/users` 路径  
- `routes/users/[id].dart` 对应动态路径 `/users/:id`

路由支持文件夹嵌套，支持动态参数和通配符。

## 3.2 主要文件介绍

### main.dart

`main.dart` 是 Dart Frog 应用的入口文件。  
它负责启动服务器并加载路由和中间件。

示例：

```dart
import 'package:dart_frog/dart_frog.dart';

void main() async {
  final app = Router();

  // 绑定路由
  app.get('/', (context) => Response(body: 'Hello, Dart Frog!'));

  // 启动服务器，监听 8080 端口
  await serve(app, 'localhost', 8080);
  print('Server running on http://localhost:8080');
}
```

### routes/

存放所有路由处理文件。每个路由文件导出一个 `Handler`，例如：

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(body: 'Hello from /users');
}
```

### middleware/

用于定义中间件逻辑，支持请求拦截、身份验证、日志记录等。

示例中间件 `middleware/logger.dart`：

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    print('Request: ${context.request.method} ${context.request.uri}');
    final response = await handler(context);
    print('Response status: ${response.statusCode}');
    return response;
  };
}
```

## 3.3 请求处理流程概览

1. 客户端发起 HTTP 请求。
2. 请求经过中间件链，进行预处理（如日志、身份验证）。
3. 路由系统匹配对应的路由处理器（`routes/` 中的文件）。
4. 路由处理器读取请求参数、处理业务逻辑。
5. 返回一个 `Response` 对象，发送给客户端。
6. 中间件可对响应进行后处理（如添加响应头）。
7. 响应完成，连接关闭或保持。

流程图示意：

```
Client → Middleware → Router → Handler → Response → Middleware → Client
```

## 3.4 请求与响应模型（Request 和 Response）

Dart Frog 提供了封装良好的 `Request` 和 `Response` 类来操作 HTTP 请求和响应。

### Request 示例

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final request = context.request;

  // 获取请求方法
  final method = request.method; // GET, POST 等

  // 读取请求路径参数（如果有）
  final id = context.request.uri.queryParameters['id'];

  // 读取请求体（异步）
  // final body = await request.body();

  return Response(body: 'Request method: $method, id: $id');
}
```

### Response 示例

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    statusCode: 200,
    headers: {'content-type': 'application/json'},
    body: '{"message": "Hello, Dart Frog!"}',
  );
}
```

### 完整的示例路由处理器

```dart
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.get) {
    final name = context.request.uri.queryParameters['name'] ?? 'world';
    return Response(body: 'Hello, $name!');
  } else if (context.request.method == HttpMethod.post) {
    final body = await context.request.body();
    return Response(body: 'Received POST with body: $body');
  }
  return Response(statusCode: 405, body: 'Method Not Allowed');
}
```



# 4. 路由管理

## 4.1 路由文件与路径映射规则

Dart Frog 使用 `routes/` 目录结构自动映射路由路径，遵循以下规则：

- `routes/index.dart` 映射为根路径 `/`  
- `routes/users.dart` 映射为 `/users`  
- `routes/users/[id].dart` 映射为动态路径 `/users/:id`  
- 文件夹内的 `index.dart` 文件映射为对应文件夹路径，例如 `routes/admin/index.dart` 对应 `/admin`  
- 多级目录支持，例如 `routes/api/v1/products.dart` 对应 `/api/v1/products`

示例：

```

routes/
├── index.dart           // 路由：/
├── users.dart           // 路由：/users
├── users/
│   └── \[id].dart        // 路由：/users/\:id
├── admin/
│   └── index.dart       // 路由：/admin

```

## 4.2 动态路由参数处理

动态路由通过文件名中的方括号定义，例如 `[id].dart`。  
请求时，Dart Frog 会自动解析路径参数，可通过 `context.request.uri.pathSegments` 或 `context.request.uri.queryParameters` 访问。

示例：`routes/users/[id].dart`

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  // 获取动态路径参数 id
  final segments = context.request.uri.pathSegments;
  // 例如 /users/42 ，id 即为 "42"
  final id = segments.isNotEmpty ? segments.last : 'unknown';

  return Response(body: 'User id: $id');
}
````

更优雅的方式是使用 `context.request.uri.pathSegments`，你也可以封装工具函数专门解析。

## 4.3 嵌套路由与子路由

通过在 `routes/` 目录下使用文件夹嵌套实现嵌套路由。

例如，创建 `routes/api/v1/users.dart`，对应路径 `/api/v1/users`。
嵌套路由允许你根据 API 版本或模块进行分组管理。

示例目录结构：

```
routes/
└── api/
    └── v1/
        ├── users.dart         // 路由：/api/v1/users
        └── users/
            └── [id].dart      // 路由：/api/v1/users/:id
```

`routes/api/v1/users/[id].dart` 示例：

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final id = context.request.uri.pathSegments.last;
  return Response(body: 'API v1 user id: $id');
}
```

## 4.4 RESTful 路由设计

在 Dart Frog 中，可以按照 RESTful 风格设计路由和请求方法：

| HTTP 方法   | 路径           | 功能描述     |
| --------- | ------------ | -------- |
| GET       | `/users`     | 获取用户列表   |
| POST      | `/users`     | 创建新用户    |
| GET       | `/users/:id` | 获取指定用户详情 |
| PUT/PATCH | `/users/:id` | 更新指定用户信息 |
| DELETE    | `/users/:id` | 删除指定用户   |

示例代码：

```dart
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  final segments = context.request.uri.pathSegments;

  // /users 路由
  if (segments.length == 1 && segments[0] == 'users') {
    if (method == HttpMethod.get) {
      // 返回用户列表
      return Response(body: '返回用户列表');
    } else if (method == HttpMethod.post) {
      final body = await context.request.body();
      // 处理创建用户
      return Response(body: '创建用户，接收数据: $body');
    }
  }

  // /users/:id 路由
  if (segments.length == 2 && segments[0] == 'users') {
    final id = segments[1];
    if (method == HttpMethod.get) {
      return Response(body: '获取用户 $id 的详情');
    } else if (method == HttpMethod.put || method == HttpMethod.patch) {
      final body = await context.request.body();
      return Response(body: '更新用户 $id，数据: $body');
    } else if (method == HttpMethod.delete) {
      return Response(body: '删除用户 $id');
    }
  }

  return Response(statusCode: 404, body: 'Not Found');
}
```



# 5. 请求处理

## 5.1 HTTP 请求方法（GET, POST, PUT, DELETE 等）

Dart Frog 支持常见的 HTTP 方法，可以根据请求的方法类型编写对应处理逻辑。  
使用 `context.request.method` 获取请求方法，类型为 `HttpMethod`。

示例：

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  switch (context.request.method) {
    case HttpMethod.get:
      return Response(body: '处理 GET 请求');
    case HttpMethod.post:
      return Response(body: '处理 POST 请求');
    case HttpMethod.put:
      return Response(body: '处理 PUT 请求');
    case HttpMethod.delete:
      return Response(body: '处理 DELETE 请求');
    default:
      return Response(statusCode: 405, body: '方法不被允许');
  }
}
```

---

## 5.2 读取请求参数（路径参数、查询参数、请求体）

### 路径参数

路径参数通常通过动态路由文件名定义，如 `[id].dart`，可通过 `context.request.uri.pathSegments` 访问。

```dart
final segments = context.request.uri.pathSegments;
final id = segments.isNotEmpty ? segments.last : null;
```

### 查询参数

通过 `context.request.uri.queryParameters` 获取 URL 中 `?key=value` 格式的参数。

```dart
final page = context.request.uri.queryParameters['page'] ?? '1';
```

### 请求体

请求体内容需要异步读取，通常是字符串格式：

```dart
final body = await context.request.body();
```

示例：

```dart
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final query = context.request.uri.queryParameters['q'] ?? '';
  final body = await context.request.body();

  return Response(body: '查询参数 q=$query\n请求体: $body');
}
```

---

## 5.3 处理不同请求内容类型（JSON, form-data 等）

### 处理 JSON 请求体

通常请求头 `Content-Type` 为 `application/json`，需解析 JSON 字符串。

示例：

```dart
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.headers['content-type']?.contains('application/json') ?? false) {
    final jsonString = await context.request.body();
    final data = jsonDecode(jsonString);
    final name = data['name'] ?? '匿名';

    return Response(body: 'Hello, $name!');
  }
  return Response(statusCode: 400, body: 'Unsupported Content-Type');
}
```

### 处理 form-data

目前 Dart Frog 默认对 `application/x-www-form-urlencoded` 可以直接用 `queryParameters` 处理，复杂 multipart/form-data 需要额外库支持，或手动解析。

简单处理 `x-www-form-urlencoded` 示例：

```dart
Future<Response> onRequest(RequestContext context) async {
  if (context.request.headers['content-type']?.contains('application/x-www-form-urlencoded') ?? false) {
    final body = await context.request.body();
    final params = Uri.splitQueryString(body);
    final username = params['username'] ?? '未知用户';

    return Response(body: '用户名: $username');
  }
  return Response(statusCode: 400, body: 'Unsupported Content-Type');
}
```

---

## 5.4 请求验证和错误处理

### 请求验证

可以在路由处理函数内手动验证参数合法性，若不符合要求则返回错误响应。

示例：

```dart
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final id = context.request.uri.pathSegments.isNotEmpty ? context.request.uri.pathSegments.last : null;

  if (id == null || int.tryParse(id) == null) {
    return Response(statusCode: 400, body: '无效的 ID 参数');
  }

  // 业务处理...
  return Response(body: '有效的 ID: $id');
}
```

### 错误处理

* 返回对应 HTTP 状态码（如 400、404、500 等）
* 自定义错误信息
* 结合中间件实现统一错误捕获和处理

示例返回 404：

```dart
return Response(statusCode: 404, body: '资源未找到');
```

示例统一错误处理中间件：

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    try {
      return await handler(context);
    } catch (e, stackTrace) {
      // 记录日志
      print('捕获异常: $e\n$stackTrace');
      return Response(statusCode: 500, body: '服务器内部错误');
    }
  };
}
```



# 6. 响应处理

## 6.1 构造响应对象

Dart Frog 使用 `Response` 类来构造 HTTP 响应。  
一个基本的响应对象包含状态码、响应头和响应体。

示例：

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    statusCode: 200,
    body: 'Hello, Dart Frog!',
  );
}
```

## 6.2 返回 JSON、文本、文件等

### 返回 JSON

需要设置 `content-type` 为 `application/json`，并将数据编码为 JSON 字符串。

```dart
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final data = {'message': 'Hello, JSON', 'success': true};
  return Response.json(body: data);
}
```

或者手动构造：

```dart
final jsonString = jsonEncode(data);
return Response(
  headers: {'content-type': 'application/json'},
  body: jsonString,
);
```

### 返回纯文本

默认 `content-type` 为 `text/plain`。

```dart
return Response(body: '这是纯文本响应');
```

### 返回文件

可通过读取文件并返回字节流实现文件响应。

示例返回静态文件：

```dart
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final file = File('path/to/file.png');
  if (!await file.exists()) {
    return Response(statusCode: 404, body: '文件不存在');
  }
  final bytes = await file.readAsBytes();
  return Response(
    headers: {'content-type': 'image/png'},
    body: bytes,
  );
}
```

---

## 6.3 响应状态码和头部设置

可以自定义响应状态码和添加/修改响应头。

示例设置状态码为 201 并添加自定义头：

```dart
return Response(
  statusCode: 201,
  headers: {
    'content-type': 'text/plain',
    'x-custom-header': 'my-header-value',
  },
  body: '资源已创建',
);
```

---

## 6.4 流式响应

流式响应适用于大文件或实时数据传输，避免一次性加载全部内容到内存。

示例：使用 `Stream<List<int>>` 发送文件流

```dart
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final file = File('path/to/large_file.mp4');
  if (!await file.exists()) {
    return Response(statusCode: 404, body: '文件不存在');
  }
  final stream = file.openRead();

  return Response(
    headers: {
      'content-type': 'video/mp4',
      'content-length': (await file.length()).toString(),
    },
    body: stream,
  );
}
```

流式响应的 `body` 支持 `Stream<List<int>>` 类型，可节省内存并提高性能。

---


# 7. 中间件（Middleware）

## 7.1 中间件概念与作用

中间件（Middleware）是 Dart Frog 中用于**处理请求链前后的钩子函数**。  
它的主要作用包括：

- 请求预处理（如认证、日志记录、请求转换等）
- 响应后处理（如响应修改、统一错误处理等）
- 拦截非法请求
- 链式组合，提高代码复用性

中间件可以定义在整个项目、特定目录或路由级别上。

---

## 7.2 编写和使用中间件

中间件的函数签名为：

```dart
Handler middleware(Handler handler) {
  return (RequestContext context) async {
    // 请求前处理
    final response = await handler(context);
    // 响应后处理
    return response;
  };
}
```

### 添加全局中间件（在项目根目录的 `middleware.dart`）

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    print('收到请求: ${context.request.method} ${context.request.uri}');
    final response = await handler(context);
    print('响应状态: ${response.statusCode}');
    return response;
  };
}
```

---

## 7.3 常见中间件示例

### 日志记录中间件

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final start = DateTime.now();
    final response = await handler(context);
    final duration = DateTime.now().difference(start);
    print('[${DateTime.now()}] ${context.request.method} ${context.request.uri} -> ${response.statusCode} (${duration.inMilliseconds}ms)');
    return response;
  };
}
```

### 简单身份认证中间件（基于 Header）

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final auth = context.request.headers['authorization'];
    if (auth != 'Bearer my-secret-token') {
      return Response(statusCode: 401, body: 'Unauthorized');
    }
    return handler(context);
  };
}
```

### 跨域 CORS 中间件

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final response = await handler(context);
    return response.copyWith(headers: {
      ...response.headers,
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': '*',
    });
  };
}
```

---

## 7.4 中间件链管理

Dart Frog 支持按目录或文件使用中间件，并自动**向上继承父目录的中间件链**。

### 示例目录结构：

```
routes/
├── middleware.dart           // 全局中间件
├── admin/
│   ├── middleware.dart       // 只影响 admin 下的路由
│   └── dashboard.dart
```

中间件应用顺序如下：

```
global.middleware → admin.middleware → routes/admin/dashboard.dart
```

### 路由专属中间件（指定 handler）

你也可以在单个路由文件中引入中间件：

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    print('这是某个特定路由的中间件');
    return handler(context);
  };
}
```

---

如果你希望中间件有“提前终止请求”功能，直接 `return Response(...)` 即可跳过后续逻辑。
中间件的强大之处在于它是组合型、可重复使用的函数式组件，适合用于日志、安全、请求追踪等场景。

---




# 8. 状态管理与依赖注入

Dart Frog 并不像 Flutter 那样有完整的状态管理框架，但它提供了一个简洁的方式通过 `RequestContext` 传递和共享状态、依赖和服务对象。  
这种模式称为**依赖注入（Dependency Injection）**，也可以用于**管理全局状态或资源**。

---

## 8.1 全局状态存储

可以使用 `context.read<T>()` 和 `context.provide<T>(() => value)` 在中间件中注入全局或局部状态：

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) {
    final counter = 0; // 示例状态
    final scoped = context.provide<int>(() => counter);
    return handler(scoped);
  };
}

Response onRequest(RequestContext context) {
  final count = context.read<int>();
  return Response(body: '当前计数：$count');
}
```

此方式适合向下传递状态，例如：认证信息、用户 ID、语言偏好等。

---

## 8.2 依赖注入模式

依赖注入的核心是通过中间件将服务注册进 `RequestContext`，再在后续路由中使用 `context.read<YourService>()` 获取。

### 示例：注入一个简单服务类

```dart
class Logger {
  void log(String message) {
    print('[LOG] $message');
  }
}
```

**中间件注入 Logger：**

```dart
Handler middleware(Handler handler) {
  return (context) {
    final logger = Logger();
    final scoped = context.provide<Logger>(() => logger);
    return handler(scoped);
  };
}
```

**在路由中使用：**

```dart
Response onRequest(RequestContext context) {
  final logger = context.read<Logger>();
  logger.log('请求已处理');
  return Response(body: 'Logger 已记录信息');
}
```

---

## 8.3 共享资源管理（数据库连接、缓存等）

当你需要管理数据库、Redis、缓存连接等资源时，通常需要全局初始化 + 注入使用。

### 示例：共享数据库连接（伪代码）

```dart
class Database {
  Future<void> connect() async => print('连接数据库...');
  Future<String> queryUser() async => '用户张三';
}
```

**在主中间件中初始化并注入：**

```dart
final db = Database()..connect();

Handler middleware(Handler handler) {
  return (context) {
    final scoped = context.provide<Database>(() => db);
    return handler(scoped);
  };
}
```

**在路由中使用：**

```dart
Future<Response> onRequest(RequestContext context) async {
  final db = context.read<Database>();
  final user = await db.queryUser();
  return Response(body: '当前用户: $user');
}
```

这种方式可以保证资源只初始化一次，并在请求周期中安全使用。

---

✅ **总结：**

* 使用 `context.provide<T>(() => value)` 注入依赖
* 使用 `context.read<T>()` 获取依赖
* 依赖注入建议统一管理在中间件中
* 支持任何类型：服务类、状态对象、数据库连接等
* 避免在路由中直接 new 对象，有利于解耦和测试

---

如你希望实现更复杂的资源生命周期管理（如连接池、懒加载、缓存失效等），也可以进一步扩展服务类或封装服务容器。




# 9. 数据库集成

Dart Frog 可搭配 Dart 社区常用的数据库客户端进行数据存储与操作。以下为数据库集成的实用指南。

---

## 9.1 常用 Dart 数据库包

| 数据库类型 | 推荐包               | Pub 链接                                  |
|------------|----------------------|-------------------------------------------|
| PostgreSQL | `postgres`           | https://pub.dev/packages/postgres         |
| MySQL      | `mysql1`             | https://pub.dev/packages/mysql1           |
| MongoDB    | `mongo_dart`         | https://pub.dev/packages/mongo_dart       |
| SQLite     | `sqlite3`, `drift`   | https://pub.dev/packages/sqlite3 / drift  |

---

## 9.2 连接数据库（以 `postgres` 为例）

首先添加依赖：

```yaml
# pubspec.yaml
dependencies:
  postgres: ^2.5.5
```

建立数据库连接并注入：

```dart
import 'package:postgres/postgres.dart';
import 'package:dart_frog/dart_frog.dart';

final db = PostgreSQLConnection(
  'localhost', // 主机
  5432,        // 端口
  'your_db',   // 数据库名
  username: 'user',
  password: 'pass',
);

Handler middleware(Handler handler) {
  return (context) async {
    if (db.isClosed) await db.open();
    final scoped = context.provide<PostgreSQLConnection>(() => db);
    return handler(scoped);
  };
}
```

---

## 9.3 基础 CRUD 操作示例

### 创建数据（Create）

```dart
Future<Response> onRequest(RequestContext context) async {
  final db = context.read<PostgreSQLConnection>();
  await db.query(
    'INSERT INTO users(name, email) VALUES (@name, @email)',
    substitutionValues: {
      'name': 'Alice',
      'email': 'alice@example.com',
    },
  );
  return Response.json(body: {'message': 'User created'});
}
```

### 读取数据（Read）

```dart
Future<Response> onRequest(RequestContext context) async {
  final db = context.read<PostgreSQLConnection>();
  final result = await db.query('SELECT * FROM users');
  final users = result.map((row) => {
    'id': row[0],
    'name': row[1],
    'email': row[2],
  }).toList();
  return Response.json(body: users);
}
```

### 更新数据（Update）

```dart
await db.query(
  'UPDATE users SET email = @email WHERE name = @name',
  substitutionValues: {
    'name': 'Alice',
    'email': 'alice_new@example.com',
  },
);
```

### 删除数据（Delete）

```dart
await db.query(
  'DELETE FROM users WHERE name = @name',
  substitutionValues: {'name': 'Alice'},
);
```

---

## 9.4 ORM 方案介绍（如 Drift）

如果你希望使用 ORM 方式操作 SQLite 数据库，`Drift` 是 Dart 中最成熟的选择：

### Drift 特点：

* 强类型 SQL DSL
* 自动生成模型类
* 支持异步和事务
* 推荐用于客户端或轻量后端（SQLite）

### 使用 Drift 示例（略）

添加依赖：

```yaml
dependencies:
  drift: ^2.15.0
  sqlite3: ^2.1.0
  path: ^1.8.3
  path_provider: ^2.1.2

dev_dependencies:
  drift_dev: ^2.15.0
  build_runner: ^2.4.6
```

使用 Drift 的例子较长，建议参考官方文档：[https://drift.simonbinder.eu/](https://drift.simonbinder.eu/)

⚠️ 注意：Drift 适合 SQLite，不支持 PostgreSQL/MySQL 等服务器数据库。

---

## 9.5 事务处理与错误管理

### 使用事务：

```dart
await db.transaction((ctx) async {
  await ctx.query('INSERT INTO logs (event) VALUES (@e)', substitutionValues: {
    'e': 'start',
  });

  await ctx.query('UPDATE users SET balance = balance - 10 WHERE id = @id', substitutionValues: {
    'id': 123,
  });
});
```

如事务中任何一项失败，整体会自动回滚。

### 错误处理：

```dart
try {
  await db.query('...');
} catch (e, stackTrace) {
  print('数据库错误: $e');
  return Response(statusCode: 500, body: 'Internal Server Error');
}
```

---

✅ **总结建议：**

* 使用 `postgres` / `mysql1` 等直接连接数据库
* 使用中间件注入数据库连接，避免重复打开
* 推荐通过 `substitutionValues` 防止 SQL 注入
* 对复杂逻辑使用事务，保障一致性
* 对每个数据库操作进行异常捕获，返回清晰响应

---



# 10. 异步编程与并发

Dart 是一个原生支持异步和并发的语言，Dart Frog 作为服务端框架，天然支持高并发处理请求。  
本章将介绍 Dart 的异步编程模型、在 Dart Frog 中的实战应用，以及高性能并发处理技巧。

---

## 10.1 Dart 异步机制简述

Dart 中主要通过 `Future` 和 `Stream` 实现异步操作：

- `Future<T>`：表示一个将来可用的值，用于处理单次异步操作（如网络请求、数据库查询）
- `Stream<T>`：表示一组异步事件序列，用于处理连续数据流（如日志流、订阅等）

### 示例：Future

```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 1));
  return '数据加载完成';
}
```

### 示例：Stream

```dart
Stream<int> countStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}
```

---

## 10.2 Future 和 Stream 在 Dart Frog 中的使用

Dart Frog 的路由函数天然支持 `async`，你可以直接返回 `Future<Response>`。

### 使用 Future：

```dart
Future<Response> onRequest(RequestContext context) async {
  final data = await fetchData(); // 异步获取数据
  return Response.json(body: {'message': data});
}
```

### 使用 Stream（用于流式响应）：

```dart
Response onRequest(RequestContext context) {
  final stream = Stream.periodic(
    Duration(seconds: 1),
    (count) => '数据：${count + 1}\n',
  ).take(5);

  return Response.body(
    stream,
    headers: {'Content-Type': 'text/plain'},
  );
}
```

---

## 10.3 并发请求处理与性能优化

Dart Frog 默认是单线程的，但事件循环机制支持**并发处理多个请求**。你可以通过以下方式提高性能：

### ✅ 避免阻塞操作（如同步文件读写）

使用 `await` 调用异步 API，避免阻塞主线程：

```dart
// 🚫 错误（阻塞）
final content = File('big.txt').readAsStringSync();

// ✅ 正确（非阻塞）
final content = await File('big.txt').readAsString();
```

### ✅ 使用 `Future.wait` 并行执行多个异步操作

```dart
Future<Response> onRequest(RequestContext context) async {
  final results = await Future.wait([
    fetchUserProfile(),
    fetchUserOrders(),
    fetchUserSettings(),
  ]);

  return Response.json(body: {
    'profile': results[0],
    'orders': results[1],
    'settings': results[2],
  });
}
```

### ✅ 使用缓存提升访问性能（如内存、Redis）

将频繁访问的数据放入缓存，避免重复查询数据库：

```dart
final cache = <String, String>{};

Future<String> getData(String key) async {
  if (cache.containsKey(key)) return cache[key]!;
  final value = await fetchFromDatabase(key);
  cache[key] = value;
  return value;
}
```

### ✅ 使用 Isolate 进行 CPU 密集型任务

Dart 支持使用 `Isolate` 运行多线程，但 Dart Frog 不建议频繁使用。
推荐将耗时操作（如图像处理、加密）移出主线程：

```dart
Future<T> computeInIsolate<T, P>(T Function(P) fn, P param) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(_isolateEntry, [fn, param, receivePort.sendPort]);
  return await receivePort.first as T;
}

void _isolateEntry(List<dynamic> args) {
  final fn = args[0] as Function;
  final param = args[1];
  final sendPort = args[2] as SendPort;
  final result = fn(param);
  sendPort.send(result);
}
```

---

✅ **总结建议：**

* 使用 `async`/`await` 编写非阻塞代码
* 合理使用 `Future.wait` 批量并发任务
* Stream 适用于推送、日志流等场景
* 利用缓存/队列等机制减少数据库压力
* 尽量避免同步代码和阻塞操作
* 对重任务考虑使用 `Isolate` 或外部服务



Dart Frog 的事件驱动模型适合构建高并发 Web API，若配合数据库连接池、缓存、流响应等机制，可以实现极高的吞吐量。

---


# 11. 安全

在 Web 开发中，安全是重中之重。Dart Frog 提供灵活的中间件机制，便于我们在身份验证、输入校验、传输安全等方面实现高标准的安全策略。

---

## 11.1 身份认证和授权（JWT、OAuth 等）

### 使用 JWT 进行身份认证

#### 添加依赖：

```yaml
dependencies:
  dart_jsonwebtoken: ^2.7.1
```

#### 创建 Token：

```dart
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

String generateToken(String userId) {
  final jwt = JWT(
    {'userId': userId},
    issuer: 'your-api',
  );
  return jwt.sign(SecretKey('your-secret-key'), expiresIn: Duration(hours: 1));
}
```

#### 验证 Token（中间件实现）：

```dart
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final authHeader = context.request.headers['Authorization'];
    if (authHeader == null || !authHeader.startsWith('Bearer ')) {
      return Response(statusCode: 401, body: 'Unauthorized');
    }

    final token = authHeader.substring(7);
    try {
      final jwt = JWT.verify(token, SecretKey('your-secret-key'));
      final contextWithUser = context.provide(() => jwt.payload['userId']);
      return handler(contextWithUser);
    } catch (e) {
      return Response(statusCode: 403, body: 'Invalid Token');
    }
  };
}
```

> 可使用 `context.read<String>()` 获取当前用户 ID。

---

## 11.2 输入验证与防止注入攻击

### 基本输入验证：

```dart
Future<Response> onRequest(RequestContext context) async {
  final body = await context.request.json() as Map;
  final email = body['email'] as String?;
  final password = body['password'] as String?;

  if (email == null || !email.contains('@')) {
    return Response.json(statusCode: 400, body: {'error': 'Invalid email'});
  }

  if (password == null || password.length < 6) {
    return Response.json(statusCode: 400, body: {'error': 'Password too short'});
  }

  return Response.json(body: {'message': 'Valid input'});
}
```

### 防止 SQL 注入：

**永远使用参数化查询！不要字符串拼接 SQL！**

```dart
await db.query(
  'SELECT * FROM users WHERE email = @email',
  substitutionValues: {'email': userInput},
);
```

---

## 11.3 HTTPS 配置与安全最佳实践

### 本地开发使用 HTTPS（Dart CLI）：

```bash
dart run bin/server.dart --cert cert.pem --key key.pem
```

或者直接使用 `dart_frog dev` 结合代理（推荐在生产使用 nginx）。

### 生产环境推荐使用 NGINX + HTTPS：

#### NGINX 示例配置：

```nginx
server {
  listen 443 ssl;
  server_name yourdomain.com;

  ssl_certificate     /etc/ssl/certs/fullchain.pem;
  ssl_certificate_key /etc/ssl/private/privkey.pem;

  location / {
    proxy_pass         http://127.0.0.1:8080;
    proxy_http_version 1.1;
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection 'upgrade';
    proxy_set_header   Host $host;
    proxy_cache_bypass $http_upgrade;
  }
}
```

#### 使用 Let's Encrypt 获取免费 HTTPS：

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com
```

---

### 安全最佳实践总结：

| 项目          | 建议                                                         |
| ----------- | ---------------------------------------------------------- |
| 输入校验        | 对所有输入进行校验（类型、格式、长度）                                        |
| 身份认证        | 使用 JWT + 中间件                                               |
| 授权控制        | 根据角色控制不同接口访问权限                                             |
| 加密存储        | 用户密码使用 bcrypt/scrypt 进行加密存储                                |
| SQL 注入防范    | 使用参数化查询，避免动态拼接 SQL                                         |
| HTTPS 配置    | 强制启用 HTTPS，防止中间人攻击                                         |
| Token 过期与刷新 | 设置有效期，并提供刷新机制                                              |
| 安全头设置       | 使用 `X-Frame-Options`, `Content-Security-Policy` 等 HTTP 安全头 |

---

✅ 示例：使用中间件校验用户身份、角色权限：

```dart
Handler middleware(Handler handler) {
  return (context) async {
    final token = context.request.headers['Authorization']?.split(' ').last;
    if (token == null) return Response(statusCode: 401);

    try {
      final jwt = JWT.verify(token, SecretKey('secret'));
      final role = jwt.payload['role'] as String;
      if (role != 'admin') return Response(statusCode: 403, body: 'Forbidden');
      return handler(context);
    } catch (_) {
      return Response(statusCode: 401);
    }
  };
}
```

---



# 12. 测试

高质量的 Web 服务离不开可靠的测试。Dart Frog 基于 Dart 的强大测试框架 `package:test`，支持单元测试、集成测试及中间件、路由测试。

---

## 12.1 Dart Frog 测试支持

### 添加依赖：

确保 `dev_dependencies` 中包含以下内容：

```yaml
dev_dependencies:
  test: ^1.24.0
  dart_frog_test: ^0.3.0
```

---

## 12.2 单元测试与集成测试

### 单元测试适用于：

* 工具函数
* 数据模型
* 数据库封装类

示例：

```dart
import 'package:test/test.dart';

String greet(String name) => 'Hello, $name!';

void main() {
  test('greet returns correct greeting', () {
    expect(greet('Alice'), equals('Hello, Alice!'));
  });
}
```

### 集成测试适用于：

* 测试完整路由逻辑
* 验证中间件与响应配合

---

## 12.3 模拟请求与响应

使用 `dart_frog_test` 中的 `TestClient` 可以轻松模拟请求。

### 示例：测试 GET 路由

假设 `routes/hello.dart`:

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response.json(body: {'message': 'Hello, Dart Frog!'});
}
```

对应测试：

```dart
import 'package:test/test.dart';
import 'package:dart_frog_test/dart_frog_test.dart';

void main() {
  group('GET /hello', () {
    test('returns 200 and greeting message', () async {
      final client = TestClient(path: '/hello');
      final response = await client.get();

      expect(response.statusCode, equals(200));
      expect(response.json(), completion(containsPair('message', 'Hello, Dart Frog!')));
    });
  });
}
```

---

## 12.4 测试中间件和路由

你可以创建测试专用的中间件注入上下文，或验证身份认证逻辑。

### 示例：中间件中注入用户 ID

`middleware.dart`:

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) {
    final request = context.request;
    final token = request.headers['Authorization'];
    if (token == 'Bearer test') {
      final newContext = context.provide<String>(() => 'user_123');
      return handler(newContext);
    }
    return Response(statusCode: 401);
  };
}
```

`routes/profile.dart`:

```dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final userId = context.read<String>();
  return Response.json(body: {'userId': userId});
}
```

测试：

```dart
import 'package:test/test.dart';
import 'package:dart_frog_test/dart_frog_test.dart';

void main() {
  test('GET /profile with token returns userId', () async {
    final client = TestClient(path: '/profile');

    final response = await client.get(headers: {
      'Authorization': 'Bearer test',
    });

    expect(response.statusCode, equals(200));
    expect(response.json(), completion(containsPair('userId', 'user_123')));
  });

  test('GET /profile without token returns 401', () async {
    final client = TestClient(path: '/profile');
    final response = await client.get();

    expect(response.statusCode, equals(401));
  });
}
```

---

## ✅ 小结

| 类型    | 用法                     |
| ----- | ---------------------- |
| 单元测试  | 函数、类、模型、工具函数           |
| 集成测试  | 路由逻辑、响应格式、状态码验证        |
| 中间件测试 | 验证授权、注入上下文、请求头检查等      |
| 工具    | 使用 `TestClient` 模拟请求环境 |

---



# 13. 部署与运维

构建一个可靠的 Dart Frog 应用不仅仅是开发功能，还包括部署、监控、自动重启等 DevOps 能力的支持。

---

## 13.1 构建生产版本

Dart Frog 项目可以使用 `dart_frog build` 命令构建成独立的 Dart 应用，适用于生产部署。

```bash
dart_frog build
```

执行后会生成一个 `build/` 目录，其中包含：

* `build/bin/server.dart`：入口文件
* `build/routes/`：编译后的路由结构

你可以使用 Dart 命令直接运行：

```bash
dart run build/bin/server.dart
```

### 构建调优建议：

* 使用 `dart compile exe` 编译为本地可执行文件：

```bash
dart compile exe build/bin/server.dart -o server
./server
```

---

## 13.2 常用部署方式（Docker、云平台）

### 使用 Docker 部署

#### 示例 `Dockerfile`：

```Dockerfile
FROM dart:stable AS build

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建 Dart Frog 项目
RUN dart pub get
RUN dart_frog build
RUN dart compile exe build/bin/server.dart -o bin/server

# 生产镜像
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/server

# 端口配置
EXPOSE 8080

# 启动命令
ENTRYPOINT ["/app/server"]
```

#### 构建镜像并运行：

```bash
docker build -t dart_frog_app .
docker run -p 8080:8080 dart_frog_app
```

---

### 部署到云平台

你可以将构建好的可执行文件部署到：

* **VPS**（使用 Docker + Nginx）
* **Railway / Render**（支持 Dart）
* **Fly.io**（支持容器镜像）
* **Google Cloud Run / App Engine**
* **AWS EC2 + Docker Compose**

---

## 13.3 性能监控与日志管理

### 打印请求日志（中间件）：

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final stopwatch = Stopwatch()..start();
    final response = await handler(context);
    stopwatch.stop();

    print(
      '[${DateTime.now()}] ${context.request.method} ${context.request.uri} '
      '-> ${response.statusCode} (${stopwatch.elapsedMilliseconds}ms)',
    );

    return response;
  };
}
```

> 推荐配合 `dart_frog_logger` 或使用 `dart:developer`。

### 使用日志库：

```yaml
dependencies:
  logging: ^1.2.0
```

```dart
import 'package:logging/logging.dart';

final logger = Logger('AppLogger');

void setupLogger() {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((rec) {
    print('[${rec.level.name}] ${rec.time} ${rec.message}');
  });
}
```

---

### 性能监控工具建议：

* 使用 **nginx / caddy** 反向代理统计日志
* 使用 Dart 内置的 `Observatory`（dev）或 `vm-service`
* 配合监控平台如 Grafana + Prometheus（容器方案）

---

## 13.4 热重载与自动重启

### 开发模式热重载：

```bash
dart_frog dev
```

* 自动监听 `routes/`, `middleware/`, `main.dart` 等变动
* 实时刷新服务

---

### 使用 `watch` + `dart run` 进行自定义热重载：

```bash
dart pub global activate webdev
webdev serve --hot-reload
```

> 或使用 `watchexec`, `nodemon`, `reflex` 等跨平台工具监视文件变动。

### 示例（使用 `watchexec`）：

```bash
watchexec --exts dart --restart -- dart run build/bin/server.dart
```

---

✅ **小结表**：

| 运维项  | 推荐工具/方案                            |
| ---- | ---------------------------------- |
| 构建   | `dart_frog build` + `dart compile` |
| 部署   | Docker, VPS, Fly.io, Cloud Run     |
| 日志记录 | `logging` 库 + 中间件打印                |
| 性能监控 | Nginx 日志 / vm-service / Grafana    |
| 热重载  | `dart_frog dev` / `watchexec`      |
| 自动重启 | `systemd`, `pm2`, `supervisord`    |

---




# 14. 进阶话题

Dart Frog 不仅支持 REST API，还具备构建实时应用、文件服务、国际化、多协议等能力，适合打造更复杂的后端服务。

---

## 14.1 WebSocket 支持

Dart Frog 可通过 `web_socket_channel` 实现 WebSocket 服务。

### 添加依赖

```yaml
dependencies:
  web_socket_channel: ^2.4.0
```

### 示例：WebSocket 路由 `/ws`

```dart
// routes/ws.dart
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<Response> onRequest(RequestContext context) async {
  final socket = await WebSocketTransformer.upgrade(context.request);
  final channel = WebSocketChannel(socket);

  channel.stream.listen(
    (message) {
      print('Received: $message');
      channel.sink.add('Echo: $message');
    },
    onDone: () {
      print('Connection closed');
    },
  );

  return Response(statusCode: 101); // Upgrade done
}
```

### 客户端示例（Flutter）

```dart
import 'package:web_socket_channel/web_socket_channel.dart';

final channel = WebSocketChannel.connect(
  Uri.parse('ws://localhost:8080/ws'),
);

channel.sink.add('Hello');
channel.stream.listen((message) {
  print('Server says: $message');
});
```

---

## 14.2 文件上传下载

### 上传文件（multipart/form-data）

Dart Frog 可通过 `request.formData()` 获取上传内容。

```dart
// routes/upload.dart
import 'package:dart_frog/dart_frog.dart';
import 'dart:io';

Future<Response> onRequest(RequestContext context) async {
  final formData = await context.request.formData();
  final file = formData.files.first;

  final savePath = 'uploads/${file.name}';
  final ioFile = File(savePath);
  await ioFile.writeAsBytes(file.part.readBytes());

  return Response.json(body: {'status': 'uploaded', 'path': savePath});
}
```

> 注意：需确保 `uploads/` 目录存在。

### 下载文件

```dart
// routes/download/[filename].dart
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context, String filename) async {
  final file = File('uploads/$filename');
  if (!await file.exists()) {
    return Response(statusCode: 404);
  }

  final bytes = await file.readAsBytes();
  return Response(body: bytes, headers: {
    HttpHeaders.contentTypeHeader: 'application/octet-stream',
    HttpHeaders.contentDispositionHeader: 'attachment; filename=$filename',
  });
}
```

---

## 14.3 国际化支持

虽然 Dart Frog 不自带 i18n，但可以通过中间件 + Map 管理翻译。

### 示例：中间件注入语言

```dart
// middleware.dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) {
    final lang = context.request.headers['Accept-Language'] ?? 'en';
    return handler(context.provide<String>(() => lang));
  };
}
```

### 使用语言上下文

```dart
// routes/greet.dart
import 'package:dart_frog/dart_frog.dart';

final messages = {
  'en': 'Hello!',
  'zh': '你好！',
  'es': '¡Hola!',
};

Response onRequest(RequestContext context) {
  final lang = context.read<String>();
  final message = messages[lang] ?? messages['en']!;
  return Response.json(body: {'greeting': message});
}
```

---

## 14.4 GraphQL 集成方案

### 使用 `package:graphql_server` 或 `package:gql` 创建自定义 GraphQL 服务

添加依赖：

```yaml
dependencies:
  shelf_graphql: ^0.0.1
  graphql_server: ^5.1.1
```

> Dart Frog 暂无专属适配，但可通过 `dart_frog_shelf_bridge` 嵌入 shelf 服务。

### 示例：嵌入 GraphQL Server（shelf 方案）

```dart
// routes/graphql.dart
import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:graphql_server/graphql_server.dart';

final schema = GraphQLSchema(
  queryType: objectType('Query', fields: [
    field('hello', graphQLString.nonNull(),
      resolve: (_, __) => 'Hello from GraphQL!'),
  ]),
);

final handler = GraphQLHttpServer(schema);

Future<Response> onRequest(RequestContext context) {
  return handler.call(context.request);
}
```

---

## 14.5 与 Flutter 前端的结合实践

### 常见集成形式

* Flutter 使用 `http` 调用 REST API
* 使用 `web_socket_channel` 建立实时通道
* Dart 共用模型类（建议使用共享 Package）

### 示例：Flutter 调用 Dart Frog API

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchMessage() async {
  final res = await http.get(Uri.parse('http://localhost:8080/greet'));
  final data = jsonDecode(res.body);
  print('Message: ${data['greeting']}');
}
```

### Dart 共用模型（shared/models/user.dart）

```dart
class User {
  final String id;
  final String name;

  User(this.id, this.name);

  factory User.fromJson(Map<String, dynamic> json) =>
      User(json['id'], json['name']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
```

前后端通过共享 package 引用此类：

```yaml
# flutter/pubspec.yaml
dependencies:
  my_shared_models:
    path: ../shared
```

---

✅ 小结表：

| 主题         | 示例支持                 |
| ---------- | -------------------- |
| WebSocket  | Echo 实现、Flutter 客户端  |
| 文件上传下载     | form-data, byte 返回   |
| 国际化        | Header 语言注入 + Map 映射 |
| GraphQL    | 基于 shelf 的兼容方式       |
| Flutter 集成 | 共用模型、API 调用、实时通信     |

---




# 15. 资源与社区

学习和使用 Dart Frog 时，了解官方资料、活跃社区、优秀插件及学习资源，将帮助你更高效地构建后端服务。

---

## 15.1 官方文档与示例

### 📚 官方文档

- Dart Frog 官方文档主页（由 Very Good Ventures 提供）  
  👉 https://dartfrog.vgv.dev

- 快速上手指南（Getting Started）  
  https://dartfrog.vgv.dev/docs/getting-started

- CLI 命令参考  
  https://dartfrog.vgv.dev/docs/cli

### 🧪 示例项目

官方仓库中包含多个示例：

- GitHub: [verygoodopensource/dart_frog](https://github.com/VeryGoodOpenSource/dart_frog)

克隆后可查看示例：

```bash
git clone https://github.com/VeryGoodOpenSource/dart_frog.git
cd dart_frog/examples
```

---

## 15.2 社区论坛与讨论组

### 📢 社区平台

| 平台             | 链接                                                                                                                |
| -------------- | ----------------------------------------------------------------------------------------------------------------- |
| GitHub Issues  | [https://github.com/VeryGoodOpenSource/dart\_frog/issues](https://github.com/VeryGoodOpenSource/dart_frog/issues) |
| Discord 社群     | [https://discord.com/invite/verygoodventures](https://discord.com/invite/verygoodventures)                        |
| Reddit 子版块     | [https://reddit.com/r/flutterdev](https://reddit.com/r/flutterdev)                                                |
| DartLang Slack | [https://dartlang.slack.com](https://dartlang.slack.com)                                                          |

### 💬 推荐话题

* 中间件设计实践
* Dart 后端 vs Node.js / Go 性能讨论
* 与 Flutter 的最佳集成方式
* Dart 在微服务架构中的应用

---

## 15.3 开源插件与扩展

### 🔌 常用社区扩展包

| 名称                    | 用途               | 仓库地址                                                                              |
| --------------------- | ---------------- | --------------------------------------------------------------------------------- |
| `dart_frog_websocket` | WebSocket 封装     | 自实现                                                                               |
| `dart_frog_logger`    | 统一日志中间件          | 非官方                                                                               |
| `shelf_graphql`       | GraphQL 服务支持     | [https://pub.dev/packages/shelf\_graphql](https://pub.dev/packages/shelf_graphql) |
| `dart_frog_jwt`       | JWT 登录中间件（可参考自建） | 自实现                                                                               |

### 📦 自定义中间件封装示例（CORS）

```dart
// middleware/cors.dart
import 'package:dart_frog/dart_frog.dart';

Handler corsMiddleware(Handler handler) {
  return (context) async {
    final response = await handler(context);
    return response.copyWith(headers: {
      ...response.headers,
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': '*',
    });
  };
}
```

使用方式：

```dart
import 'middleware/cors.dart';

Handler middleware(Handler handler) {
  return corsMiddleware(handler);
}
```

---

## 15.4 学习资料推荐（博客、视频、教程）

### 📝 优质博客文章

* [Dart Frog 入门指南（VGV 官方）](https://dartfrog.vgv.dev/docs/getting-started)
* [Dart Frog vs Express（性能对比）](https://medium.com/@yourblog)
* [如何用 Dart 构建 RESTful API](https://dev.to/yourpost)

### 🎬 视频教程

| 标题                         | 链接                          |
| -------------------------- | --------------------------- |
| Dart Frog Introduction     | YouTube: Very Good Ventures |
| Flutter + Dart Frog 全栈实战教程 | Bilibili/YouTube （搜索关键字）    |
| 如何用 Dart Frog 构建博客 API     | YouTube/DevStream           |

### 📘 Dart 官方资源

* Dart 官方教程：[https://dart.dev/tutorials](https://dart.dev/tutorials)
* Dart 异步学习：[https://dart.dev/codelabs/async-await](https://dart.dev/codelabs/async-await)
* Flutter 与后端通信：[https://flutter.dev/docs/cookbook/networking](https://flutter.dev/docs/cookbook/networking)

---

✅ 小结表：

| 类别   | 推荐资源                                                 |
| ---- | ---------------------------------------------------- |
| 官方文档 | [https://dartfrog.vgv.dev](https://dartfrog.vgv.dev) |
| 社区交流 | Discord、Reddit、GitHub Issues                         |
| 插件扩展 | shelf\_graphql、jwt、自定义中间件                            |
| 学习资料 | 官方教程、博客文章、YouTube 视频                                 |

---



