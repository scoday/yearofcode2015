#!/bin/bash

# RUN Hourly: 
## Crontab 0 * * * * cd $working_dir && ./apache_loganalysis.sh

mkdir ./temp/
cp access.log ./temp/
cd ./temp/ # Assumption
mydir=$PWD
URL=  # Might use this for uploading to somewhere
FILENAME=access.log
FILEDATE=`date +%Y%m%d`
# YESTERDAY=`date -v -1d +%Y%m%d` # BSD style date flags, works on OSX + FreeBSD but not so much on linux


topTenIPs() {
	# This will produce the 10 IPs making the most requests and display
	# the IP and the number of requests attempted.
	echo "Start Log Analysis: " > apache_$FILEDATE.log
	echo "--Top Ten IPs" >> apache_$FILEDATE.log
	cat $FILENAME | awk '{print $1}' | sort | uniq -c | sort -n | tail -n 10 >> apache_$FILEDATE.log
}

topTenAgents() {
	# This will produce the top 10 user agents making the most requests
	# and will be displayed as firefox/linux/etc. 
	echo "--Top Ten User Agents" >> apache_$FILEDATE.log
	cat access.log | awk '{print $12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23}' | sort | uniq -c | sort -n >> apache_$FILEDATE.log

}

topTenPageRequests() {
	# This should produce the top 10 requested pages and the number of each.
	echo "--Top Ten Page Requests" >> apache_$FILEDATE.log
	cat access.log | awk '{ print $7 }'| sort | uniq -c | sort -rn | head -n 25 >> apache_$FILEDATE.log
}

topUnsuccessfulRequests() {
	# This will generate a list of the most unsuccessful codes, count,IP,CODE,request
	echo "--Top unsuccessful requests and error codes" >> apache_$FILEDATE.log
	cat access.log | awk '{ if ($9 >= 400 && $9 <= 600) print $1,$7,$9 }' | sort  | uniq -c | sort -rn | head -20 >> apache_$FILEDATE.log
}

successfulPageRequests() {
	# This should give a percentage of successsful attempts.
	# We will start by getting the type of code returned.
	echo "--Response Codes" >> apache_$FILEDATE.log
	cat access.log | awk '{print $9}' | sort | uniq -c | sort -n >> apache_$FILEDATE.log
}

percentGood() {
	# This is the percent of good requests. 
	echo "--Percent of good requests" >> apache_$FILEDATE.log
	cat access.log | awk '$9 >= 200 && $9 <= 350 {count++} END {print "Average: " count*100/NR " %"}' >> apache_$FILEDATE.log
}

percentBad() {
	# This is the percent of bad requests.
	echo "--Percent of bad requests" >> apache_$FILEDATE.log
	cat access.log | awk '$9 >= 400 && $9 <= 600 {count++} END {print "Average: " count*100/NR " %"}' >> apache_$FILEDATE.log
}

topIPandPage() {
	# This is the top ten IPs and the page they requested (x5)
	echo "--Top IPs and page requested" >> apache_$FILEDATE.log
	cat access.log |awk '{print $1,$7}' | sort | uniq -c | sort -rn | head -5 >> apache_$FILEDATE.log
}

requestsPerMinute() {
	# This should print the requests per minute.
	echo "--Requests per minute" >> apache_$FILEDATE.log
	cat access.log | awk '{print $4}' | cut -d: -f 2-3 | uniq -c >> apache_$FILEDATE.log
}

topPageSuccess() {
	# This will return number of 200 plus the page called.
	# not asked for but useful information.
	echo "--Successful loads and the page requested" >> apache_$FILEDATE.log
	cat access.log | awk '{ if($9 == 200) { print $7 } }' | sort | uniq -c | sort -r | head -10 >> apache_$FILEDATE.log
#	echo "--Unsuccessful loads 500 and the page requested"
#	cat access.log | awk '{ if($9 == 500) { print $7 } }' | sort | uniq -c | sort -r | head -10 >> apache_$FILEDATE.log
}

createBadHtmlEmail() {
	# This will create an email in HTML format, it will not be pretty but will be readable I think.
	# Let's see how I can iterate this after the initial shot here.
	awk 'BEGIN{print "<table>"} {print "<tr>";for(i=1;i<=NF;i++)print "<td>" $i"</td>";print "</tr>"} END{print "</table>"}' apache_$FILEDATE.log > email_$FILEDATE.html
}

emailBadHtmlEmail() {
	# This will email the bad html email, I think.
	echo email_20150928.html | mail -a "From: sday@mac.com" -a "MIME-Version: 1.0" -a "Content-Type: text/html" -s "Apache Log Analysis: " somedude@somedomain.com

}

topTenIPs
topTenAgents
topTenPageRequests
topUnsuccessfulRequests
successfulPageRequests
percentGood
percentBad
topIPandPage
requestsPerMinute
topPageSuccess
createBadHtmlEmail
emailBadHtmlEmail
