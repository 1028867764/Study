
# 1. FastAPI 简介

* 1.1 什么是 FastAPI？
  * FastAPI 是一个现代、快速（高性能）的 Web 框架，用于构建 API，基于 Python 3.7+。
  * 它是用于构建 RESTful API 的一个框架，使用 Python 类型提示系统来进行声明式的代码编写。
  * FastAPI 在设计上优先考虑开发者的体验和性能。
  
* 1.2 FastAPI 的设计目标
  * **易用性**：减少编码的复杂性，提升开发效率，帮助开发者快速构建应用。
  * **高性能**：基于 Starlette 和 Pydantic 库，FastAPI 提供了接近 Node.js 和 Go 的性能。
  * **安全性**：内建安全特性，如数据验证、认证和授权。
  * **可扩展性**：设计上支持简单应用和复杂系统的开发。
  * **文档生成**：自动生成 API 文档，支持 Swagger UI 和 ReDoc，提供可交互的文档体验。

* 1.3 FastAPI 的优势

  * 1.3.1 **高性能（与 Node.js 和 Go 相当）**
    * FastAPI 在性能上与其他 Web 框架（如 Node.js 和 Go）相媲美，能够支持高并发请求。
    * 由于 FastAPI 使用异步 I/O 操作，能够充分利用 Python 的 `asyncio` 提供的并发能力。

  * 1.3.2 **自动生成 OpenAPI 文档（Swagger UI 和 ReDoc）**
    * FastAPI 自动生成 OpenAPI 规范，提供了两种可视化文档：Swagger UI 和 ReDoc。
    * 通过这些文档，开发者和前端可以方便地查看 API 接口详情，并且可以直接在浏览器中进行 API 调用测试。

  * 1.3.3 **简单易用**
    * FastAPI 遵循了 "约定大于配置" 的原则，提供简洁的 API 设计。
    * 支持 Python 类型注解（type hints）进行参数验证、自动文档生成等。
    * 代码简洁且可读性强，极大地提高了开发者的工作效率。

  * 1.3.4 **异步支持**
    * FastAPI 对异步 I/O 有着原生的支持，可以轻松处理大量并发请求。
    * 通过 `async`/`await` 语法，开发者可以在不阻塞的情况下执行数据库查询、文件操作等任务。

  * 1.3.5 **自动数据验证和转换**
    * FastAPI 使用 Pydantic 库进行自动的数据验证和转换。
    * 请求体、查询参数、路径参数等的数据类型和格式都可以通过类型注解进行声明，FastAPI 会自动验证并进行类型转换，确保输入数据的正确性。


# 2. 安装与运行

* 2.1 **安装 FastAPI 和 Uvicorn**
  * 首先，你需要安装 FastAPI 和 Uvicorn。FastAPI 是 Web 框架本身，Uvicorn 是一个用于运行 ASGI 应用的轻量级服务器。
  * 通过以下命令来安装：
    ```bash
    pip install fastapi uvicorn
    ```

* 2.2 **创建 FastAPI 项目**
  * 在你的工作目录中创建一个新的 Python 文件，例如 `main.py`，并编写基本的 FastAPI 应用代码。
  * 示例代码：
    ```python
    from fastapi import FastAPI

    app = FastAPI()

    @app.get("/")
    def read_root():
        return {"message": "Hello, World!"}
    ```
  * 这样，一个简单的 FastAPI 应用就创建好了，下一步就是启动它。

* 2.3 **启动应用**
  * 通过 Uvicorn 启动 FastAPI 应用。使用 `--reload` 选项，能够在代码修改后自动重新加载，适合开发时使用。
  * 运行以下命令启动应用：
    ```bash
    uvicorn main:app --reload
    ```
  * `main:app` 表示从 `main.py` 文件中导入 `app` 对象。
  * 启动后，FastAPI 应用会在 `http://127.0.0.1:8000` 地址上运行。你可以在浏览器中访问该地址，查看应用是否正常工作。

* 2.4 **配置服务器：Uvicorn、Gunicorn**
  * 默认情况下，Uvicorn 使用单进程运行，但是在生产环境中，建议使用 **Gunicorn** 配合 **Uvicorn** 来进行多进程和多线程的处理，以提高性能和并发能力。
  
  * **Uvicorn 配合 Gunicorn**
    * 安装 Gunicorn：
      ```bash
      pip install gunicorn
      ```
    * 启动 Gunicorn，指定 Uvicorn 作为工作类（worker class）：
      ```bash
      gunicorn -w 4 -k uvicorn.workers.UvicornWorker main:app
      ```
    * `-w 4` 表示启动 4 个工作进程，根据实际情况选择适当的数量。
    * 这种方式可以提升应用的性能，支持更多的并发请求。

  * **常见 Gunicorn 配置选项**
    * `-w`：指定工作进程的数量。
    * `-k`：指定工作进程的类型，使用 `uvicorn.workers.UvicornWorker` 以支持异步。
    * `--bind`：指定服务器绑定的地址和端口，例如 `--bind 0.0.0.0:8000` 以便外部访问。

  * **推荐的生产环境配置**
    * 在生产环境中，通常使用反向代理（如 Nginx）来处理外部请求，内部请求通过 Gunicorn 转发到 Uvicorn。
    * 使用系统工具（如 `systemd`）来启动并管理应用，以确保应用在系统重启后能自动启动。



# 3. FastAPI 路由

## 3.1 **路由基本概念**
  * 路由是 FastAPI 中的核心部分，定义了请求路径和 HTTP 方法与处理逻辑之间的映射关系。
  * 每个路由对应一个 HTTP 请求方法（如 GET、POST、PUT、DELETE 等），并与 URL 路径绑定，处理客户端的请求并返回响应。
  * 路由通过装饰器来定义，装饰器用于指定路由对应的请求方法及路径。

## 3.2 **路由装饰器**
  * 路由装饰器用于为特定路径和 HTTP 方法定义视图函数。常见的路由装饰器如下：

  * 3.2.1 **`@app.get()`**
    * 用于定义处理 `GET` 请求的路由。`GET` 请求通常用于获取资源。
    * 示例：
      ```python
      @app.get("/")
      def read_root():
          return {"message": "Hello, World!"}
      ```
    * `@app.get("/path")` 用于处理特定路径的 `GET` 请求。

  * 3.2.2 **`@app.post()`**
    * 用于定义处理 `POST` 请求的路由。`POST` 请求通常用于创建资源。
    * 示例：
      ```python
      @app.post("/items/")
      def create_item(item: Item):
          return {"name": item.name, "description": item.description}
      ```
    * 路由处理函数中通常会接受请求体数据（如 JSON 或表单数据）。

  * 3.2.3 **`@app.put()`**
    * 用于定义处理 `PUT` 请求的路由。`PUT` 请求通常用于更新资源。
    * 示例：
      ```python
      @app.put("/items/{item_id}")
      def update_item(item_id: int, item: Item):
          return {"item_id": item_id, "name": item.name, "description": item.description}
      ```

  * 3.2.4 **`@app.delete()`**
    * 用于定义处理 `DELETE` 请求的路由。`DELETE` 请求通常用于删除资源。
    * 示例：
      ```python
      @app.delete("/items/{item_id}")
      def delete_item(item_id: int):
          return {"message": f"Item with ID {item_id} has been deleted."}
      ```

## 3.3 **路由路径参数**
  * 路由路径参数是 URL 路径的一部分，可以通过 `{}` 包裹变量来定义。例如：
    ```python
    @app.get("/items/{item_id}")
    def read_item(item_id: int):
        return {"item_id": item_id}
    ```
  * 这里，`item_id` 是路径参数，FastAPI 会自动将 URL 中对应部分的值赋给函数的参数。

## 3.4 **查询参数、表单参数**
  * **查询参数**：通过 URL 中的 `?key=value` 格式传递。FastAPI 会自动将查询参数映射到函数的参数中。
    ```python
    @app.get("/items/")
    def read_items(skip: int = 0, limit: int = 10):
        return {"skip": skip, "limit": limit}
    ```
  * **表单参数**：可以通过 `Form` 类获取表单数据，通常用于处理 `POST` 请求中的表单数据。
    ```python
    from fastapi import Form

    @app.post("/login/")
    def login(username: str = Form(...), password: str = Form(...)):
        return {"username": username, "password": password}
    ```
  
## 3.5 **请求体数据（使用 Pydantic）**
  * FastAPI 支持通过 Pydantic 模型来定义请求体的数据结构。Pydantic 会进行数据验证和转换，确保请求体的数据格式正确。
  * 示例：
    ```python
    from pydantic import BaseModel

    class Item(BaseModel):
        name: str
        description: str = None

    @app.post("/items/")
    def create_item(item: Item):
        return {"name": item.name, "description": item.description}
    ```
  * 请求体数据会自动解析为 Pydantic 模型，并进行类型验证。

## 3.6 **路由返回值：JSON、字符串、HTML**
  * FastAPI 默认返回的数据类型是 JSON。当返回一个字典、列表或其他 Python 数据结构时，FastAPI 会自动将其转换为 JSON 格式返回。
    ```python
    @app.get("/items/")
    def read_items():
        return {"items": ["item1", "item2"]}
    ```
  * 返回字符串：
    ```python
    @app.get("/message/")
    def get_message():
        return "Hello, FastAPI!"
    ```
  * 返回 HTML：
    * 如果需要返回 HTML 格式的响应，可以使用 `HTMLResponse`：
      ```python
      from fastapi.responses import HTMLResponse

      @app.get("/html", response_class=HTMLResponse)
      def read_html():
          return "<html><body><h1>Hello, HTML!</h1></body></html>"
      ```
  * 通过 `response_class` 参数可以设置返回不同类型的响应。


