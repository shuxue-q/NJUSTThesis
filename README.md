# 这是一个适用于南京理工大学本科毕业生的论文LaTeX模板
## 目前已经完成
-   封面
-   目录
-   字体
-   致谢
-   参考文献

## 存在一些问题
-   封面的距离和word有一些差距
-   宋体的粗体比较细
-   其他目前还未发现的问题

## 未来需要增加的功能
- [ ] 封面，可以由用户自定义选择生成或者插入
- [ ] 增加变量描述，下标等功能，添加在正文内容之前，目录之后
- [ ] 代码优化
- [ ] 使用dtx

## V0.2.1版本更新
- 提供智能引用功能，有宏包clveref提供
- 添加了hyperref，booktabs，subcaption宏包

# 未来计划
- 逐步迁移到Typst中
目前：
    - typst v0.13 版本已经能实现完美的首行缩进
    - typst 有着更方便的数学公式支持，不需要反斜杠
    - 可以更方便的实现文档类
    - 但是目前的支持较少
    - pdf导出不会压缩

# 使用教程
首先你需要安装方正魏碑简体字体，该字体提供在font文件夹中，然后即可编译。
编译方式为
```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```
或者
```bash
latexmk -xelatex main.tex
```
