<!-- 
@author: Chen Miao  
@date: 2023/10/9 
-->

# 开发规范文档

主要用于团队内开发准则，使得项目具有可读性和低耦合。  

## 目录  

1. [Overview](#Overview)
2. [Git提交办法](#Git)
3. [变量](#Variable)  
    3.1. [普通变量](#GeneralVariable)  
    3.2. [常量](#ConstVariable)  
    3.3. [成员变量](#MemberVariable)  
    3.4. [static](#Static)
4. [注释](#Comment)
5. [函数](#Function)
6. [类](#Class)
7. [接口/抽象](#AbstractInterface)
8. [项目结构](#ProjectStructure)
9. [更多细化](#More)  
    8.1. [关于重复widget试行办法](#LambdaWidget)

---

##  1. <a name='Overview'></a>Overview

| 作用对象 | 规则 | 作用对象 | 规则 |  
| :---: | :--- | :---: | :--- |  
| 变量 | 区分普通变量和成员变量以及常量 | 函数 | 区分普通函数和成员函数 |  
| 类 | 知名见意，主要依照标准库 | 接口/抽象 | 知名见意 |
| 各种细化规则 | ... | ... | ... |  

---

##  2. <a name='Git'></a>Git提交办法

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

---

##  3. <a name='Variable'></a>变量

> 针对于变量来说，主要分为`普通变量`、`成员变量`、`常量`以及`static`

###  3.1. <a name='GeneralVariable'></a>普通变量

~~1. 对于`普通变量`的实行方法主要是，以**蛇形命名方法**，可以搭配缩写，但尽量知名见意(情况实在不允许的情况下，请写全含义)。**v0.1.0初案，现已被否决**~~  

1. 对于`普通变量`的实行方法主要是，以**小驼峰命名方法**，可以搭配缩写，但尽量知名见意(情况实在不允许的情况下，请写全含义)。  
2. **必须初始化**，严禁出现非初始化的情况发生(特例，在`?`的作用下，可以不必强制初始化)。  
3. **如果该类型可能导致`Null`的发生，请一定要使用`?`**。

``` dart
/*** 规范一 ***/
var thisIsNum = 0;
String name = "miao"; // 禁止随意使用var a, b, c...

/*** 规范二 ***/
var number = 0;
// var number; [err] 语法上是合理的，但不符合开发规范

/*** 规范三 ***/
String? name;
// String name; [err] 是不被允许的，String?的情况下会默认为Null
```

###  3.2. <a name='ConstVariable'></a>常量

对于`常量`的实行方法主要是，以**大写命名方法，用下划线间隔**，可以搭配缩写，但尽量知名见意。

> 值得注意的是：**因为定义常量就证明在后续一定会有用，因此此处就不在强调必须初始化，但是未初始化依旧不符合规范**

``` dart
const MAX_SIZE = 10; 
// [err] const MAXSIZE
// [err] const MAX_SIZE;
```

###  3.3. <a name='MemberVariable'></a>成员变量

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

###  3.4. <a name='Static'></a>static

1. 对于`static`的实行办法是，如果`static`没有外加`const`，那么采用一般变量规则，否则采用常量规则。
2. **禁止`static`变量作为私有成员变量**

``` dart
/*** 规范一 ***/
static var thisIsNum = 0;
static var n; // [err] 触发一般变量规则

static const int MAX_SIZE = 10;

/*** 规范二 ***/
class Person {
    static String _info = Null; // [err] 禁止作为私有变量
}
```

---

##  4. <a name='Comment'></a>注释

为了一般化管理，注释也需要做出特定办法。  

1. 每一个文件开头必须做出文档注释，以`///`开头。
2. 每一个函数和类必须做出文档注释，以`/***/`开头，并且，内容包括`@author`, `@date`, `@brief`(也就是对应的作者、日期、和简要),**在必要情况下，请加上`@param`、`@return`**
3. 对于变量的注释，采取有必要则注释的方法，以`//`开头即可

``` dart
/*** 规范一 ***/
// in Person.dart

/// This is .....
/// ....

/*** 规范二 ***/
/*
* @author Miao
* @date 2023/10/02
* @brief for string comparing
* @param src the source string
* @param dst the destination string
* @return if src < dst, return -1, if src > dst, return 1, other return 0
**/
int strcmp(String src, String dst);

/*** 规范三 ***/
int num = 0; // comment
```

---

##  5. <a name='Function'></a>函数

对于函数，我们有以下实行办法：

1. 函数名必须知名见意，且风格以**小驼峰**为主。
2. 必须加上必要的函数注释规范
3. 在非特殊情况下，函数尽量能够适应于多种接口，以提高重用。
4. 如果函数十分简单，且内部无修改，尽量使用`const`以实现`编译期计算`
5. 非必要，不要加上`static`，除非是在类中作为公有函数

``` dart
/*** 规范一 ***/
void fromJson(Map<T>);
void from_json(Map<T>); // [err] 不符合规范一

/*** 规范二 ***/
/*
* @author Miao
* @date 2023/10/02
* @brief use Json format to init a object
**/
void fromJson(Map<T>);

/*** 规范三 ***/
Person.fromJson(...);
Cat.fromJson(...);

printJson(String);
printJson(num);
...

/*** 规范四 ***/
const int getNum() {
    return this.num;
}

/*** 规范五 ***/
static int add(int x) {
    return x;
} // [err] 违反规范五，几乎没有意义

Point.distanceTo(Point, Point); // [ok]
```

---

##  6. <a name='Class'></a>类

对于类，我们采用以下办法：

1. 类名知名见意，以**大驼峰**命名风格
2. 加上必要的注释
3. **类必须单一文件，严禁其他外部代码直接访问类中成员**
4. 禁止一切`getter`和`setter`
5. 严格区分`operator`、`构造函数`、以及成员变量和成员函数

``` dart
/*** 规范一 ***/
class PersonInfo;

/*** 规范三 ***/
// in PersonInfo.dart
class PersonInfo {
    int    _age;
    String _name;
    String _addr;

    int get _age => _age;               // [err] 严格禁止
    set _age(int age) => _age = age;    // [err] 严格禁止

    /*** 规范五 ***/
    PersonInfo();
    PersonInfo(this._age);
    ...
    PersonInfo(this._age, this._name, this._addr);

    PersonInfo operator+ (PersonInfo); 
    PersonInfo operator- (PersonInfo);
    ...
    PersonInfo operator...
}

int getAge() {
    return PersonInfo()._age;           // [err] 严格禁止
}
```

---

##  7. <a name='AbstractInterface'></a>接口/抽象

对于接口与抽象的实行办法：

1. 命名风格依照类规范一实行
2. 尽可能的使得接口和抽象满足大部分需求
3. 不会导致过高的耦合度

---

## 8. <a name='ProjectStructure'></a>项目结构

本项目（feature/ui）总体项目结构如下：

```
WillON
|-------docs		  				 			#用于存放开发文档明细
|	   	|-------DevelopmentSpecificationDoc_cn.md
|
|-------ui_example
|		|-------assets 				  			#存放所有静态资源
|		|-------build  				  			#存放构建过程中的临时文件 NOTE:不要去修改它
|		|-------lib	   				  			#存放源文件
|		|		|-------page		  			#存放页面Widget
|		|				|-------dashboard
|		|				|-------allblogs
|		|				|-------directory
|		|				|-------friends
|		|				|-------main
|		|				|-------messages
|		|				|-------schedule
|		|				|-------settings
|		|		|-------routes		  			#存放与路由相关的，注册函数、回调函数
|		|		|-------states		  			#存放全局共享状态
|		|		|-------uitls		  			#存放全局共享的工具类函数
|		|		|-------widgets		  			#存放所有page所共享的公共widget
|		|		|-------main.dart	  			#项目的入口文件 NOTE：不要去修改它
|		|-------analysis_options.yaml 			#存放Dart的语法分析规则 NOTE：不要去修改它
|		|-------pubspec.yaml		  			#存放项目的依赖文件 NOTE：不要去修改它
|
|-------LICENSE									#存放协议相关
|		
|-------README.md								#存放项目介绍		
```

### 8.1 对于开发的目录规范

1. 每个page必须存放在page目录下的一个目录中，如`dashboard.dart`则应该存放在`WillON/ui_example/lib/page/dashboard`下。

2. 与page目录同名的dart文件应该放在page目录下作为该目录的顶级文件（**顶级文件就是在直接处于该目录下的文件，而不处于该目录的子目录下**），如：`dashboard.dart`应该放在`/page/dashboard`下，而不能放在其目录的子目录下

   1. `/page/dashboard/subdirectory/dashboard.dart` 这种写法是错误的
   2. `/page/dashboard/dashboard.dar` 这种写法是正确的

3. 对于每个page，该page目录下只能拥有一个顶级文件，作为该page的入口文件，对于该page所使用到的子widget或者util，应该在该page目录下新建一个`widgets`和`utils`目录来存放，而不应该放在page目录下。

   ```
   good
   
   page
   |-------dashboard
   		|-------utils
   		|		|-------utils.dart
   		|-------widgets
   		|		|-------component1.dart
   		|		|-------component2.dart
   		|-------dashboard.dart
   
   bad
   
   page
   |-------dashboard
   		|-------utils.dart
   		|-------component1.dart
   		|-------component2.dart
   		|-------dashboard.dart
   ```

4. 对于多个页面会使用到的公共`widget`，应该将其抽取到`/lib/widgets`目录中，并使用统一导出

5. 对于每个页面的路由注册，应该放到`/lib/routes`目录中，进行统一注册，进行权限校验以及生命周期的处理

6. 对于多个页面会使用到的`state`，应该放在`/lib/states`目录中，进行统一的导出

7. 对于多个页面会使用到的`util`，应该放在`/lib/utils`目录中，进行统一的导出使用

8. 对于所有静态资源，应该放在`ui_example/assets`中，进行统一的管理，对于某个个页面会使用到的静态资源，在`ui_example/assets`下新建一个属于该页面的目录用于存放该页面专属的静态资源

   ```
   good
   
   ui_example
   |-------assets
   		|-------dashboard
   		|		|-------book.jpg
   		|-------allblogs
   		|		|-------blog.jpg
   		|		|-------icon.jpg
   		|-------common_image.jpg
   
   bad
   
   ui_example
   |-------assets
   		|-------image.png
   		|-------image1.jpg
   		|-------image3.jpg
   		|-------image4.jpg
   ```


---
##  9. <a name='More'></a>更多细化

###  9.1. <a name='LambdaWidget'></a>关于重复widget试行办法

> 在实际编程中，由于各种组件会经常重复性使用，因此导致**代码量及其冗余**，为解决此情况的发生，故有此办法。

1. 对于冗余组件代码，**尽可能抽离一切元素，使用`lambda(闭包)`函数、或使用`细粒度widget`进行封装**  
2. 由于组件的多样性和功能性多元化，因此对于封装组件不做特别严格要求，**尽量在本文件内进行封装，同时满足`函数规范`和`类规范`**
3. **严禁外部文件直接调用该闭包函数、或细粒度widget，尽可能的使用`static`进行修饰该闭包函数**  
4. **特例：该闭包函数允许被使用为私有函数(与`函数规范规范五`相悖)**  

```dart
@override
Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
                Flex(
                    direction: Axis.horizontal,
                    children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: 30.0,
                                color: Colors.red,
                            ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                                height: 30.0,
                                color: Colors.blue,
                            ),
                        ),
                    ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                        height: 100.0,
                        child: Flex(
                            direction: Axis.vertical,
                            children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: 30.0,
                                        color: Colors.red,
                                    ),
                                ),
                                Spacer(flex: 1,),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: 30.0,
                                        color: Colors.red,
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
            ],
        ),
    );
}
```

可以看见，此处的代码中，`Expanded`组件的冗余度过高，仅仅只有内部的一些元素需要更改，因此，我们可以抽出必要的元素进行封装：

```dart
static var expandedFunc = (int flex, double height, Color? color) {
    return Expanded(
        flex: flex,
        child: Container(
            height: height,
            color: color,
        ),
    );
};
@override
Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
                Flex(
                    direction: Axis.horizontal,
                    children: [
                        expandedFunc(1, 30.0, Colors.red),
                        expandedFunc(2, 30.0, Colors.blue),
                    ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                        height: 100.0,
                        child: Flex(
                            direction: Axis.vertical,
                            children: [
                                expandedFunc(2, 30.0, Colors.red),
                                Spacer(flex: 1,),
                                expandedFunc(1, 30.0, Colors.green),
                            ],
                        ),
                    ),
                ),
            ],
        ),
    );
}
```

当我们将`Expanded`组件抽离为`expandedFunc`后，我们通过函数调用的方式轻易的实现了冗余的代码。