# 4. 请求与响应模型

## 4.1 **使用 Pydantic 模型进行数据验证**
  * Pydantic 是 FastAPI 中用于数据验证和解析的核心库，它允许你通过类型提示（type hints）来验证请求数据的格式和类型。
  * 定义一个 Pydantic 模型，用于验证请求体（Request Body）或查询参数。
  * 示例：
    ```python
    from pydantic import BaseModel

    class Item(BaseModel):
        name: str
        description: str = None
        price: float
        tax: float = None
    ```

  * 在路由中使用 Pydantic 模型来自动验证请求数据：
    ```python
    @app.post("/items/")
    def create_item(item: Item):
        return {"name": item.name, "price": item.price}
    ```
  * 这样，当请求体数据格式不符合模型时，FastAPI 会自动返回 422 状态码，并指出错误的字段。

## 4.2 **请求体（Request Body）：JSON、表单、文件上传**
  * **JSON 数据**：FastAPI 会自动将 JSON 格式的请求体解析为对应的 Pydantic 模型。
    * 示例：
      ```json
      {
        "name": "Item 1",
        "description": "This is an item",
        "price": 10.99,
        "tax": 0.8
      }
      ```
    * FastAPI 会自动将其解析为 `Item` 模型并传递给路由函数。
  * **表单数据**：当接收到表单数据时，可以通过 `Form` 类来提取数据。
    ```python
    from fastapi import Form

    @app.post("/upload/")
    def upload_file(name: str = Form(...), description: str = Form(...)):
        return {"name": name, "description": description}
    ```
  * **文件上传**：可以通过 `File` 类处理文件上传，FastAPI 会将文件保存到内存或磁盘中。
    ```python
    from fastapi import File, UploadFile

    @app.post("/uploadfile/")
    async def upload_file(file: UploadFile = File(...)):
        contents = await file.read()
        return {"filename": file.filename, "size": len(contents)}
    ```

## 4.3 **响应模型：使用 Pydantic 来定义响应格式**
  * 在 FastAPI 中，响应数据也可以通过 Pydantic 模型来定义，确保返回的数据格式符合预期。
  * 响应模型可以与请求体的模型相同或不同。定义响应模型可以帮助自动生成 API 文档。
  * 示例：
    ```python
    class ItemResponse(BaseModel):
        name: str
        description: str = None
        price: float

    @app.post("/items/", response_model=ItemResponse)
    def create_item(item: Item):
        return {"name": item.name, "price": item.price}
    ```
  * 通过 `response_model` 参数，FastAPI 会自动将返回的数据转换为指定的模型，并进行数据验证。

## 4.4 **HTTP 状态码：`HTTP_200_OK` 等**
  * FastAPI 提供了一些常用的 HTTP 状态码常量，帮助开发者更清晰地定义响应状态码。
  * 常见状态码：
    * `HTTP_200_OK`：请求成功，通常用于成功的 GET 或 POST 请求。
    * `HTTP_201_CREATED`：资源创建成功，通常用于 POST 请求。
    * `HTTP_204_NO_CONTENT`：请求成功，但没有返回内容，通常用于 DELETE 请求。
    * `HTTP_400_BAD_REQUEST`：请求参数错误。
    * `HTTP_404_NOT_FOUND`：请求的资源不存在。
    * `HTTP_500_INTERNAL_SERVER_ERROR`：服务器错误。

  * 示例：
    ```python
    from fastapi import HTTPException, status

    @app.post("/items/")
    def create_item(item: Item):
        if item.price <= 0:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Price must be positive"
            )
        return {"name": item.name, "price": item.price}
    ```

## 4.5 **响应头与 Cookie**
  * FastAPI 允许你轻松地添加响应头和 Cookies。
  
  * **响应头**：可以使用 `JSONResponse` 或 `PlainTextResponse` 等类来设置自定义的响应头。
    ```python
    from fastapi.responses import JSONResponse

    @app.get("/custom_header/")
    def custom_header():
        return JSONResponse(
            {"message": "Hello with custom header"},
            headers={"X-Custom-Header": "FastAPI"}
        )
    ```

  * **设置 Cookie**：FastAPI 提供了对 `Set-Cookie` 响应头的支持。
    ```python
    from fastapi.responses import JSONResponse
    from fastapi import Response

    @app.get("/set_cookie/")
    def set_cookie(response: Response):
        response.set_cookie(key="user_token", value="abc123")
        return {"message": "Cookie set"}
    ```

  * **获取 Cookie**：可以通过 `Request` 对象来获取客户端的 Cookie。
    ```python
    from fastapi import Request

    @app.get("/get_cookie/")
    def get_cookie(request: Request):
        user_token = request.cookies.get("user_token")
        return {"user_token": user_token}
    ```




# 5. Pydantic 数据验证

## 5.1 什么是 Pydantic？
Pydantic 是一个数据验证和设置管理库，广泛应用于 FastAPI 中。它通过 Python 类型注解和数据类（`BaseModel`）来进行数据验证、转换和管理。Pydantic 提供了以下主要功能：
- 自动数据验证：通过类型注解对输入数据进行验证。
- 数据转换：将输入的数据转换为指定的类型。
- 错误处理：当数据验证失败时，Pydantic 会提供详细的错误信息。

Pydantic 是 FastAPI 的核心组成部分，它通过验证请求数据的结构和类型来确保数据安全与可靠性。

## 5.2 定义模型（数据类）

### 5.2.1 类型注解
Pydantic 使用 Python 类型注解（`type hints`）来定义数据模型。每个字段的类型注解都用于验证传入数据的类型。基本类型包括：`str`、`int`、`float`、`bool`、`list`、`dict` 等。

例如，定义一个简单的数据模型：
```python
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    description: str = None
    price: float
```

在这个例子中，`name` 必须是字符串类型，`price` 必须是浮动类型，`description` 是一个可选字段。

### 5.2.2 数据验证

Pydantic 自动根据类型注解对数据进行验证。例如，如果传入的数据类型不匹配，会抛出 `ValidationError`。

示例：

```python
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    price: float

item = Item(name="item1", price="string")  # 将触发类型验证错误
```

这里，`price` 字段应为 `float` 类型，而传入的却是字符串，Pydantic 会自动抛出错误并说明问题。

### 5.2.3 默认值和可选字段

你可以为模型字段提供默认值，或者使某些字段变为可选（`Optional`）。默认值可以是常量，也可以是函数（如当前时间）。

```python
from typing import Optional
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    description: Optional[str] = None  # 可选字段
    price: float = 0.0  # 默认值
```

在这个示例中，`description` 是可选的，而 `price` 默认值为 `0.0`。

## 5.3 输入验证：类型检查、范围限制

Pydantic 支持对字段进行类型检查、范围限制等更为复杂的验证。

### 类型检查

Pydantic 会自动对输入数据进行类型检查。例如：

```python
class Item(BaseModel):
    name: str
    price: float
```

如果传入的数据类型与字段类型不匹配，Pydantic 会抛出一个错误。

### 范围限制

你可以使用 Pydantic 的验证器来限制数值的范围或其他约束条件。

```python
from pydantic import BaseModel, condecimal

class Item(BaseModel):
    name: str
    price: condecimal(gt=0)  # 限制价格必须大于0
```

`condecimal` 是 Pydantic 提供的用于限制数字范围的类型，可以用于 `float` 和 `Decimal` 类型，常用于设置价格、年龄等字段。

## 5.4 输出验证与转换

Pydantic 不仅用于输入验证，还支持输出数据的格式化和转换。

### 自定义输出

你可以在 Pydantic 模型中定义方法来调整输出格式。通过 `@root_validator` 或 `@validator` 装饰器可以进行复杂的字段级验证和转换。

例如：

```python
from pydantic import BaseModel, validator

class Item(BaseModel):
    name: str
    price: float

    @validator('name')
    def name_must_be_upper(cls, v):
        return v.upper()
```

在这个例子中，`name` 字段将在输出时被转换为大写。

### 使用 `@root_validator`

通过 `@root_validator`，你可以验证整个模型的逻辑，允许对多个字段之间的关系进行检查。

```python
from pydantic import BaseModel, root_validator

class Item(BaseModel):
    name: str
    price: float
    tax: float = 0.0

    @root_validator
    def check_price_and_tax(cls, values):
        price = values.get('price')
        tax = values.get('tax')
        if price < tax:
            raise ValueError('Price cannot be less than tax')
        return values
```

通过 `root_validator`，你可以对 `price` 和 `tax` 字段之间的关系进行检查，确保价格大于税收。



# 6. 异步编程支持

FastAPI 完全支持异步编程，可以充分利用 Python 的 `async`/`await` 语法实现高性能的异步操作。

## 6.1 异步视图函数（`async def`）

在 FastAPI 中，可以直接使用 `async def` 定义异步视图函数：

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/async-endpoint")
async def async_endpoint():
    # 这里可以执行异步操作
    return {"message": "This is an async endpoint"}
```

> **注意**：即使函数内部没有 `await` 调用，使用 `async def` 定义的函数仍然会被正确处理。但为了实际获得异步性能优势，应该在函数内部执行真正的异步操作。

## 6.2 异步 I/O：使用 `await` 进行异步操作

可以在视图函数中使用 `await` 调用任何兼容的异步库：

```python
import asyncio
from fastapi import FastAPI

app = FastAPI()

@app.get("/async-io")
async def async_io_example():
    # 模拟异步I/O操作
    await asyncio.sleep(1)
    return {"message": "Completed after 1 second"}
