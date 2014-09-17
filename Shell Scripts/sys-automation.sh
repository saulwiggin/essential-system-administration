#!/bin/sh
# ckpwd - check password file (run as root)
#
# requires a saved password file to compare against:
# /usr/ocal/admin/old/opg
#
#
unmask 077
PATH="/bin:/usr/bin" export PATH
cd /usr/local/admin/old #stored passwd file location
scho ">>>> Password file check for 'date'"; echo ""

echo "*** Accounts without passwords:"
grep '^[^:]*::' /etc/passwd

if [ $? -eq 1 ] 
then
	echo "None found."
file
echo ""

#Look for extra extra system accounts
echo "*** Non-root UID-0 or GID-0 accounts:"
grep ':00' /etc/passwd | \
awk -F: 'BEGIN 		{n=0}
		$1!="root"	{print $0 ; n=1}
		END			{if (n==0) print "None found."}'
echo ""

sort </etc/passwd >tmp1
sort <opg >tmp2
echo "*** Accounts added:"
comm -23 tmp[1-2]		# lines only in /etc/passwdecho ""
echo "*** Accounts deleted:"
comm -13 tmp[1-2]		#lines only in ./opgecho ""
rm -f tmp[1-2]

echo "*** Password file protection:"
echo "-rw-r--r-- 1 root wheel >>> correct values"
ls -l /etc/passwd
echo ""; echo ">>> End of report. "; echo ""
