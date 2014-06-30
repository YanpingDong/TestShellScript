#!/bin/sh

# get current date 
current_date=`date +%Y%m%d%H%M%S`
# create log file name
log_file="logs/pbov2.0_test_${current_date}.log"
nmon="nmon_x86_64_centos6.centos6"
hosts_file="conf/monitorhost.conf"


# hosts.conf consist of PC that need to get system running info
# copy nmon to all the specified machine for monitor
while read LINE
do
	curr_host=`echo $LINE | awk '{print $1}'`
	curr_username=`echo $LINE | awk '{print $2}'`
	curr_password=`echo $LINE | awk '{print $3}'`

	# copy nmon to remote host
	echo "scp ${nmon} to ${curr_username}@${curr_host}" >> $log_file
	echo "scp ${nmon} to ${curr_username}@${curr_host}"
	expect -c "
	spawn scp ${nmon} ${curr_username}@${curr_host}:/tmp/
		expect {
			\"*no)?\" {send \"yes\r\"; exp_continue}
			\"*assword:\" {send \"$curr_password\r\"; }
		}
	expect eof;"
done < $hosts_file

# start test script according to the configuration file
# that include all you want to test  
while read LINE
do
	echo "" >> $log_file
	echo "Begin to test $LINE" >> $log_file
	echo "Begin to test $LINE" 
	bash ./test_${LINE}.sh  
	echo "Test $LINE DONE" >> $log_file
	echo "Test $LINE DONE" 
done < conf/interface2btested.conf

# copy result files 
echo "" >> $log_file
echo "Begin to copy remote results" >> $log_file
bash ./copy_results.sh
echo "Copy remote results DONE" >> $log_file

# remove result to results dir waiting for analysis
echo "Begin to remove result files to results dir" >> $log_file
echo "Begin to remove result files to results dir"
mkdir -p results/${current_date}
mkdir -p results/${current_date}/jtl
mkdir -p results/${current_date}/nmon

echo "" >> $log_file
echo "Begin to remove jtl files to results jtl dir" >> $log_file
echo "Begin to remove jtl files to results jtl dir"
mv jmeter_*jtl results/${current_date}/jtl

echo "" >> $log_file
echo "Begin to remove nmon files to results nmon dir" >> $log_file
echo "Begin to remove nmon files to results nmon dir"
hosts_file="conf/monitorhost.conf"
while read LINE
do
	curr_host=`echo $LINE | awk '{print $1}'`
	mv ${curr_host}* results/${current_date}/nmon
done < $hosts_file

echo "" >> $log_file
echo "Remove result files(jtl,nmon) to results dir DONE">> $log_file


# parse jmeter results
echo "" >> $log_file
echo "Parsing jmeter results" >> $log_file
echo "Parsing jmeter results" 
./parse_jtl.sh results/${current_date}/jtl results/${current_date}/jmeter_result_${current_date}.txt
echo "Parsing jmeter results DONE" >> $log_file
echo "Parsing jmeter results DONE"

echo "" >> $log_file
echo "Get remote memory rate" >> $log_file
./get_remote_server_memory.sh
echo "Get remote memory rate DONE" >> $log_file

# parse nmon results
echo "" >> $log_file
echo "Parsing nmon results" >> $log_file
./parse_nmon.sh results/${current_date}/nmon results/${current_date}/nmon_result_${current_date}.txt
echo "Parsing nmon results DONE" >> $log_file

echo "ALL DONE" >> $log_file
echo "ALL DONE"
echo "" >> $log_file
