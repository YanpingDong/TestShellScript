#!/bin/sh

current_date=`date +%Y%m%d%H%M%S`
test_name="insertuseraction"
log_file="logs/${test_name}_${current_date}.log"
SECOND=2
TIME=25
hosts_file="conf/monitorhost.conf"
nmon="nmon_x86_64_centos6.centos6"

echo "" >> $log_file
echo "" >> $log_file
echo "" >> $log_file
date >> $log_file
date

# start sub test base on concurrency configuration file
while read LINE
do
	concurrency=$LINE
	echo ">>>>>>>>>>>   concurrency=$concurrency   begin  >>>>>>>>>" >> $log_file
	echo ">>>>>>>>>>>   concurrency=$concurrency   begin  >>>>>>>>>"

	if [ ! -e jmx/${test_name}_${concurrency}.jmx ]
	then
		echo "Error : jmx/${test_name}_${concurrency}.jmx does not exist, so skip ${test_name}_${concurrency}.jmx test" >> $log_file
		echo "Error : jmx/${test_name}_${concurrency}.jmx does not exist, so skip ${test_name}_${concurrency}.jmx test"
		continue
	fi

	echo "File check successfully and then start test script">> $log_file
	echo "File check successfully and then start test script"

	echo "/home/test/apache-jmeter-2.11/bin/jmeter -n -t jmx/${test_name}_${concurrency}.jmx -l jmeter_${test_name}_${concurrency}.jtl &" >> $log_file
	echo "/home/test/apache-jmeter-2.11/bin/jmeter -n -t jmx/${test_name}_${concurrency}.jmx -l jmeter_${test_name}_${concurrency}.jtl &"
	/home/test/apache-jmeter-2.11/bin/jmeter -n -t jmx/${test_name}_${concurrency}.jmx -l jmeter_${test_name}_${concurrency}.jtl &

	#wait for jmeter start
	sleep 3

    # hosts.conf consist of PC that need to get system running info
	# start nmon on all the specified machine
	while read LINE
	do
		curr_host=`echo $LINE | awk '{print $1}'`
		curr_username=`echo $LINE | awk '{print $2}'`
		curr_password=`echo $LINE | awk '{print $3}'`

		# start nmon
		echo "start ${nmon} on ${curr_username}@${curr_host}" >> $log_file
		echo "start ${nmon} on ${curr_username}@${curr_host}"
		expect -c "
		spawn ssh ${curr_username}@${curr_host} \"chmod +x /tmp/${nmon} ; /tmp/${nmon} -s $SECOND -c $TIME -f & \"
			expect {
				\"*no)?\" {send \"yes\r\"; exp_continue}
				\"*assword:\" {send \"$curr_password\r\"; }
			}
		expect eof;"
	done < $hosts_file
	
    #wait for nmon start
	sleep 3
    
	echo "Starting check jmeter process is still running or not." >> $log_file
	echo "Starting check jmeter process is still running or not." 
	while true
	do
		jmeter_num=`ps -ef |grep -i jmeter |grep -v grep | wc -l`
		if [ $jmeter_num -eq 0 ]
		then
			break
		fi
        
		echo "JMeter is still running, waiting 10 second for next check." >> $log_file
		echo "JMeter is still running, waiting 10 second for next check."
		sleep 10
	done

	#wait for nmon complete. the total runing time of nmon is 2*25S 
	sleep 50

    # sort the nmon results file and then restore to CSV
	while read LINE
	do
		curr_host=`echo $LINE | awk '{print $1}'`
		curr_username=`echo $LINE | awk '{print $2}'`
		curr_password=`echo $LINE | awk '{print $3}'`

		# generate csv on remote host
		echo "generate csv on ${curr_username}@${curr_host}" >> $log_file
		expect -c "
		spawn ssh ${curr_username}@${curr_host} \"sort *.nmon > ${curr_host}_${test_name}_concurrency_${concurrency}.csv ; rm -f *nmon\"
			expect {
				\"*no)?\" {send \"yes\r\"; exp_continue}
				\"*assword:\" {send \"$curr_password\r\"; }
			}
		expect eof;"

	done < $hosts_file
	
	echo "<<<<<<<<<<<   concurrency=$concurrency  end  <<<<<<<<<<<" >> $log_file
	echo "<<<<<<<<<<<   concurrency=$concurrency  end  <<<<<<<<<<<"
done < conf/concurrency.conf

echo "" >> $log_file
echo "" >> $log_file
echo "" >> $log_file
