# heartDoctorServer

一个基于Perfect用Swift搭建的后台应用程序

## 兼容性

当前主分支可使用 Xcode 8.1及其以上版本 或 Ubuntu 上 3.0.1 版的 SPM进行编译。

## 编译 & 运行

### 1.终端
$ cd /根目录</br>
$ swift build  这个过程将会消耗您一定时间，请耐心等待</br>
$ .build/debug/Main 若看见输出 Starting HTTP server  on 0.0.0.0:8081 则编译运行成功，此时在浏览器中输入 [0.0.0.0:8081/baseApi](localhost:8081/baseApi)即可，由于采用POST请求，所以可以采用 [Postman](https://www.getpostman.com/) 进行模拟POST请求
### 2.Xcode
$ swift package generate-xcodeproj  命令执行完后会在你本地项目中生成Xcode工程文件，打开该工程文件 Command + R 编译运行即可
### 3.  [Perfect Assistant](http://perfect.org/en/assistant/)
打开点击Import Existing Package导入即可，编译、运行、生成Xcode工程文件

## MySQL相关

本项目采用mysql数据库，有关mysql问题可以参考下面

<p align="center">
<a href="http://perfect.org/get-involved.html" target="_blank">
<img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
</a>
</p>

<p align="center">
<a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
<img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
</a>
<a href="http://stackoverflow.com/questions/tagged/perfect" target="_blank">
<img src="http://www.perfect.org/github/perfect_gh_button_2_SO.jpg" alt="Stack Overflow" />
</a>
<a href="https://twitter.com/perfectlysoft" target="_blank">
<img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
</a>
<a href="http://perfect.ly" target="_blank">
<img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
</a>
</p>

<p align="center">
<a href="https://developer.apple.com/swift/" target="_blank">
<img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift 3.0">
</a>
<a href="https://developer.apple.com/swift/" target="_blank">
<img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
</a>
<a href="http://perfect.org/licensing.html" target="_blank">
<img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
</a>
<a href="http://twitter.com/PerfectlySoft" target="_blank">
<img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
</a>
<a href="http://perfect.ly" target="_blank">
<img src="http://perfect.ly/badge.svg" alt="Slack Status">
</a>
</p>

该示例展示了使用 MySQL 作为数据库时 Perfect 会话的用法。

## 问题报告

问题清单请参考以下链接：[http://jira.perfect.org:8080/projects/ISS/issues](http://jira.perfect.org:8080/projects/ISS/issues)。

## 更多信息

更多信息请访问 [perfect.org](perfect.org)。

## 联系我

邮箱：zzhujiajie@hotmail.com</br>
           443411162@qq.com