```

实际应用中常用于：
- 异步HTTP请求（如 `httpx`）
- 异步文件操作
- 异步数据库查询

## 6.3 与数据库的异步交互

FastAPI 支持多种异步数据库库：

### 使用 asyncpg (PostgreSQL)

```python
from fastapi import FastAPI
import asyncpg

app = FastAPI()

@app.on_event("startup")
async def startup():
    app.state.db = await asyncpg.connect("postgresql://user:password@localhost/dbname")

@app.on_event("shutdown")
async def shutdown():
    await app.state.db.close()

@app.get("/users/{user_id}")
async def get_user(user_id: int):
    user = await app.state.db.fetchrow("SELECT * FROM users WHERE id = $1", user_id)
    return dict(user)
```

### 使用 Tortoise-ORM (ORM支持)

```python
from fastapi import FastAPI
from tortoise.contrib.fastapi import register_tortoise

app = FastAPI()

register_tortoise(
    app,
    db_url="sqlite://db.sqlite3",
    modules={"models": ["app.models"]},
    generate_schemas=True,
    add_exception_handlers=True,
)

@app.get("/users/{user_id}")
async def get_user(user_id: int):
    from app.models import User
    user = await User.get(id=user_id)
    return {"id": user.id, "name": user.name}
```

## 6.4 异步请求处理

FastAPI 可以同时处理同步和异步请求，并自动优化性能：

```python
from fastapi import FastAPI
import httpx

app = FastAPI()

# 异步HTTP请求示例
@app.get("/external-api")
async def fetch_external_data():
    async with httpx.AsyncClient() as client:
        response = await client.get("https://jsonplaceholder.typicode.com/todos/1")
        return response.json()

# 同步函数也可以（但会阻塞事件循环）
@app.get("/sync-endpoint")
def sync_endpoint():
    # 注意：这里如果执行CPU密集型或阻塞操作会影响性能
    return {"message": "This is a synchronous endpoint"}
```

> **重要提示**：
> - 异步函数中应避免调用阻塞操作（如普通 `time.sleep()` 或同步数据库驱动）
> - 对于CPU密集型任务，考虑使用 `BackgroundTasks` 或单独的服务
> - 同步和异步端点可以混合使用，但异步端点能更好地利用系统资源




# 7. 依赖注入

FastAPI 提供了一个强大的依赖注入系统，允许我们通过 `Depends` 来将常见功能或服务（如数据库连接、认证、安全措施等）注入到视图函数中。通过依赖注入，代码变得更加模块化、可维护，并且具有较高的重用性。

## 7.1 FastAPI 的依赖注入系统

FastAPI 的依赖注入系统基于 Python 的类型提示（Type Hinting），并通过 `Depends` 来实现。依赖注入可以在请求生命周期内提供一些服务或功能，比如数据库连接、配置文件、外部 API 客户端等。

### 示例：简单的依赖注入

```python
from fastapi import FastAPI, Depends

app = FastAPI()

def common_dependency(query: str = "default"):
    return {"query": query}

@app.get("/items")
async def read_items(dep: dict = Depends(common_dependency)):
    return {"message": "Items fetched", "query": dep["query"]}
```

在上面的例子中，`common_dependency` 函数返回一个字典，它被注入到 `read_items` 视图函数中。FastAPI 会自动处理依赖关系，并将其传递给视图函数。

## 7.2 使用 `Depends` 定义依赖

依赖通过 `Depends` 来定义。你可以将任何可调用的对象（如函数、类）作为依赖注入到视图函数中。常见的依赖包括数据库连接、用户认证、配置文件等。

### 示例：自定义依赖

```python
from fastapi import Depends

def get_db():
    db = "连接到数据库"
    return db

@app.get("/users")
async def get_users(db: str = Depends(get_db)):
    return {"message": "用户数据", "db_connection": db}
```

### 关键点：

* 使用 `Depends` 来声明依赖。
* 任何带有 `Depends` 的函数或对象都会自动注入。

## 7.3 依赖注入的常见场景

### 7.3.1 数据库连接

数据库连接是依赖注入的常见应用场景。通过依赖注入，可以将数据库连接复用，避免每个请求都创建新的连接。

#### 示例：使用依赖注入管理数据库连接

```python
import databases

DATABASE_URL = "postgresql://user:password@localhost/dbname"
database = databases.Database(DATABASE_URL)

def get_db():
    return database

@app.on_event("startup")
async def startup():
    await database.connect()

@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()

@app.get("/items")
async def read_items(db: databases.Database = Depends(get_db)):
    query = "SELECT * FROM items"
    return await db.fetch_all(query)
```

在这个例子中，数据库连接通过 `get_db` 依赖注入到视图函数中。

### 7.3.2 安全认证

安全认证通常包括用户身份验证和授权。可以使用依赖注入来处理这些任务，如通过 JWT token 或 OAuth2。

#### 示例：使用依赖注入进行认证

```python
from fastapi import Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def get_current_user(token: str = Depends(oauth2_scheme)):
    if token != "valid_token":
        raise HTTPException(status_code=401, detail="Invalid authentication credentials")
    return {"user": "authenticated_user"}

@app.get("/secure-data")
async def get_secure_data(user: dict = Depends(get_current_user)):
    return {"message": "Access granted", "user": user["user"]}
```

### 7.3.3 配置文件加载

在某些应用中，配置文件需要注入到多个视图函数中。这时，依赖注入可以帮助你更好地管理配置文件的加载。

#### 示例：使用依赖注入加载配置文件

```python
import json
from fastapi import Depends

def get_config():
    with open("config.json") as f:
        config = json.load(f)
    return config

@app.get("/config")
async def get_config_data(config: dict = Depends(get_config)):
    return {"config": config}
```

## 7.4 依赖的作用域：单次请求、全局

在 FastAPI 中，依赖的作用域可以控制它们的生命周期。依赖注入的作用域有两种常见的模式：单次请求作用域（每次请求都会创建一个新的实例）和全局作用域（依赖会被复用）。

### 7.4.1 单次请求作用域

这是默认的作用域。在每个请求中，FastAPI 会为每个请求创建新的依赖实例。

```python
def get_request_id():
    return "unique_request_id"

@app.get("/request")
async def get_request_info(request_id: str = Depends(get_request_id)):
    return {"request_id": request_id}
```

每次请求都会调用 `get_request_id` 并生成新的 ID。

### 7.4.2 全局作用域

你可以将依赖设置为全局作用域，这样它将在整个应用的生命周期内共享。

#### 示例：全局作用域依赖

```python
from fastapi import FastAPI, Depends

app = FastAPI()

class AppConfig:
    def __init__(self):
        self.db_url = "postgresql://user:password@localhost/dbname"

app_config = AppConfig()

def get_app_config():
    return app_config

@app.get("/config")
async def get_app_configuration(config: AppConfig = Depends(get_app_config)):
    return {"db_url": config.db_url}
```

在这个示例中，`AppConfig` 类的实例是全局共享的，所有请求都使用相同的配置。

```

这样，你就有了一个完整的依赖注入系统示例，涵盖了常见的使用场景，如数据库连接、安全认证和配置文件加载，另外还讨论了依赖的作用域。你可以根据项目需要，调整和扩展这些示例。
```




# 8. 身份验证与授权

在 Web 应用中，身份验证和授权是确保应用安全性的重要组成部分。FastAPI 提供了多种身份验证和授权方式，包括基本认证、JWT 令牌、OAuth2、OpenID Connect 等。此外，FastAPI 允许你自定义认证逻辑，并结合角色基础的访问控制（RBAC）来控制用户的权限。

## 8.1 基本认证与令牌认证（JWT）

### 基本认证

基本认证（Basic Authentication）是最简单的一种认证方式，用户通过提供用户名和密码来访问资源。FastAPI 提供了一个 `HTTPBasic` 类，可以帮助你快速实现这一功能。

#### 示例：基本认证

```python
from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import HTTPBasic, HTTPBasicCredentials

app = FastAPI()
security = HTTPBasic()

def verify_user(credentials: HTTPBasicCredentials = Depends(security)):
    if credentials.username != "admin" or credentials.password != "secret":
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return credentials.username

@app.get("/protected")
async def protected_route(user: str = Depends(verify_user)):
    return {"message": "Hello, admin!", "user": user}
```

在这个例子中，我们使用 `HTTPBasic` 来获取用户的用户名和密码，然后在 `verify_user` 函数中进行验证。

### 令牌认证（JWT）

JWT（JSON Web Token）是一种用于认证的开放标准，常用于在 Web 应用中传递安全信息。在 FastAPI 中，你可以使用 `OAuth2PasswordBearer` 来处理令牌认证。

#### 示例：JWT 令牌认证

```python
from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from datetime import datetime, timedelta
import jwt

app = FastAPI()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
SECRET_KEY = "mysecretkey"
ALGORITHM = "HS256"

# 模拟的用户数据
fake_user_db = {
    "admin": {"password": "secret"}
}

def create_access_token(data: dict):
    expire = datetime.utcnow() + timedelta(minutes=30)
    to_encode = data.copy()
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload.get("sub")
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token has expired")
    except jwt.JWTError:
        raise HTTPException(status_code=401, detail="Invalid token")

@app.post("/token")
async def login(username: str, password: str):
    user = fake_user_db.get(username)
    if user is None or user["password"] != password:
        raise HTTPException(status_code=401, detail="Incorrect username or password")
    access_token = create_access_token(data={"sub": username})
    return {"access_token": access_token, "token_type": "bearer"}

@app.get("/protected")
async def protected_route(current_user: str = Depends(get_current_user)):
    return {"message": f"Hello, {current_user}"}
