---
title: "函数式编程"
date: 2020-04-05T13:48:33+08:00
categories:
  - java
type: posts
---

- OO(Object oriented, 面向对象): 抽象数据

- FP(Functional programming, 函数式编程): 抽象行为
  1. 可以并行编程
  2. 代码可靠性
  3. 代码创建和库复用

<!--more-->

## Lambda 表达式

Lambda表达式是使用最小可能语法编写的函数定义：

1. Lambda表达式产生函数，而不是类。在JVM上，一切都是一个类，因此在幕后执行各种操作使 Lambda 看起来像函数 —— 但作为程序员, 你可以高兴地假装它们“只是函数”。

2. Lambda 语法尽可能少，这正是为了使 Lambda 易于编写和使用。

### Lambda语法

语法： (参数1,  参数2...) -> 方法体

```java
interface Multi {
  String twoArg(String head, Double d);
}

// 单行语句
(h, n) -> h + n

// 多行语句
() -> {
    System.out.println("moreLines()");
    return "from moreLines()";
  }
```



1. 参数：h
   1. 当没有参数时，必须有括号`()`表示空参数列表
   2. 当只有一个参数时, 可以省略括号
   3. 当有多个参数时, 将参数列表放在`()`中
2. 接着 `->`，可视为“产出”。
3. `->` 之后的内容都是方法体
   1. 当方法体是单行语句时, 不需要`{}`, 语句结尾符`;`和`return`,语句的计算结果即为返回值
   2. 当方法体是多行语句时, 需要`{}`，语句结尾符`;`和`return`



## 方法引用

方法引用是Java8中引入的新特性，它提供了一种引用方法而不执行方法的方式，可以让我们重复使用现用方法的定义，做为某些Lambda表达式的另一种更简洁的写法。

语法:  类名或对象名，后面跟 `::`，然后跟方法名称

### 1. 静态方法

指向静态方法的引用，语法：`类名::静态方法名`

```java
(String str) -> System.out.print(str)
// 转为方法引用形式
System.out::print
```

### 2. 内部对象的实例方法

指向Lambda表达式内部对象的实例方法的引用，语法：`类名::实例方法名`

```java
(Mask mask) -> mask.isUsed()
// 转为方法引用形式
Mask::isUsed
```

### 3. 外部对象的实例方法

指向Lambda表达式外部对象的实例方法的引用，语法：`实例名::实例方法名`

```java
String type = "aType";
(String newType) -> type.equals(newType)
// 转为方法引用形式
type::equals
```

### 4. 构造方法

指向构造方法的引用,`类名:: new`

```java
(String brand, String type) -> new Mask(brand, type)
// 转为方法引用形式
Mask::new
```



## 函数式接口

函数式接口就是有且仅有一个抽象方法的接口

 	1. 接口interface
 	2. 有且仅有一个抽象方法，即可以多0或多个非抽象方法
 	3. 带有`FunctionalInterface`的interface，编译器检查该interface是否符合第2条的约束，如果不符合，则报错
 	4. 函数式接口的抽象方法的签名和Lambda表达式的签名必须一致，签名包括入参参数类型和返回值

### 命名规约

`java.util.function` 包旨在创建一组完整的目标接口，使得我们一般情况下不需再定义自己的接口。这主要是因为基本类型会产生一小部分接口。 如果你了解命名模式，顾名思义就能知道特定接口的作用。

以下是基本命名准则：

1. 如果只处理对象而非基本类型，名称则为 `Function`，`Consumer`，`Predicate` 等。参数类型通过泛型添加。
2. 如果接收的参数是基本类型，则由名称的第一部分表示，如 `LongConsumer`，`DoubleFunction`，`IntPredicate` 等，但基本 `Supplier` 类型例外。
3. 如果返回值为基本类型，则用 `To` 表示，如 `ToLongFunction ` 和 `IntToLongFunction`。
4. 如果返回值类型与参数类型一致，则是一个运算符：单个参数使用 `UnaryOperator`，两个参数使用 `BinaryOperator`。
5. 如果接收两个参数且返回值为布尔值，则是一个谓词（Predicate）。
6. 如果接收的两个参数类型不同，则名称中有一个 `Bi`





## 常用函数式接口

### Runnable

```java
// 内置，不需要导入，一般用于多线程编程创建线程函数体
package java.lang;

@FunctionalInterface
public interface Runnable {
    public abstract void run();
}
```

### Function

```java
package java.util.function;

@FunctionalInterface
public interface Function<T, R> {
    R apply(T t);
}
```

### Supplier

```java
package java.util.function;

@FunctionalInterface
public interface Supplier<T> {
    T get();
}
```

### Consumer

```java
package java.util.function;

@FunctionalInterface
public interface Consumer<T> {
    void accept(T t);
}
```

### Predicate

```java
package java.util.function;

@FunctionalInterface
public interface Predicate<T> {
    boolean test(T t);
}
```

几个常用的函数式接口入参和返回，都是泛型对象的，也就是必须为引用类型。当我们传入或获取的是基本数据类型时，将会发生自动装箱和自动拆箱，带来不必要的性能损耗。



## 高阶函数

产生或消费一个函数， 即入参或返回值为函数的函数

1. 要消费一个函数，消费函数需要在参数列表正确地描述函数类型
2. 要产生一个函数，产生函数需要在返回值正确地描述函数类型

```java
import java.util.function.*;

class I {
  @Override
  public String toString() { return "I"; }
}

class O {
  @Override
  public String toString() { return "O"; }
}

public class TransformFunction {
  static Function<I,O> transform(Function<I,O> in) {
    return in.andThen(o -> {
      System.out.println(o);
      return o;
    });
  }
  public static void main(String[] args) {
    Function<I,O> f2 = transform(i -> {
      System.out.println(i);
      return new O();
    });
    O o = f2.apply(new I());
  }
}
```

## 闭包

使用函数作用域之外的非全局变量的变量

1. 从 Lambda 表达式引用的局部变量必须是 `final` 或者是等同 `final` 效果的。
2. 这就叫做**等同 final 效果**（Effectively Final）。这个术语是在 Java 8 才开始出现的，表示虽然没有明确地声明变量是 `final` 的，但是因变量值没被改变过而实际有了 `final` 同等的效果。 如果局部变量的初始值永远不会改变，那么它实际上就是 `final` 的。
3. **等同 final 效果**意味着可以在变量声明前加上 **final** 关键字而不用更改任何其余代码。 实际上它就是具备 `final` 效果的，只是没有明确说明。