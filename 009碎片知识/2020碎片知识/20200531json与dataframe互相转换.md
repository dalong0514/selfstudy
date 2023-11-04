# json 与 dataframe 的互相转换

[python 中基于 pandas 模块：json 与 dataframe 的互相转换](https://blog.csdn.net/qq_41780234/article/details/84990551)

[pandas.read_json — pandas 1.0.3 documentation](https://pandas.pydata.org/docs/reference/api/pandas.read_json.html#pandas.read_json)

[pandas.DataFrame.to_json — pandas 1.0.3 documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_json.html?highlight=to_json#pandas.DataFrame.to_json)

## 01. 消化

1、对于简单的 json 形式。所谓的简单的 json 格式，就是将字典形式的文件，直接输出成 dataframe 形式的文件。

利用 pandas 自带的 read_json 直接解析字符串。

```py
import pandas as pd
df = pd.read_json("test.json",encoding="utf-8", orient='records')
print(df)
```

利用 json 库 loads 方法和 pandas 库中的 json_normalize 方法。

```py
import json 
from pandas.io.json import json_normalize
data=open("test.json",encoding="utf-8").read()
data_list = json.loads(data)
df = json_normalize(data_list)
print(df)
```

2、对于稍微复杂一些的 json 进行处理。复杂的一些的 json 格式的文件，例子如下，我们想要得到的数据是张三兄弟的数据，同样先写入 json 文件：

```py
obj = """
{"姓名": "张三",
 "住处": ["天朝", "岛国", "万恶的资本主义日不落帝国"],
 "宠物": null,
 "兄弟": [{"姓名": "李四", "年龄": 25, "宠物": "汪星人"},
              {"姓名": "王五", "年龄": 23, "宠物": "喵星人"}]
}"""
with open("test1.json","w",encoding="utf-8") as f:
    f.write(obj)
```

利用 json 的 loads 和 pandas 的 DataFrame。

```py
import json 
import pandas as pd
with open("test1.json","r",encoding="utf-8") as f:
    info=f.read()
    data_list = json.loads(info)
    brother_info = data_list["兄弟"]
    df=pd.DataFrame(brother_info)
#     print(type(brother_info))
#     print(brother_info)
#     print(brother_info)
```

利用 json 的 loads 和 pandas 的 json_normalize。

```py
from pandas.io.json import json_normalize
import json 
with open("test1.json","r",encoding="utf-8") as f:
    info=f.read()
    data_list = json.loads(info)
    brother_info = data_list["兄弟"]
    df = json_normalize(brother_info)
    print(df)
```

利用 json 的 loads 和 pandas 的 read_json。

```py
import json 
import pandas as pd
with open("test1.json","r",encoding="utf-8") as f:
    info=f.read()
    data_list = json.loads(info)
    brother_info = data_list["兄弟"]
    json_data=json.dumps(brother_info)
    df=pd.read_json(json_data,orient="records")
    print(df)
```

总结：

在以上的例子中，可以发现在进行简单的格式转换的时候，可以使用 pandas 库的 read_json 进行处理，在进行复杂的格式转换的时候就要配合 json 库进行使用。无论是什么样的 json 数据，基本思路都是现将 json 文件读取进来，然后选择想要转换的数据，或是列表或是字典，然后再进行转换。

在这里重点介绍一下两个函数 read\_json 方法和 json\_normalize 方法。在使用时，要注意 read\_json 方法中 orient 参数的选择，同时 json\_normalize 可以将传入的列表、字典形式的 json 格式数据直接转换成 dataframe。

DataFrame 转为 json。通常情况下，我们使用的都是 pandas 中的 to\_json() 函数，可以通过设置 orient 参数来转换成为我们想要的 json 格式，orient 函数有以下几个参数："split", "records", "index", "columns", "values"。

## 02. 自由发挥

### df.to_json()

在 excel 里就做一个字段 explosive_mixture，excel 读取成 dataframe 格式，直接用 df.to_json() 转成的 json 格式是：

```js
{
    "explosive_mixture": {
        "0": "the first row data",
        "1": "the second row data",
        ...
    }
}
```

### df.to_json(orient='split')

```
‘split’ : dict like {‘index’ -> [index], ‘columns’ -> [columns], ‘data’ -> [values]}
```

实例：

```json
{
"columns":["combustion_mixture"],
"index":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],
"data":[["\\u6eb4\\u4e0e\\u78f7\\u3001\\u950c\\u7c89\\u3001\\u9541\\u7c89"],["\\u6d53\\u786b\\u9178\\u3001\\u6d53\\u785d\\u9178\\u4e0e\\u6728\\u6750\\u3001\\u7ec7\\u7269\\u7b49"]
}
```

### df.to_json(orient='records')

```
‘records’ : list like [{column -> value}, … , {column -> value}]
```

实例：

```json
[{"combustion_mixture":"\\u6eb4\\u4e0e\\u78f7\\u3001\\u950c\\u7c89\\u3001\\u9541\\u7c89"},{"combustion_mixture":"\\u6d53\\u786b\\u9178\\u3001\\u6d53\\u785d\\u9178\\u4e0e\\u6728\\u6750\\u3001\\u7ec7\\u7269\\u7b49"},{"combustion_mixture":"\\u94dd\\u7c89\\u4e0e\\u6c2f\\u4eff"}]
```

### df.to_json(orient='index')

```
‘index’ : dict like {index -> {column -> value}}
```

```json
{"0":{"combustion_mixture":"\\u6eb4\\u4e0e\\u78f7\\u3001\\u950c\\u7c89\\u3001\\u9541\\u7c89"},"1":{"combustion_mixture":"\\u6d53\\u786b\\u9178\\u3001\\u6d53\\u785d\\u9178\\u4e0e\\u6728\\u6750\\u3001\\u7ec7\\u7269\\u7b49"},"2":{"combustion_mixture":"\\u94dd\\u7c89\\u4e0e\\u6c2f\\u4eff"}}
```

### df.to_json(orient='columns')

```
‘columns’ : dict like {column -> {index -> value}}
```

可参考 df.to_json(orient='index')。

### df.to_json(orient='values')

```
‘values’ : just the values array
```

```json
[["\\u6eb4\\u4e0e\\u78f7\\u3001\\u950c\\u7c89\\u3001\\u9541\\u7c89"],["\\u6d53\\u786b\\u9178\\u3001\\u6d53\\u785d\\u9178\\u4e0e\\u6728\\u6750\\u3001\\u7ec7\\u7269\\u7b49"],["\\u94dd\\u7c89\\u4e0e\\u6c2f\\u4eff"],["\\u738b\\u6c34\\u4e0e\\u6709\\u673a\\u7269"]]
```

### df.to_json(orient='table')

```
‘table’ : dict like {‘schema’: {schema}, ‘data’: {data}}
```

```json
{"schema":{"fields":[{"name":"index","type":"integer"},{"name":"combustion_mixture","type":"string"}],"primaryKey":["index"],"pandas_version":"0.20.0"},"data":[{"index":0,"combustion_mixture":"\\u6eb4\\u4e0e\\u78f7\\u3001\\u950c\\u7c89\\u3001\\u9541\\u7c89"},{"index":1,"combustion_mixture":"\\u6d53\\u786b\\u9178\\u3001\\u6d53\\u785d\\u9178\\u4e0e\\u6728\\u6750\\u3001\\u7ec7\\u7269\\u7b49"},{"index":2,"combustion_mixture":"\\u94dd\\u7c89\\u4e0e\\u6c2f\\u4eff"}]}
```

目前个人用的最多的是 df.to_json(orient='records')，scrapy 爬虫抓来的 json 数据就用它直接转成 dataframe 格式。
