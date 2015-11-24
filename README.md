# 项目相关
===========


### 0. 代码规范
详见附录1.

### 1. 

### 2. 

### 3. 

### 4. 依赖库管理cocoapods
详见:[cocoapods](http://cocoapods.org/)

### 5. 数据库设计
数据库管理采用开源项目MagicalRecord,原因详见：[MagicRecord](https://github.com/magicalpanda/MagicalRecord)
表结构见附录2.


#### 工作流程如下

－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－》


        
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－》


－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－》
附录1.
代码规范

总则


1.Don’t repeat your self.
2.代码自注释，依靠代码本身来表达你的设计意图，不要依赖注释。
3.单一指责，无论是类、函数、模块、包尽可能令其指责纯净且单一。
4.死程序不说谎，不要因为防止Crash写奇葩的代码。程序Crash了，反而更容易查找错误。
5.借用美国童子军军规：让营地比你来时更干净。



         [代码规范](http://www.90159.com/2015/06/17/Objective-C%E7%BC%96%E7%A0%81%E8%A7%84%E8%8C%83%EF%BC%9A26%E4%B8%AA%E6%96%B9%E9%9D%A2%E8%A7%A3%E5%86%B3iOS%E5%BC%80%E5%8F%91%E9%97%AE%E9%A2%98/#rd)

附录2.
数据库表结构


附录3.

程序基本结构
AppDelegate
Models

    |- BaseModel.h
    |- BaseModel.m
    |- CollectionModel.h
    |- CollectionModel.m

Macro

|- AppMacro.h
    |- NotificationMacro.h
    |- VendorMacro.h放一些第三方常量
    |- UtilsMacro.h放的是一些方便使用的宏定义

General
|- Views
        |- FQAHScollView
        |- FQAHPullToRefresh
        ...
    | - Categories
        |- UIViewController+Sizzle
        |- UIImageView+Downloader
        ...

Helpers

    |- FQAHShareHelper
    |- FQAHHelper
    |- FQAHEmotionHelper

Vendors
   |- FQAHDataSource 

Resources
    

