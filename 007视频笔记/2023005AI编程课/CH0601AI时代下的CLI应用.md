## CH0601AI时代下的CLI应用

[‍⁢​‬​⁣⁣‌​CH06 AI 时代下的 CLI 应用课程示范代码 - 飞书云文档](https://anrenmind.feishu.cn/wiki/YuDWwecpAizfCHkkVcwc0Kl3n7b)

### 课件

如何编写 AI 时代下的 CLI 应用，我们需要：

1、理解 WebAPI 和 HTTP 协议。

2、掌握 CLI 的 Web API 实操，并且编写一个 Web API 的 CLI 应用。

在第六讲中，我们将一起学习：

1、WebAPI 的概念。

2、HTTP 协议的构成。

3、CLI 的 Web API 实操。

01 API 与 Web API

API (Application Programming Interface) 应用编程接口，是程序提供的给其他程序调用它功能的方式。

Web API 是一种应用编程接口 (API) , 它允许不同的软件应用或系统通过网络 (通常是 HTTP 协议) 来通信、交换数据和功能。

02 Web API 是如何传输数据的

HTTP 协议，作为应用层协议，它离我们用户最近，也是我们访问网页的基础。

HTTP 协议（HyperText Transfer Protocol）是超文本传输协议。顾名思义，收发的是文本信息。

更多信息请参考:

[HTTP | MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTTP)

03 HTTP 请求方法

HTTP 协议：HTTP 请求方法。

HTTP 请求方法：表明要对给定资源执行的操作。

Post

Delete

Get

Put

HTTP header: 用于传递关于资源的附加信息或关于消息本身的元数据。

通用头部。比如 Date，消息发送的日期和时间。

请求头部。比如：Host，请求资源的主机和端口号。

响应头部。比如 Server，描述响应的服务器软件。

实体头部。比如 Content-Type: 实体的类型。

04 HTTP 响应状态码：标识响应的结果状态。

1XX: 已被接受，继续处理。比如: 100（continue）。

2XX 成功处理。比如：200（ok）。

5XX 服务器错误。比如：501（服务器不支持）。

4XX 客户端造成的错误。比如: 404（Not Found）。

3XX 重定向。比如: 305（Found）。

05 RESTful 接口规范

RESTful 是一种基于 HTTP 协议，实现平台独立、可扩展的 Web 服务接口规范。

基于 HTTP 协议：使用标准的 HTTP 方法 (如 GET、POST、PUT、DELETE) 对应 CRUD 操作。

平台独立性：不管 API 的内部实现方式如何，任何客户端都应该能够调用该 API。

可扩展性： Web API 在不影响客户端应用程序的情况下改进和添加功能。

06 JSON 接口数据格式规范

JSON (JavaScript Object Notation) 是一种常用的轻量级的数据交换格式规范。当我们谈论「JSON 数据」时，我们通常指的是符合 JSON 格式规范的字符串。

支持数字，字符串，布尔值，数组，对象，null。

所有的键和字符串的值必须用双引号包围。

不支持注释。

07 Requests 库

Requests 是一个 Python 专门发送和处理 HTTP 请求的第三方库。

更多信息请参考: https://docs.python-requests.org/en/latest/index.html

[Requests: HTTP for Humans™ — Requests 2.31.0 documentation](https://docs.python-requests.org/en/latest/index.html)

实操：调用智谱 API 生成书籍推广文案 [图片]

1、调用智谱的 API 获取结果。

怎么获取？

2、把结果解析成我们需要的格式。

怎么解析？

### 实操遇到的问题

1、调用智普 api 时总是报错。

调用智普大模型接口时报错信息如下：

{
  File "practice_zhipuai_demo.py", line 80, in <module>
    zhipuai_package_demo(api_key)
  File "practice_zhipuai_demo.py", line 23, in zhipuai_package_demo
    {"role": "user", "content": "你都可以做些什么事"},
  File "/Users/Daglas/miniconda3/envs/kaizhi/lib/python3.7/site-packages/zhipuai/model_api/api.py", line 35, in sse_invoke
    data = stream(url, cls._generate_token(), kwargs, zhipuai.api_timeout_seconds)
  File "/Users/Daglas/miniconda3/envs/kaizhi/lib/python3.7/site-packages/zhipuai/model_api/api.py", line 56, in _generate_token
    return jwt_token.generate_token(zhipuai.api_key)
  File "/Users/Daglas/miniconda3/envs/kaizhi/lib/python3.7/site-packages/cachetools/__init__.py", line 702, in wrapper
    v = func(*args, **kwargs)
  File "/Users/Daglas/miniconda3/envs/kaizhi/lib/python3.7/site-packages/zhipuai/utils/jwt_token.py", line 25, in generate_token
    return jwt.encode(
AttributeError: module 'jwt' has no attribute 'encode'
}
我的代码如下：
{
import zhipuai

zhipuai.api_key = "your api key"
response = zhipuai.model_api.sse_invoke(
    model="chatglm_turbo",
    prompt=[
        {"role": "user", "content": "你好"},
        {"role": "assistant", "content": "我是人工智能助手"},
        {"role": "user", "content": "你叫什么名字"},
        {"role": "assistant", "content": "我叫chatGLM"},
        {"role": "user", "content": "你都可以做些什么事"},
    ]
)
}
