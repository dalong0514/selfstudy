# Java — Convert Object to Map example

[Java — Convert Object to Map example | by Nayan Arora | Medium](https://medium.com/@aroranayan/java-convert-object-to-map-example-3244bf8b153e)

Nayan Arora

May 30, 2019

In Java, you can use the Jackson library to convert a Java object into a Map easily.

[FasterXML/jackson: Main Portal page for the Jackson project](https://github.com/FasterXML/jackson)

## 01. Get Jackson

pom.xml

```
<dependency>
	<groupId>com.fasterxml.jackson.core</groupId>
	<artifactId>jackson-databind</artifactId>
	<version>2.6.3</version>
</dependency>
```

## 02. Convert Object to Map

A Jackson 2 example to convert a Student object into a java.util.Map

Student.java

```java
package com.nayan.examples;
import java.util.List;

public class Student {
    private String name;
    private int age;
    private List<String> skills;
    // getters setters
}
```

ObjectToMapExample.java

```java
package com.nayan.examples;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Arrays;
import java.util.Map;

public class ObjectToMapExample {
    public static void main(String[] args) {
        ObjectMapper oMapper = new ObjectMapper();
        Student obj = new Student();
        obj.setName("nayan");
        obj.setAge(34);
        obj.setSkills(Arrays.asList("java","angular"));
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        System.out.println(map);
    }
}
```

Output

```
{name=nayan, age=34, skills=[java, angular]}
```

1-2『

[Jackson Tutorial | Baeldung](https://www.baeldung.com/jackson)

并且还下载本书籍「2021084Do-JSON-with-Jackson」。

经测试可行（2021-05-15）。

1、引入包依赖。在项目的 pom.xml 里增加依赖语句：

```java
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
        </dependency>
```

不用写版本号，它会自己找最新的版本。开始的时候写了一个版本号，跑的时候 idea 又生成了下面没有版本号的依赖，索性就把上面有版本号的依赖删掉了。

2、实现把洁净空调全局性的数据对象转为 map 对象。

```java
    /**
     * 获取房间洁净等级代号 map 集合
     *
     * @param nsCleanAirGlobalParam
     * @return unit test completed
     */
    @Override
    public Map<String, Object> getCleanGradeCodeMap(NsCleanAirGlobalParam nsCleanAirGlobalParam) {
        ObjectMapper oMapper = new ObjectMapper();
        Map<String, Object> cleanGradeCodeMap = oMapper.convertValue(nsCleanAirGlobalParam, Map.class);

        return cleanGradeCodeMap;
    }
```

返回的 map 对象，键名是字符串（原来对象里的对象名），键值是个对象（原来对象里的对象值），这个键值对象可以通过调方法 `get("key")` 来获取。

3、写单元测试。

```java
    @Test
    void getCleanGradeCodeMap() {
        Map<String, Object> res = nsCleanAirService.getCleanGradeCodeMap(nsCleanAirGlobalParam);
        Assertions.assertEquals(12, res.get("cncMinAirChangeRate"));
    }
```

』