```

在这个例子中，用户通过 `login` 获取 JWT 令牌，然后使用该令牌访问受保护的资源。

## 8.2 OAuth2 和 OpenID Connect

OAuth2 是一种授权协议，常用于第三方登录（如 Google、GitHub 登录）。OpenID Connect 是基于 OAuth2 的身份验证协议。

### 示例：OAuth2 配置

```python
from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from fastapi.openapi.models import OAuthFlowsAuthorizationCode

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# 这个部分通常用于配置 OpenID Connect 授权服务
@app.get("/login")
async def login_with_oauth():
    return {"message": "Please log in with OAuth2"}
```

通常，OAuth2 和 OpenID Connect 需要和外部认证服务（如 Google、GitHub、Facebook 等）配合使用，FastAPI 通过 `OAuth2PasswordBearer` 和相应的授权流程提供了支持。

## 8.3 自定义安全和认证依赖

FastAPI 允许你创建自定义的安全认证依赖，可以更灵活地控制认证流程和行为。

### 示例：自定义认证依赖

```python
from fastapi import Depends, HTTPException

def get_api_key(api_key: str = Depends(oauth2_scheme)):
    if api_key != "expected-api-key":
        raise HTTPException(status_code=403, detail="Forbidden")
    return api_key

@app.get("/custom-protected")
async def custom_protected_route(api_key: str = Depends(get_api_key)):
    return {"message": "You have access to this resource"}
```

在这个示例中，我们通过自定义的 `get_api_key` 函数来验证 API 密钥。

## 8.4 Role-based Access Control（RBAC）

RBAC（基于角色的访问控制）允许你根据用户的角色来控制访问权限。你可以为不同的角色设置不同的访问级别。

### 示例：基于角色的访问控制

```python
from fastapi import Depends, HTTPException

# 模拟的用户角色
user_roles = {
    "admin": "admin",
    "editor": "editor",
    "viewer": "viewer"
}

def get_user_role(user: str = Depends(get_current_user)):
    if user == "admin":
        return "admin"
    elif user == "editor":
        return "editor"
    else:
        return "viewer"

def role_required(role: str):
    def role_checker(user_role: str = Depends(get_user_role)):
        if user_role != role:
            raise HTTPException(status_code=403, detail="Forbidden")
        return user_role
    return role_checker

@app.get("/admin")
async def admin_route(role: str = Depends(role_required("admin"))):
    return {"message": "Hello, Admin!"}

@app.get("/editor")
async def editor_route(role: str = Depends(role_required("editor"))):
    return {"message": "Hello, Editor!"}
```

在这个示例中，只有拥有 `admin` 或 `editor` 角色的用户才能访问相应的资源。

## 8.5 使用 `Depends` 处理认证

在 FastAPI 中，你可以通过 `Depends` 轻松地将认证逻辑嵌入到视图函数中，实现认证和授权的自动处理。

### 示例：认证依赖处理

```python
@app.get("/profile")
async def profile(current_user: str = Depends(get_current_user)):
    return {"message": f"Welcome {current_user}'s profile"}
```

在这个示例中，`get_current_user` 函数是一个认证依赖，它会自动在每次请求时验证用户身份。如果用户没有提供有效的令牌或认证信息，将返回 401 错误。


这些内容涵盖了 FastAPI 中常见的身份验证与授权技术，包括基本认证、JWT 令牌认证、OAuth2、OpenID Connect、自定义认证依赖、RBAC 等，你可以根据需求调整和扩展这些示例。




# 9. 错误处理与自定义异常

在 Web 应用开发中，错误处理和异常捕获是确保系统稳定性和用户体验的重要部分。FastAPI 提供了丰富的错误处理机制，可以通过自定义异常、`HTTPException` 以及错误响应的格式化来更精确地控制错误返回。

## 9.1 常见 HTTP 错误：`400 Bad Request`, `404 Not Found`, `500 Internal Server Error`

HTTP 状态码是 Web 应用与客户端之间交换状态信息的标准方式，常见的错误状态码包括：

- `400 Bad Request`: 请求无效，通常是由于客户端发送了错误的数据。
- `404 Not Found`: 请求的资源未找到。
- `500 Internal Server Error`: 服务器内部错误，通常是服务器代码问题。

### 示例：返回 `400 Bad Request` 错误

```python
from fastapi import FastAPI, HTTPException

app = FastAPI()

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    if item_id < 1:
        raise HTTPException(status_code=400, detail="Invalid item ID")
    return {"item_id": item_id}
```

### 示例：返回 `404 Not Found` 错误

```python
@app.get("/items/{item_id}")
async def read_item(item_id: int):
    if item_id == 999:
        raise HTTPException(status_code=404, detail="Item not found")
    return {"item_id": item_id}
```

### 示例：返回 `500 Internal Server Error` 错误

```python
@app.get("/error")
async def cause_error():
    raise HTTPException(status_code=500, detail="Internal server error")
```

## 9.2 异常处理：自定义异常、HTTPException

FastAPI 提供了 `HTTPException` 来处理 HTTP 错误。在一些特殊的业务场景中，你可能需要创建自定义异常类，以便在应用中抛出和捕获。

### 示例：自定义异常类

```python
from fastapi import FastAPI, HTTPException

class CustomException(Exception):
    def __init__(self, name: str):
        self.name = name

@app.get("/custom_error")
async def read_item():
    raise CustomException(name="Example Error")

@app.exception_handler(CustomException)
async def custom_exception_handler(request, exc: CustomException):
    return {"error": f"Custom error occurred: {exc.name}"}
```

在这个例子中，`CustomException` 是一个自定义异常，我们通过 `@app.exception_handler()` 装饰器来定义如何处理这个异常。

### 示例：使用 `HTTPException`

```python
@app.get("/item/{item_id}")
async def get_item(item_id: int):
    if item_id == 0:
        raise HTTPException(status_code=400, detail="Item ID cannot be 0")
    return {"item_id": item_id}
```

## 9.3 错误响应的格式化

FastAPI 默认的错误响应是以 JSON 格式返回错误信息，但你可以自定义错误响应的格式，以提供更有用的错误信息。

### 示例：自定义错误响应格式

```python
from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse

app = FastAPI()

@app.exception_handler(HTTPException)
async def custom_http_exception_handler(request, exc: HTTPException):
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "error": {
                "status_code": exc.status_code,
                "detail": exc.detail,
                "message": f"An error occurred: {exc.detail}",
            }
        },
    )

@app.get("/error")
async def error():
    raise HTTPException(status_code=400, detail="Bad Request Error")
```

在这个例子中，错误响应格式被自定义为包含更多的详细信息，例如 `status_code` 和 `message`。

## 9.4 使用 `@app.exception_handler()` 自定义错误处理器

FastAPI 允许你为不同的异常类型定义专门的处理函数，可以帮助你针对特定的错误类型做更细致的错误响应处理。

### 示例：自定义 `404 Not Found` 错误处理器

```python
from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse

app = FastAPI()

@app.exception_handler(HTTPException)
async def custom_http_exception_handler(request, exc: HTTPException):
    if exc.status_code == 404:
        return JSONResponse(
            status_code=404,
            content={"error": "Resource not found", "detail": exc.detail}
        )
    return JSONResponse(
        status_code=exc.status_code,
        content={"error": exc.detail}
    )

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    if item_id == 999:
        raise HTTPException(status_code=404, detail="Item not found")
    return {"item_id": item_id}
```

### 示例：自定义 500 错误处理器

```python
@app.exception_handler(HTTPException)
async def handle_500_error(request, exc: HTTPException):
    if exc.status_code == 500:
        return JSONResponse(
            status_code=500,
            content={"error": "Internal server error", "message": "Something went wrong!"}
        )
    return await http_exception_handler(request, exc)
```

在上面的示例中，`@app.exception_handler()` 用于捕获特定的异常并返回自定义的错误响应。你可以根据不同的错误码进行不同的处理。

这些内容涵盖了 FastAPI 中的错误处理机制，包括如何使用 `HTTPException`、如何自定义异常、格式化错误响应以及使用 `@app.exception_handler()` 来创建自定义的错误处理器。你可以根据项目需求，调整和扩展这些示例。




# 10. 路径操作（Endpoint）文档生成

FastAPI 提供了强大的文档生成功能，默认支持 OpenAPI 和 Swagger UI，能够帮助开发者快速生成交互式 API 文档。通过自定义文档信息和详细的路径操作说明，FastAPI 可以使 API 文档更加清晰和易于使用。

## 10.1 OpenAPI 自动生成

OpenAPI 是一个开放标准，描述了 RESTful API 的规范。FastAPI 会自动根据代码生成 OpenAPI 文档，并且你可以通过 URL 访问该文档。

默认情况下，FastAPI 会在启动时自动生成 OpenAPI 文档，访问路径为 `/openapi.json`。

### 示例：自动生成 OpenAPI 文档

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```

访问 `http://127.0.0.1:8000/openapi.json`，你会看到自动生成的 OpenAPI 文档，描述了路径操作、请求参数、响应格式等信息。

## 10.2 Swagger UI

FastAPI 自动集成了 Swagger UI，它是一个交互式的 API 文档页面，可以让你测试 API 路径。你只需要启动 FastAPI 项目，在浏览器中访问 `http://127.0.0.1:8000/docs` 即可。

### 示例：访问 Swagger UI

```bash
uvicorn main:app --reload
```

然后在浏览器中访问 `http://127.0.0.1:8000/docs`，你将看到自动生成的 Swagger UI 页面，展示了所有的 API 路径和接口文档。

## 10.3 ReDoc 文档

FastAPI 还支持 ReDoc，它是另一种交互式 API 文档展示方式。与 Swagger UI 相比，ReDoc 采用了不同的布局和风格。你可以通过访问 `http://127.0.0.1:8000/redoc` 来查看 ReDoc 文档。

### 示例：访问 ReDoc 文档

