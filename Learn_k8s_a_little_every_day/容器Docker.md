容器Docker
--------

容器是种轻量化的打包技术，采用namespace、CGroup等技术。
Docker主要由三个概念组合：
----------------

![此处输入图片的描述][1]


 1. image
 一种静态的模版，里头包含了完整的服务（代码＋环境）
 可以通过tag管理image
 2. Container
 特点：
 *无状态
 *体积小、快速启动、好迁移
 3. Registry
 存放image的仓库。

Docker Engine
-------------
主要架构如下：
![此处输入图片的描述][2]


  [1]: https://ithelp.ithome.com.tw/upload/images/20200906/20129656ovlp7mxLwe.png
  [2]: https://ithelp.ithome.com.tw/upload/images/20200906/20129656Wh7E71Oe2D.png