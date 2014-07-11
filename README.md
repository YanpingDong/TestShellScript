According to the configuration file to run linux script!

use tool
 jmeter
 nmon
 
simple processing 
1.run every jmeter test according to configuration file in conf DIR
2.run nmon on PC that's needed to be monitored
3.collection info
4.pase jmeter results
5.pase nmon results

The detail of processing
=======================test_shell========================
1.遍历测试配置文件，逐个启动配置文件中的测试脚本
  1.1每个测试脚本按配置文件顺序启动
  1.2将nmon拷贝到配置文件monitorhost.conf指定的机器
  1.3启动nmon
  1.4检测jmeter是否执行完成
  1.5将*nmon文件排序并转存到指定的.csv文件中
2.按配置文件monitorhost.conf将*nmon拷贝到执行测试脚本的机器
3.创建jtl,nmon结果目录
4.将jtl,nmon文件移入3创建的目录中
5.解析jmeter结果
6.获取monitorhost.conf指定机器的硬件信息
  6.1向目标机器发送收集内存信息脚本
  6.2启动收集内存信息脚本
7.解析nmon结果

=======================other test_shell========================
1.将nmon拷贝到配置文件monitorhost.conf指定的机器
2.遍历测试配置文件，逐个启动配置文件中的测试脚本
  2.1每个测试脚本按配置文件顺序启动
  2.2启动nmon
  2.3检测jmeter是否执行完成
  2.4将*nmon文件排序并转存到指定的.csv文件中
3.按配置文件monitorhost.conf将*nmon拷贝到执行测试脚本的机器
4.创建jtl,nmon结果目录
5.将jtl,nmon文件移入3创建的目录中
6.解析jmeter结果
7.获取monitorhost.conf指定机器的硬件信息
  7.1向目标机器发送收集内存信息脚本
  7.2启动收集内存信息脚本
8.解析nmon结果

=======================windows_script========================
windows bat script include two file (startup.bat setEnv.bat).
startup.bat is boot script
setEnv.bat to set and check enviroment in which the needed vars
whether or not have been setted 