```bash
uvicorn main:app --reload
```

然后在浏览器中访问 `http://127.0.0.1:8000/redoc`，你将看到基于 OpenAPI 的文档由 ReDoc 生成并展示。

## 10.4 自定义文档信息（标题、版本、描述）

你可以在 FastAPI 中自定义应用的文档信息，包括标题、版本、描述等内容。可以通过 `FastAPI` 类的参数来设置这些信息。

### 示例：自定义文档信息

```python
from fastapi import FastAPI

app = FastAPI(
    title="My FastAPI Application",
    description="This is a simple FastAPI application.",
    version="1.0.0"
)

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```

在这个示例中，我们自定义了应用的标题、描述和版本号。当你访问 Swagger UI 或 ReDoc 文档时，会看到这些信息。

## 10.5 添加文档说明：请求体、参数、响应格式等

FastAPI 允许你为路径操作提供更详细的文档说明，涵盖请求体、路径参数、查询参数、请求头等。你可以使用 Pydantic 模型和类型提示来描述这些内容。

### 示例：文档说明请求体、参数和响应格式

```python
from fastapi import FastAPI, Query, Body
from pydantic import BaseModel
from typing import Optional

app = FastAPI()

class Item(BaseModel):
    name: str
    description: Optional[str] = None
    price: float
    tax: Optional[float] = None

@app.post("/items/")
async def create_item(item: Item):
    return {"item": item}

@app.get("/items/")
async def get_items(q: Optional[str] = Query(None, min_length=3, max_length=50)):
    return {"query": q}
```

### 说明：

* **请求体（Request Body）**：`Item` 是一个 Pydantic 模型，它会自动生成文档，说明每个字段的类型和含义。
* **查询参数（Query Parameters）**：`q` 参数使用了 `Query` 来限制参数的最小长度和最大长度，这些信息会出现在自动生成的文档中。
* **响应格式**：FastAPI 会自动推断返回的响应格式，并将其显示在 Swagger UI 和 ReDoc 文档中。

在 Swagger UI 中，你会看到每个接口的详细描述，包括请求体、查询参数的说明、响应格式的返回示例等。

### 自定义响应模型

你也可以为响应指定模型，方便用户理解返回的内容。

```python
class ItemResponse(BaseModel):
    name: str
    price: float

@app.get("/items/{item_id}", response_model=ItemResponse)
async def read_item(item_id: int):
    return {"name": "item_name", "price": 100.0}
```

在这个示例中，我们使用了 `response_model` 来指定响应的模型，生成的文档将包括响应模型的详细字段。






# 11. 中间件与请求生命周期

在 FastAPI 中，中间件是用于处理请求和响应的一段代码，它位于请求和响应的生命周期中，可以用来执行一些预处理或后处理任务。常见的应用场景包括跨域资源共享（CORS）、日志记录、请求响应修改等。

## 11.1 什么是中间件？

中间件是处理请求和响应的一个环节，位于请求到达路由处理器之前或响应离开路由处理器之后。它通常用于执行一些额外的操作，如认证、日志、跨域资源共享（CORS）等。FastAPI 中的中间件是基于 Starlette 框架实现的。

中间件的工作流程如下：
1. 请求到达中间件
2. 中间件执行一些操作
3. 请求传递到路由处理器
4. 响应从路由返回
5. 响应通过中间件进行处理

## 11.2 中间件的作用与应用场景

中间件可以在请求和响应的生命周期中间接影响它们，常见的作用包括：

- **日志记录**：记录请求信息、响应状态等，便于调试和监控。
- **跨域请求处理**：允许跨域资源共享（CORS），使得不同域的请求能够访问 API。
- **请求/响应修改**：例如，可以在请求到达路由前修改请求数据，或者在响应返回客户端之前进行修改。

### 示例：自定义中间件

```python
from fastapi import FastAPI
from starlette.middleware.base import BaseHTTPMiddleware

app = FastAPI()

class CustomMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        # 在请求到达路由之前的操作
        print("Request received at:", request.url)
        
        response = await call_next(request)
        
        # 在响应返回之前的操作
        response.headers["X-Custom-Header"] = "This is a custom header"
        return response

# 添加自定义中间件
app.add_middleware(CustomMiddleware)

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```

在这个例子中，我们创建了一个自定义的中间件 `CustomMiddleware`，它在每个请求到达路由之前输出请求信息，并在每个响应返回时添加自定义的响应头。

## 11.3 使用中间件来处理跨域、日志记录、请求/响应修改

### 1. 跨域资源共享（CORS）

CORS 中间件允许不同域的客户端请求 API，这在前后端分离的应用中非常常见。你可以通过 `CORSMiddleware` 来配置允许的域名、方法和头部等。

#### 示例：使用 CORS 中间件

```python
from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

app = FastAPI()

# 配置允许跨域的域名
origins = [
    "http://localhost:3000",  # 允许本地开发环境访问
    "https://example.com",  # 允许外部域名访问
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # 允许的域名
    allow_credentials=True,
    allow_methods=["*"],  # 允许所有 HTTP 方法
    allow_headers=["*"],  # 允许所有 HTTP 头部
)

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```

在这个示例中，`CORSMiddleware` 中间件配置了哪些域名可以访问 API，这样就能够解决跨域问题。

### 2. 日志记录

通过自定义中间件，可以在每个请求和响应时记录日志，方便调试和监控。

#### 示例：请求日志记录

```python
import logging
from fastapi import FastAPI
from starlette.middleware.base import BaseHTTPMiddleware

# 配置日志记录
logging.basicConfig(level=logging.INFO)

app = FastAPI()

class LogMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        # 记录请求信息
        logging.info(f"Request URL: {request.url}")
        
        response = await call_next(request)
        
        # 记录响应信息
        logging.info(f"Response status code: {response.status_code}")
        
        return response

# 添加日志中间件
app.add_middleware(LogMiddleware)

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```

这个示例中，我们创建了一个 `LogMiddleware` 中间件，记录了每个请求的 URL 和响应的状态码。

### 3. 请求/响应修改

有时你可能需要在请求到达路由之前或响应返回之前对它们进行修改，例如修改请求数据或响应头。

#### 示例：修改请求和响应

```python
from fastapi import FastAPI
from starlette.middleware.base import BaseHTTPMiddleware

app = FastAPI()

class ModifyRequestResponseMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        # 修改请求头
        request.headers["X-Request-Modified"] = "true"
        
        response = await call_next(request)
        
        # 修改响应头
        response.headers["X-Response-Modified"] = "true"
        
        return response

app.add_middleware(ModifyRequestResponseMiddleware)

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```

在这个示例中，我们在中间件中修改了请求头和响应头，确保请求和响应中带有额外的信息。

## 11.4 常见中间件：CORS、GZip、请求日志

FastAPI 默认集成了一些常见的中间件，方便开发者快速配置和使用。

### 1. CORS 中间件

如前所述，`CORSMiddleware` 用于处理跨域请求。可以通过 `allow_origins`、`allow_methods` 等参数配置哪些域名可以访问。

### 2. GZip 压缩

FastAPI 还支持使用 `GZipMiddleware` 来对响应进行 GZip 压缩，减少数据传输量，提升性能。

#### 示例：启用 GZip 中间件

```python
from fastapi import FastAPI
from starlette.middleware.gzip import GZipMiddleware

app = FastAPI()

# 启用 GZip 压缩中间件
app.add_middleware(GZipMiddleware, minimum_size=1000)

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```

### 3. 请求日志

你可以自定义日志中间件来记录请求和响应，或者使用第三方中间件来实现复杂的日志记录功能。

#### 示例：第三方日志中间件

```python
from fastapi import FastAPI
from starlette.middleware.logging import LoggingMiddleware

app = FastAPI()

# 使用 Starlette 提供的 LoggingMiddleware
app.add_middleware(LoggingMiddleware)

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```

`LoggingMiddleware` 会自动记录请求和响应的详细信息，方便排查问题。






# 12. 模板渲染与静态文件

FastAPI 提供了对模板渲染和静态文件服务的支持，可以用于生成动态 HTML 页面和提供静态资源（如 CSS、JS 和图片）。常见的模板引擎是 Jinja2，它允许在服务器端渲染 HTML 页面，并将渲染后的页面返回给客户端。

## 12.1 使用 Jinja2 模板引擎

FastAPI 通过 `Jinja2` 模板引擎提供了强大的模板渲染功能。你需要安装 `jinja2` 库来支持模板渲染。

```bash
pip install jinja2
````

在 FastAPI 中，我们通过 `TemplateResponse` 来使用 Jinja2 模板引擎。

### 示例：基本的 Jinja2 模板渲染

```python
from fastapi import FastAPI
from fastapi.templating import Jinja2Templates
from starlette.requests import Request

app = FastAPI()

# 配置 Jinja2 模板目录
templates = Jinja2Templates(directory="templates")

@app.get("/hello/{name}")
async def read_item(request: Request, name: str):
    return templates.TemplateResponse("hello.html", {"request": request, "name": name})
```

在这个示例中，我们创建了一个 `/hello/{name}` 路径，渲染 `hello.html` 模板，并传递 `name` 变量。`request` 对象必须传递给模板渲染器，这是因为 Jinja2 模板引擎需要它来生成正确的 URL。

## 12.2 渲染 HTML 页面

在 `TemplateResponse` 中，我们可以通过传递字典的方式将数据传递给模板。模板渲染时，Jinja2 会自动替换模板中的变量。

### 示例：渲染 HTML 页面

首先，创建一个 `templates/hello.html` 模板文件，内容如下：

```html
<!DOCTYPE html>
<html>
<head>
    <title>Hello {{ name }}</title>
