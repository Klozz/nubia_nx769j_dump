#!/system/bin/sh
cd /acct
cat /acct/cpuacct.usage*
#for uid_cpu in `ls -d uid_*`; do usage=`cat $uid_cpu/cpuacct.usage`; usage=`expr $usage / 1000000`; echo "$uid_cpu     $usage";echo 0 > $uid_cpu/cpuacct.usage;done | sort -n -r
echo 0 > /acct/cpuacct.usage
