$HOME/build/zk/bin/zkCli.sh -server localhost:2181 quit > zkstatus
grep "Socket connection established to localhost*" zkstatus > /dev/null 2>&1
if [ $? -eq 0 ]
then
rm -rf zkstatus
exit 0
else
rm -rf zkstatus
exit 1
fi