</head>
<body>
    <h1>Hello, {{ name }}!</h1>
</body>
</html>
```

当访问 `/hello/John` 时，FastAPI 会渲染该模板并显示 `Hello, John!`。

## 12.3 配置模板目录

在上面的示例中，我们使用了 `Jinja2Templates(directory="templates")` 来配置模板目录。FastAPI 会从指定的 `templates` 目录加载模板文件。

### 示例：多个模板目录

```python
templates = Jinja2Templates(directory="templates")
# 如果有多个目录，可以传递一个列表
templates = Jinja2Templates(directories=["templates", "other_templates"])
```

你可以根据需求配置多个目录来加载不同的模板文件。

## 12.4 静态文件服务（CSS、JS、图片）

FastAPI 支持静态文件服务，常用于提供 CSS、JavaScript 和图片等资源。通过 `StaticFiles` 中间件，可以方便地为应用提供静态文件。

### 示例：提供静态文件

首先，创建一个 `static` 目录并放置静态文件，例如 `static/css/styles.css` 和 `static/js/app.js`。

然后在 FastAPI 中配置静态文件服务：

```python
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

app = FastAPI()

# 提供静态文件服务
app.mount("/static", StaticFiles(directory="static"), name="static")

@app.get("/")
async def main():
    return {"message": "Visit /static to access static files"}
```

在这个例子中，`app.mount("/static", StaticFiles(directory="static"), name="static")` 将 `static` 目录中的文件映射到 `/static` 路径。你可以通过访问 `http://127.0.0.1:8000/static/css/styles.css` 来查看 CSS 文件。

## 12.5 使用 `StaticFiles` 提供静态资源

`StaticFiles` 允许你为应用提供静态资源。可以将其映射到任何路径，通常静态资源存放在 `static` 目录中，并且可以通过 HTTP 请求直接访问。

### 示例：为静态文件添加路径前缀

你可以将静态文件服务映射到一个自定义的路径，如 `/assets`。

```python
app.mount("/assets", StaticFiles(directory="static"), name="assets")
```

在这个示例中，`/assets` 路径将映射到 `static` 目录。例如，访问 `http://127.0.0.1:8000/assets/css/styles.css` 将加载 `static/css/styles.css` 文件。

### 使用静态文件与模板结合

你可以在 Jinja2 模板中引用静态文件，例如 CSS 和 JavaScript 文件。

#### 示例：在模板中引用静态文件

```html
<!DOCTYPE html>
<html>
<head>
    <title>Hello {{ name }}</title>
    <link rel="stylesheet" href="/static/css/styles.css">
</head>
<body>
    <h1>Hello, {{ name }}!</h1>
    <script src="/static/js/app.js"></script>
</body>
</html>
```

通过引用静态资源，你可以轻松地在动态生成的 HTML 页面中加载 CSS 和 JavaScript 文件。






# 13. 任务队列与后台任务

在 web 开发中，许多任务可能需要在后台异步执行，例如发送电子邮件、处理文件上传、生成报告等。FastAPI 提供了 `BackgroundTasks` 类来支持后台任务的执行。此外，还可以与 Redis、Celery 等第三方库集成，实现更强大的任务队列管理。

## 13.1 使用 `BackgroundTasks` 处理后台任务

FastAPI 提供了 `BackgroundTasks` 类，可以将任务放入后台处理，而不阻塞主线程。这使得 API 请求可以快速响应，而任务可以异步执行。

### 示例：使用 `BackgroundTasks` 发送邮件

```python
from fastapi import FastAPI, BackgroundTasks
from time import sleep

app = FastAPI()

def send_email(email: str):
    sleep(5)  # 模拟发送电子邮件的延迟
    print(f"Email sent to {email}")

@app.post("/send-email/")
async def send_email_task(background_tasks: BackgroundTasks, email: str):
    background_tasks.add_task(send_email, email)
    return {"message": "Email is being sent in the background"}
```

在这个示例中，`send_email` 函数模拟发送电子邮件的过程。在 `/send-email/` 路径的 POST 请求中，我们使用 `BackgroundTasks.add_task` 将 `send_email` 任务添加到后台，并在响应中返回一个消息，告诉用户电子邮件正在发送中。

## 13.2 发送电子邮件、文件生成等异步任务

后台任务非常适合执行一些耗时的操作，比如发送电子邮件、生成报告文件、数据导出等。这些任务会被推送到后台，不会阻塞主线程的工作。

### 示例：发送电子邮件和生成文件

```python
from fastapi import FastAPI, BackgroundTasks
from time import sleep

app = FastAPI()

# 模拟发送电子邮件的任务
def send_email(email: str):
    sleep(5)
    print(f"Email sent to {email}")

# 模拟生成文件的任务
def generate_file(filename: str):
    sleep(3)
    print(f"File {filename} has been generated!")

@app.post("/process-task/")
async def process_task(background_tasks: BackgroundTasks, email: str, filename: str):
    background_tasks.add_task(send_email, email)
    background_tasks.add_task(generate_file, filename)
    return {"message": "Tasks are being processed in the background"}
```

在这个示例中，我们通过后台任务发送电子邮件并生成一个文件。`BackgroundTasks.add_task` 用来添加这两个任务，这些任务将在后台并行执行。

## 13.3 使用 Redis、Celery 等第三方库进行任务队列管理

对于更复杂的任务管理，尤其是当任务量较大或者需要可靠的任务队列管理时，可以使用第三方库，如 Redis 和 Celery。

### 示例：使用 Redis 和 Celery 进行任务队列管理

首先，你需要安装 Celery 和 Redis 库：

```bash
pip install celery[redis] fastapi uvicorn
```

然后，你可以配置 Celery 以使用 Redis 作为消息中间件，并将任务推送到队列中。

#### 创建 Celery 配置文件 `celery_worker.py`

```python
from celery import Celery

# 配置 Celery 使用 Redis
app = Celery("worker", broker="redis://localhost:6379/0")

@app.task
def send_email(email: str):
    print(f"Email sent to {email}")
```

#### 创建 FastAPI 应用 `main.py`

```python
from fastapi import FastAPI
from celery_worker import send_email
from pydantic import BaseModel

app = FastAPI()

class EmailRequest(BaseModel):
    email: str

@app.post("/send-email-celery/")
async def send_email_task(request: EmailRequest):
    # 使用 Celery 发送任务到队列
    send_email.apply_async(args=[request.email])
    return {"message": "Email task has been added to the queue"}
```

在这个示例中，FastAPI 使用 Celery 将 `send_email` 任务添加到 Redis 队列中。任务会被 Celery 工作者从队列中取出并处理。你需要确保 Redis 服务正在运行，并且 Celery 工作者已启动。

### 启动 Celery 工作者

在命令行中启动 Celery 工作者：

```bash
celery -A celery_worker.app worker --loglevel=info
```

### 启动 FastAPI 应用

在另一个终端窗口中，启动 FastAPI 应用：

```bash
uvicorn main:app --reload
```

#### 测试 Celery 任务

你可以通过发送 POST 请求到 `/send-email-celery/` 来将任务添加到队列，Celery 工作者会处理这个任务并发送电子邮件。

### Celery 优势

* **任务重试**：Celery 支持自动重试失败的任务。
* **任务结果**：Celery 可以存储任务的结果，并允许查询任务的状态。
* **任务调度**：Celery 支持定时任务调度。

## 总结

* 使用 `BackgroundTasks` 可以轻松地将一些简单的任务放到后台执行，适用于不需要高可靠性的场景。
* 对于复杂的任务队列管理，可以使用 Celery 和 Redis 实现任务的异步处理和队列管理，支持任务重试、定时任务等高级功能。
* 无论是使用 FastAPI 提供的 `BackgroundTasks`，还是集成 Celery，后台任务的使用都能极大提升系统的性能和用户体验。








# 14. 数据库支持

FastAPI 支持多种数据库的集成，包括关系型数据库（如 PostgreSQL、MySQL）和 NoSQL 数据库（如 MongoDB）。在 FastAPI 中，你可以使用 ORM（对象关系映射）来简化数据库操作，常见的 ORM 包括 SQLAlchemy、Tortoise ORM 和 Databases。同时，FastAPI 还支持异步数据库操作，提高了性能。

## 14.1 与关系型数据库交互：SQLAlchemy、Tortoise ORM、Databases

### 使用 SQLAlchemy

SQLAlchemy 是一个广泛使用的关系型数据库 ORM，它提供了强大的功能来处理数据库连接和模型映射。

首先，安装 SQLAlchemy 和数据库驱动：

```bash
pip install sqlalchemy databases psycopg2
```

#### 示例：SQLAlchemy 配置与使用

```python
from fastapi import FastAPI, Depends
from sqlalchemy import Column, Integer, String, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.future import select

DATABASE_URL = "postgresql+psycopg2://user:password@localhost/mydatabase"

engine = create_engine(DATABASE_URL, echo=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    email = Column(String, unique=True, index=True)

# 初始化数据库
Base.metadata.create_all(bind=engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/create-user/")
async def create_user(name: str, email: str, db: Session = Depends(get_db)):
    db_user = User(name=name, email=email)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user
```

### 使用 Tortoise ORM

Tortoise ORM 是一个用于 Python 的异步 ORM，支持异步数据库操作。它支持 PostgreSQL、MySQL 和 SQLite 等数据库。

首先，安装 Tortoise ORM：

```bash
pip install tortoise-orm[postgres]
```

#### 示例：Tortoise ORM 配置与使用

