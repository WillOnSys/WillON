# 开发规范文档

主要用于团队内开发准则，使得项目具有可读性和低耦合。

## Overview

| 作用对象 | 规则 | 作用对象 | 规则 |  
| :---: | :--- | :---: | :--- |  
| 变量 | 区分普通变量和成员变量以及常量 | 函数 | 区分普通函数和成员函数 |  
| 类 | 知名见意，主要依照标准库 | 接口/抽象 | 知名见意 |
| 各种细化规则 | ... | ... | ... |  

### Git提交办法

> 针对git进行管理代码版本的提交方法

| 等级 | 解释 | 等级 | 解释 |  
| :---: | :--- | :---: | :--- |  
| feat | 创建新文件、功能等 | update | 更新现有文件、功能等 |  
| fix | 修复以往代码产生的错误 | docs | 用于更新或添加文档 |  
| test | 用于添加、修改和测试用例 | format | 修改格式(作为保留字) |  

```bash
> git commit -m "feat: create a new feature"
> git commit -m "update: add x to xX feature"
> git commit -m "fix: what causes the bug"
> git commit -m "docs: create a xxx document"
> git commit -m "test: ..."
```

- 注意：**该提交办法适用于自己拉取的feature分支或dev分支，*严禁一切在main分支上的修改和提交***。

### 变量

> 针对于变量来说，主要分为`普通变量`、`成员变量`、`常量`以及`static`

#### 普通变量

1. 对于`普通变量`的实行方法主要是，以**蛇形命名方法**，可以搭配缩写，但尽量知名见意(情况实在不允许的情况下，请写全含义)。  
2. **必须初始化**，严禁出现非初始化的情况发生(特例，在`?`的作用下，可以不必强制初始化)。
3. **如果该类型可能导致`Null`的发生，请一定要使用`?`**。

``` dart
/*** 规范一 ***/
var this_is_num = 0;
String name = "miao"; // 禁止随意使用var a, b, c...

/*** 规范二 ***/
var number = 0;
// var number; [err] 语法上是合理的，但不符合开发规范

/*** 规范三 ***/
String? name;
// String name; [err] 是不被允许的，String?的情况下会默认为Null
```

#### 常量

对于`常量`的实行方法主要是，以**大写命名方法，用下划线间隔**，可以搭配缩写，但尽量知名见意。

> 值得注意的是：**因为定义常量就证明在后续一定会有用，因此此处就不在强调必须初始化，但是未初始化依旧不符合规范**

``` dart
const MAX_SIZE = 10; 
// [err] const MAXSIZE
// [err] const MAX_SIZE;
```

#### 成员变量

> 前提条件：因为在dart中没有特别强调成员的`公私属性`，因此，我们需要指定一套规范  

1. **非必要，禁止出现公开成员变量的情况**(因此你需要在一开始设计的时候就想好具体的接口和需要的属性)  
2. **所有成员采用下划线 + 命名的方式**(具体命令规范依照`普通变量`和`常量`准则)  
3. 由于dart中没有强调属性，因此私有变量的所有`getter`和`setter`都需要对其进行隐藏(具体看实例)  
    a. 禁止一切`getter`和`setter`的存在(暂行方法)  
    b. 禁止类文件中出现任何外部调用代码  
4. 由于禁止了`getter`和`setter`，我们需要为每一个私有变量提供自己的`getter`和`setter`(但是请谨记：**在实现中需要进行检查，没有检查是不符合规范的**)。  

``` dart
/*** 规范一 ***/
class Person {
    String name;  // [err] 严禁直接出现公有成员
    String _name; // [ok]
}

/*** 规范三 ***/
class Person {
    String _name;

    String get _name => _name;                  // [err] 严禁出现getter方法
    set _name(String name) => _name = name;     // [err] 严禁出现setter方法

    String getName() => _name;                  // [ok]
    void   setName(String name) {               // [ok]
        if (name == Null) {
            print("set name must be a non-Null!");
        }
        _name = name;
    }
    /*** 规范四 ***/
    void setName(String name) => _name = name;  // [err] 没有进行有效性检查
}
```

#### static

1. 对于`static`的实行办法是，如果`static`没有外加`const`，那么采用一般变量规则，否则采用常量规则。
2. **禁止`static`变量作为私有成员变量**

``` dart
/*** 规范一 ***/
static var this_is_number = 0;
static var n; // [err] 触发一般变量规则

static const int MAX_SIZE = 10;

/*** 规范二 ***/
class Person {
    static String _info = Null; // [err] 禁止作为私有变量
}
```

### 注释

### 函数

### 类

### 接口/抽象

### 更多细化