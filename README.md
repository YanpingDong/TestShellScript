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
1.�������������ļ���������������ļ��еĲ��Խű�
  1.1ÿ�����Խű��������ļ�˳������
  1.2��nmon�����������ļ�monitorhost.confָ���Ļ���
  1.3����nmon
  1.4���jmeter�Ƿ�ִ�����
  1.5��*nmon�ļ�����ת�浽ָ����.csv�ļ���
2.�������ļ�monitorhost.conf��*nmon������ִ�в��Խű��Ļ���
3.����jtl,nmon���Ŀ¼
4.��jtl,nmon�ļ�����3������Ŀ¼��
5.����jmeter���
6.��ȡmonitorhost.confָ��������Ӳ����Ϣ
  6.1��Ŀ����������ռ��ڴ���Ϣ�ű�
  6.2�����ռ��ڴ���Ϣ�ű�
7.����nmon���

=======================other test_shell========================
1.��nmon�����������ļ�monitorhost.confָ���Ļ���
2.�������������ļ���������������ļ��еĲ��Խű�
  2.1ÿ�����Խű��������ļ�˳������
  2.2����nmon
  2.3���jmeter�Ƿ�ִ�����
  2.4��*nmon�ļ�����ת�浽ָ����.csv�ļ���
3.�������ļ�monitorhost.conf��*nmon������ִ�в��Խű��Ļ���
4.����jtl,nmon���Ŀ¼
5.��jtl,nmon�ļ�����3������Ŀ¼��
6.����jmeter���
7.��ȡmonitorhost.confָ��������Ӳ����Ϣ
  7.1��Ŀ����������ռ��ڴ���Ϣ�ű�
  7.2�����ռ��ڴ���Ϣ�ű�
8.����nmon���

=======================windows_script========================
windows bat script include two file (startup.bat setEnv.bat).
startup.bat is boot script
setEnv.bat to set and check enviroment in which the needed vars
whether or not have been setted 