```python
from fastapi import FastAPI
from tortoise import Tortoise, fields
from tortoise.models import Model

app = FastAPI()

class User(Model):
    id = fields.IntField(pk=True)
    name = fields.CharField(max_length=50)
    email = fields.CharField(max_length=100, unique=True)

    class Meta:
        table = "users"

@app.on_event("startup")
async def startup():
    # 初始化数据库
    await Tortoise.init(
        db_url='postgres://user:password@localhost:5432/mydatabase',
        modules={'models': ['__main__']}
    )
    await Tortoise.generate_schemas()

@app.post("/create-user/")
async def create_user(name: str, email: str):
    user = await User.create(name=name, email=email)
    return user
```

## 14.2 数据库模型定义和迁移

在数据库开发中，模型定义是核心，通常需要定义数据库表和字段。迁移是指对数据库结构进行更改（如新增字段、修改表结构）。常见的迁移工具有 Alembic（用于 SQLAlchemy）和 Tortoise 自带的迁移工具。

### 使用 Alembic 进行数据库迁移

#### 安装 Alembic

```bash
pip install alembic
```

#### 初始化 Alembic 配置

```bash
alembic init alembic
```

#### 配置 Alembic

修改 `alembic.ini` 中的数据库连接配置，指向你的数据库。

#### 生成迁移文件

```bash
alembic revision --autogenerate -m "Add new column"
```

#### 应用迁移

```bash
alembic upgrade head
```

### 使用 Tortoise ORM 进行数据库迁移

Tortoise ORM 也支持数据库迁移，但它的迁移功能相对简单。可以通过 Tortoise 提供的 `aerich` 工具进行迁移管理。

#### 安装 aerich

```bash
pip install aerich
```

#### 初始化迁移配置

```bash
aerich init -t app.models.Tortoise
```

#### 创建迁移文件

```bash
aerich migrate
```

#### 应用迁移

```bash
aerich upgrade
```

## 14.3 使用异步 ORM 进行数据库操作

FastAPI 提供了异步支持，因此你可以在数据库操作中使用异步 ORM，以提高性能，尤其是在高并发的情况下。

### 示例：使用异步数据库操作

```python
from fastapi import FastAPI, Depends
from sqlalchemy import Column, Integer, String, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL = "postgresql+asyncpg://user:password@localhost/mydatabase"

# 异步引擎
engine = create_async_engine(DATABASE_URL, echo=True)
SessionLocal = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    email = Column(String, unique=True, index=True)

app = FastAPI()

async def get_db():
    async with SessionLocal() as db:
        yield db

@app.post("/create-user/")
async def create_user(name: str, email: str, db: AsyncSession = Depends(get_db)):
    db_user = User(name=name, email=email)
    db.add(db_user)
    await db.commit()
    await db.refresh(db_user)
    return db_user
```

### 异步数据库操作的优势

* **更高的并发**：异步数据库操作不会阻塞请求处理线程，能够有效提高应用的并发能力。
* **更好的性能**：在高负载时，异步操作能够减少 I/O 阻塞，提升响应速度。

## 14.4 与 NoSQL 数据库（如 MongoDB）的集成

除了关系型数据库，FastAPI 也可以与 NoSQL 数据库（如 MongoDB）进行集成。

### 示例：使用 MongoDB 和 Motor

Motor 是 MongoDB 官方提供的异步驱动程序，支持异步 I/O 操作。

#### 安装 Motor

```bash
pip install motor
```

#### 示例：MongoDB 集成

```python
from fastapi import FastAPI
from pydantic import BaseModel
import motor.motor_asyncio

app = FastAPI()

client = motor.motor_asyncio.AsyncIOMotorClient('mongodb://localhost:27017')
db = client.test_db
collection = db.users

class User(BaseModel):
    name: str
    email: str

@app.post("/create-user/")
async def create_user(user: User):
    result = await collection.insert_one(user.dict())
    return {"id": str(result.inserted_id)}

@app.get("/get-user/{user_id}")
async def get_user(user_id: str):
    user = await collection.find_one({"_id": user_id})
    return user
```

在这个示例中，我们使用 Motor 驱动连接 MongoDB，并实现了插入和查询用户的功能。





# 15. CORS（跨域资源共享）

CORS（Cross-Origin Resource Sharing，跨域资源共享）是一种浏览器机制，它允许或限制不同来源（域名、协议或端口）之间的资源共享。在开发前端与后端分离的应用时，CORS 配置尤为重要，因为默认情况下，浏览器会阻止不同域之间的资源访问。

FastAPI 通过 `CORSMiddleware` 提供了对 CORS 的支持，允许开发者灵活配置跨域请求的策略。

## 15.1 设置允许的来源、请求方法和头

CORS 设置涉及到以下几个关键点：

- **允许的来源（Origins）**：可以指定哪些域名可以访问你的 API。
- **允许的请求方法（Methods）**：例如 `GET`, `POST`, `PUT`, `DELETE` 等。
- **允许的请求头（Headers）**：指定哪些请求头可以用于跨域请求。

### 示例：配置 CORS 允许特定来源

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# 允许跨域请求的域名
origins = [
    "http://example.com",
    "https://another-domain.com",
]

# 配置 CORS 中间件
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # 允许的来源
    allow_credentials=True,
    allow_methods=["GET", "POST"],  # 允许的方法
    allow_headers=["X-Custom-Header"],  # 允许的请求头
)

@app.get("/")
async def read_root():
    return {"message": "Hello, World!"}
```

在这个示例中，`CORSMiddleware` 被用来配置跨域请求的策略。我们设置了允许来自 `http://example.com` 和 `https://another-domain.com` 的请求，且只允许 `GET` 和 `POST` 请求，允许请求中携带 `X-Custom-Header` 请求头。

## 15.2 使用 `CORSMiddleware` 配置 CORS

`CORSMiddleware` 是 FastAPI 提供的中间件，可以帮助你轻松配置跨域请求的策略。除了上面提到的来源、方法和头设置，`CORSMiddleware` 还提供了一些其他选项，例如 `allow_credentials`（是否允许携带认证信息）。

### 示例：允许所有来源和请求方法

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# 允许所有域名进行跨域请求
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 允许所有来源
    allow_credentials=True,
    allow_methods=["*"],  # 允许所有请求方法
    allow_headers=["*"],  # 允许所有请求头
)

@app.get("/")
async def read_root():
    return {"message": "This is a CORS-enabled API."}
```

在这个示例中，我们通过 `allow_origins=["*"]` 允许所有来源进行跨域请求，`allow_methods=["*"]` 和 `allow_headers=["*"]` 则允许所有的请求方法和请求头。

## 15.3 允许所有域还是限制特定域

根据你的需求，可以选择以下两种策略：

### 1. 允许所有域

如果你的 API 是公共的，且希望允许任何网站访问，可以使用 `allow_origins=["*"]` 配置。这会允许所有来源的跨域请求。

```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 允许所有来源
    allow_credentials=True,
    allow_methods=["*"],  # 允许所有请求方法
    allow_headers=["*"],  # 允许所有请求头
)
```

这种配置非常适合公共 API，尤其是当你没有特别的安全需求时。

### 2. 限制特定域

如果你只希望特定的域能够访问 API，可以明确指定允许的来源。例如，限制只有 `http://example.com` 和 `https://another-domain.com` 这两个域名能够访问 API。

```python
origins = [
    "http://example.com",
    "https://another-domain.com",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # 只允许这两个域
    allow_credentials=True,
    allow_methods=["GET", "POST"],  # 只允许 GET 和 POST 请求方法
    allow_headers=["X-Custom-Header"],  # 只允许指定请求头
)
```

这种方式可以增强 API 的安全性，确保只有受信任的来源能够发起请求。

## 总结

* **CORS** 是一种跨域请求机制，允许你控制哪些域可以访问你的 API。
* 使用 FastAPI 的 `CORSMiddleware` 中间件，你可以灵活地配置跨域请求的策略。
* 你可以选择允许所有域访问，或者限制特定域访问，根据实际需求进行配置。



以下是完善后的Markdown内容，包含了代码演示部分，您可以直接复制使用：


# 16. 性能与优化

## 16.1 FastAPI 性能优势（比 Django、Flask 更快）

FastAPI 基于 Starlette 和 Pydantic 构建，具有显著的性能优势：

- 使用 ASGI（异步服务器网关接口）而非 WSGI
- 基于 Python 的类型提示进行数据验证和序列化
- 自动化的 OpenAPI 和 JSON Schema 文档生成

**性能对比示例**（基于 TechEmpower 基准测试）：
- FastAPI 接近 NodeJS 和 Go 的性能
- 比 Django 快 2-3 倍
- 比 Flask 快 1.5-2 倍（特别是在异步端点上）

## 16.2 异步编程与 I/O 密集型任务的优势

FastAPI 原生支持异步编程，特别适合 I/O 密集型任务（如数据库查询、API 调用等）。

**异步端点示例**：
```python
from fastapi import FastAPI
import httpx

app = FastAPI()

@app.get("/external-api/")
async def fetch_external_data():
    async with httpx.AsyncClient() as client:
        response = await client.get("https://jsonplaceholder.typicode.com/todos/1")
        return response.json()
```

**同步 vs 异步性能对比**：
- 同步：每个请求必须等待前一个完成
- 异步：单个 worker 可以同时处理多个请求（使用事件循环）

## 16.3 使用缓存优化响应时间

缓存可以显著减少重复计算和数据库查询：

**Redis 缓存示例**：
```python
from fastapi import FastAPI
from fastapi_cache import FastAPICache
from fastapi_cache.backends.redis import RedisBackend
from fastapi_cache.decorator import cache
import redis

app = FastAPI()

@app.on_event("startup")
async def startup():
    redis_client = redis.from_url("redis://localhost")
    FastAPICache.init(RedisBackend(redis_client), prefix="fastapi-cache")

@app.get("/expensive-operation/")
@cache(expire=60)  # 缓存60秒
async def expensive_operation():
    # 模拟耗时操作
    import time
    time.sleep(5)
    return {"result": "This was expensive to compute"}
```

## 16.4 性能调优：查询优化、异步数据库操作、负载均衡

### 查询优化
- 使用 `selectinload` 或 `joinedload` 避免 N+1 查询问题（SQLAlchemy）
- 只查询需要的字段（避免 `SELECT *`）

**SQLAlchemy 优化示例**：
```python
from sqlalchemy.orm import selectinload

# 不好的方式（N+1查询）
users = session.query(User).all()
for user in users:
    print(user.addresses)  # 每次访问都会产生新查询

# 好的方式（单次查询）
users = session.query(User).options(selectinload(User.addresses)).all()
for user in users:
    print(user.addresses)  # 已预加载
```

### 异步数据库操作
使用 `asyncpg` (PostgreSQL) 或 `aiomysql` (MySQL) 等异步驱动：

**异步 SQLAlchemy 示例**：
```python
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession

engine = create_async_engine("postgresql+asyncpg://user:password@localhost/dbname")

async def get_users():
    async with AsyncSession(engine) as session:
        result = await session.execute(select(User))
        return result.scalars().all()
```

### 负载均衡
- 使用 Nginx 或 Traefik 作为反向代理
- 部署多个 FastAPI 实例（容器化或进程管理）
- 结合 Gunicorn + Uvicorn workers

**Gunicorn 配置示例**（`gunicorn.conf.py`）：
```python
workers = 4  # 通常设置为 CPU 核心数 * 2 + 1
worker_class = "uvicorn.workers.UvicornWorker"
bind = "0.0.0.0:8000"
```

**Docker Compose 示例**（多实例）：
```yaml
services:
  web:
    image: my-fastapi-app
    deploy:
      replicas: 4
    ports:
      - "8000:8000"
```


# 17. 测试与文档

* 17.1 使用 FastAPI 自带的测试客户端进行单元测试
* 17.2 测试 API 路由与视图函数
* 17.3 使用 `pytest` 与 `unittest` 进行测试
* 17.4 编写与生成测试报告
* 17.5 文档生成工具：Swagger UI、ReDoc

# 18. 部署与容器化

* 18.1 使用 Uvicorn 或 Gunicorn 进行生产环境部署
* 18.2 容器化：Docker 配置 FastAPI 应用
* 18.3 与 Nginx 配合使用：负载均衡、反向代理
* 18.4 部署在云平台（如 AWS、Azure）


# 19. 其他高级功能

FastAPI 提供了许多高级功能，帮助开发者实现实时通信、GraphQL 集成、Webhooks 等现代化的服务架构。此外，FastAPI 还支持 API 版本管理与路由分离，提升 API 的可维护性和扩展性。

## 19.1 WebSockets：实时双向通信

WebSockets 是一种通信协议，允许客户端与服务器之间建立持久连接，实现双向通信。这对于实时应用（如聊天、在线游戏等）非常有用。FastAPI 提供了对 WebSockets 的原生支持，方便实现实时通信。

### 示例：使用 WebSocket 进行聊天

```python
from fastapi import FastAPI, WebSocket, WebSocketDisconnect

app = FastAPI()

@app.websocket("/ws/chat/")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            msg = await websocket.receive_text()
            await websocket.send_text(f"Message received: {msg}")
    except WebSocketDisconnect:
        print("Client disconnected")
```

在这个示例中，`/ws/chat/` 路径接受 WebSocket 连接，客户端可以发送消息，服务器将回应同样的消息。`websocket.receive_text()` 用来接收文本消息，`websocket.send_text()` 用来发送响应。

### 客户端 WebSocket 示例（Flutter）

在 Flutter 客户端中，你可以使用 `web_socket_channel` 库来实现 WebSocket 客户端连接。以下是一个简单的示例，展示如何与 FastAPI 后端进行 WebSocket 通信。

首先，在 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  web_socket_channel: ^2.1.0
```

然后，在 Flutter 中实现 WebSocket 客户端：

```dart
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebSocket Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebSocketChat(),
    );
  }
}

class WebSocketChat extends StatefulWidget {
  @override
  _WebSocketChatState createState() => _WebSocketChatState();
}

class _WebSocketChatState extends State<WebSocketChat> {
  late final WebSocketChannel channel;
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    // 连接到 FastAPI WebSocket 服务
    channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:8000/ws/chat/'),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _sendMessage() {
    final message = _controller.text;
    if (message.isNotEmpty) {
      channel.sink.add(message);  // 发送消息到服务器
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Send a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          // 监听来自服务器的新消息
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _messages.add(snapshot.data.toString());  // 将新消息添加到列表
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
```

### 说明：

1. **WebSocketChannel**：使用 `web_socket_channel` 库来实现 WebSocket 客户端连接，向服务器发送消息，并监听来自服务器的消息。
2. **TextField 和 IconButton**：用来让用户输入消息，并通过 WebSocket 发送到服务器。
3. **StreamBuilder**：用于监听从 WebSocket 服务器发送的消息，并将其添加到聊天记录中。

### 运行：

1. 启动 FastAPI 服务器：

   ```bash
   uvicorn main:app --reload
   ```

2. 在 Flutter 中运行应用，您将能够看到实时的 WebSocket 聊天功能。

### 总结：

这个示例展示了如何使用 FastAPI 后端和 Flutter 前端通过 WebSocket 实现实时双向通信。FastAPI 提供了 WebSocket 的原生支持，Flutter 使用 `web_socket_channel` 库来建立 WebSocket 连接和发送/接收消息。


## 19.2 GraphQL 集成

GraphQL 是一种查询语言，可以通过单一的端点进行灵活的查询和数据操作。FastAPI 通过 `graphene` 库支持 GraphQL 的集成。

### 安装 Graphene

```bash
pip install graphene
```

### 示例：使用 FastAPI 和 GraphQL

```python
from fastapi import FastAPI
from graphene import ObjectType, String, Schema
from fastapi.graphql import GraphQLApp

app = FastAPI()

class Query(ObjectType):
    hello = String(name=String(default_value="stranger"))

    def resolve_hello(self, info, name):
        return f"Hello, {name}!"

schema = Schema(query=Query)

app.add_route("/graphql", GraphQLApp(schema=schema))
```

在这个示例中，GraphQL 查询接受一个 `name` 参数并返回一个问候语。通过 `/graphql` 路径，客户端可以执行 GraphQL 查询。

### 客户端 GraphQL 查询示例

```graphql
query {
  hello(name: "FastAPI")
}
```

## 19.3 Webhooks 与事件驱动架构

Webhooks 是一种通过 HTTP 请求回调事件的机制。当某个事件发生时，服务器会向预先指定的 URL 发送 HTTP 请求。事件驱动架构通过触发事件并处理事件来实现系统间的解耦。

### 示例：实现 Webhook 接收器

```python
from fastapi import FastAPI, Request

app = FastAPI()

@app.post("/webhook/")
async def receive_webhook(request: Request):
    payload = await request.json()
    print("Received webhook:", payload)
    return {"status": "success"}
```

在这个示例中，我们创建了一个接收 Webhook 的端点 `/webhook/`。当有事件触发时，外部系统可以通过 HTTP POST 请求将事件数据发送到这个端点，FastAPI 将处理并打印该数据。

### Webhook 发送示例（外部系统）

```bash
curl -X POST http://localhost:8000/webhook/ -H "Content-Type: application/json" -d '{"event": "user_signup", "data": {"user_id": 123}}'
```

## 19.4 API 版本管理与路由分离

随着项目的发展，API 版本管理和路由分离变得非常重要。FastAPI 提供了路由分离和版本控制的机制，方便你管理不同版本的 API。

### 示例：API 版本管理

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/v1/items/")
async def get_items_v1():
    return {"version": "v1", "items": ["item1", "item2"]}

@app.get("/v2/items/")
async def get_items_v2():
    return {"version": "v2", "items": ["item1", "item2", "item3"]}
```

在这个示例中，`/v1/items/` 和 `/v2/items/` 分别表示 API 的不同版本。在路由路径中明确指定版本号，有助于版本控制和避免后期冲突。

### 路由分离

FastAPI 允许你将不同的功能模块放到不同的路由文件中，通过 `APIRouter` 进行路由管理，从而实现代码结构的清晰和路由的分离。

#### 示例：使用 `APIRouter` 进行路由分离

```python
from fastapi import FastAPI, APIRouter

app = FastAPI()

v1_router = APIRouter()
v2_router = APIRouter()

@v1_router.get("/items/")
async def get_items_v1():
    return {"version": "v1", "items": ["item1", "item2"]}

@v2_router.get("/items/")
async def get_items_v2():
    return {"version": "v2", "items": ["item1", "item2", "item3"]}

app.include_router(v1_router, prefix="/v1")
app.include_router(v2_router, prefix="/v2")
```

在这个示例中，我们通过 `APIRouter` 分别定义了 `v1_router` 和 `v2_router`，然后将它们分别通过 `include_router` 加入到 FastAPI 应用中。这样，我们可以很清晰地管理不同版本的路由。

## 总结

* **WebSockets**：用于实现实时双向通信，适用于即时聊天、在线游戏等应用场景。
* **GraphQL**：提供灵活的 API 查询能力，客户端可以定制请求的数据字段，减少请求和响应的大小。
* **Webhooks**：允许服务器向外部系统推送事件，支持事件驱动架构，提升系统的解耦性。
* **API 版本管理与路由分离**：支持通过路径指定 API 版本，和使用 `APIRouter` 分离不同功能模块的路由，帮助管理大型项目中的 API。





