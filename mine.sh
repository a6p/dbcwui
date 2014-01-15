#!/bin/bash
#www-data ALL=NOPASSWD: /usr/bin/aticonfig /sbin/halt /sbin/reboot #for ubuntu
#Defaults:apache !requiretty
#apache ALL=NOPASSWD: /usr/bin/aticonfig /sbin/halt /sbin/reboot /etc/init.d/cgminer#for redhat,centos
DISPLAY=:0
HOSTNAME=`hostname`
CARDCOUNT=`DISPLAY=:0 sudo aticonfig --lsa|grep -E 'AMD|ATI'|wc -l`

function card_temp {
        RESULT=`DISPLAY=:0 /usr/bin/aticonfig --adapter=$1 --odgt 2>/dev/null|grep Temperature|awk '{print $5}'`;
        if [ -z $RESULT ]; then
                CARD_TEMP=0;
        else
                CARD_TEMP=$RESULT;
        fi;

        if [ ${CARD_TEMP/\.*} -ge 80 ]; then
                echo "<td width=\"100\" height=\"30\" border=\"1\" style=\"background: #FE2E2E\"><center>$CARD_TEMP"
        else
                if [ ${CARD_TEMP/\.*} -ge 70 ]; then
                        echo "<td width=\"100\" height=\"30\" border=\"1\" style=\"background: #F5A9A9\"><center>$CARD_TEMP"
                else
                        echo "<td width=\"100\" height=\"30\" border=\"1\" style=\"background: #BEF781\"><center>$CARD_TEMP";
                fi
        fi

}

function hashes {
	HASHES=`echo "{\"command\":\"gpu\",\"parameter\":\"$1\"}" | nc 127.0.0.1 4028 | sed 's/\x0$//' | python -mjson.tool 2>/dev/null|grep "MHS 5s"|cut -d':' -f2|sed 's/,//g'|sed 's/ //g'`
	if [ -z $HASHES ]; then
        	HASHES=0;
	fi;
	echo $HASHES;
}

function card_status {
	RESULT=`DISPLAY=:0 /usr/bin/aticonfig --adapter=$1 --od-getclocks 2>/dev/null|grep  'GPU load'|awk '{print $4}'|sed 's/[%]//g'`;
        if [ -z $RESULT ]; then
                CARD_LOAD=0;
        else
                CARD_LOAD=$RESULT;
        fi;
	
	if [ $CARD_LOAD -lt 20 ]; then
		echo "<td width=\"100\" height=\"30\" border=\"1\" style=\"background: #FE2E2E\"><center>err"
	else 
		if [ $CARD_LOAD -lt 50 ]; then
			echo "<td width=\"100\" height=\"30\" border=\"1\" style=\"background: #F5A9A9\"><center>warn"
		else	
			echo "<td width=\"100\" height=\"30\" border=\"1\" style=\"background: #BEF781\"><center>ok";
		fi
	fi		
}

function card_name {
	NAME=`DISPLAY=:0 sudo aticonfig --adapter=$1 --odgc|grep -E 'AMD|ATI'|sed 's/.*Adapter . - //'`
	echo $NAME
}

if [ $# = 0 ]; then
	echo Content-type: text/html
	echo ""
	echo "<meta http-equiv=\"refresh\" content=\"10\" >"
	PROCESS=`ps aux|grep cgminer|grep -v 'grep'|wc -l`
	if [ $PROCESS -gt 0 ]; then
		echo "
 			<HTML>
 			<HEAD><TITLE>$HOSTNAME</TITLE>
  			</HEAD>
  			<BODY bgcolor=\"#cccccc\" text=\"#000000\">
			<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"5\">
			
   			<tr align=\"center\" bgcolor=\"#999999\">
				<td><img src=\"../icons/lite.png\" alt=\"Logo\"</td>
    				<td colspan=\"4\" style=\"font-size: 160%; font-family: sans-serif\">MINER STATS FOR $HOSTNAME</td>
   			</tr>"
		for (( CARD=0; CARD<$CARDCOUNT; CARD++ )); do
   			echo "
			<tr>"
				card_status $CARD
				echo "</center></td>
    				<td>"
				hashes $CARD
				echo "
				</td>
                                <td>"
				card_temp $CARD
				echo "
				</td>
    				<td>
      					<a href=\"stats.sh?$CARD\">"
				card_name $CARD
				echo "</a><Br>
    				</td>
   			</tr>"
		done
   		echo "
			<tr>	
			<td width=\"120\" height=\"25\" border=\"1\" style=\"background: #111111\"><center><font size=\"5\" color=\"white\" face=\"Arial\">"
		echo -n devs|nc localhost 4028|sed -s 's/,/\n/g'|sed -s 's/|/\n/g'| sed 's/\x0$//' | grep 'MHS 5' |cut -d"=" -f 2| awk '{ sum+=$1} END {print sum}'	
		echo	"M</font></center></td>
    			<td colspan=\"4 width=\"100\" height=\"10\" border=\"1\" style=\"background: #444444\"><font size=\"3\" color=\"white\" face=\"Arial\">    BALLANCE $(count=$(cat /tmp/ltccount 2>/dev/null);if [ -z $count ]; then echo 0; else echo $count;fi)LTC</font></td>
   			</tr>
  			</table>	
  			
			<br>
			<br>
			<center><table width=\"300\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\">
			<tr align=\"center\" bgcolor=\"#D8D8D8\">
                        	<td  height=\"25\" colspan=\"3\" style=\"font-size: 160%; font-family: sans-serif\">Control panel</td>
                	</tr>
			<tr align=\"center\" bgcolor=\"#BDBDBD\" border=\"1\" cellspacing=\"2\">
			<td height=\"25\" width=\"33%\" border=\"1\"><center>
				<a href=\"mine.sh?reboot\">Reboot</a>
			</center></td>
			<td height=\"25\" width=\"33%\"><center>
                        	<a href=\"mine.sh?halt\">Halt</a>
                	</center></td>
			<td height=\"25\" width=\"33%\"><center>
                                <a href=\"mine.sh?stop\">Stop</a>
                        </center></td>
			</tr>
			</table></center>
			</BODY>
  			</HTML>"
	else
		echo "
                        <HTML>
                        <HEAD><TITLE>$HOSTNAME</TITLE>
                        </HEAD>
                        <BODY bgcolor=\"#cccccc\" text=\"#000000\">
                        <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\">
                        <tr align=\"center\" bgcolor=\"#F5A9A9\">
                                <td><img src=\"../icons/lite.png\" alt=\"Logo\"</td>
                                <td style=\"font-size: 160%; font-family: sans-serif\">CGMINER NOT STARTED</td>
                        </tr>
			<tr align=\"center\" >
                                <td colspan=\"2\" style=\"font-size: 160%; font-family: sans-serif\"><a href=\"mine.sh?start\">Start</a></td>
                        </tr>
			</BODY>
                        </HTML>"

	fi
else
	case $1 in
		reboot)
  			echo Content-type: text/html
	                echo ""
        	        echo "<meta http-equiv=\"refresh\" content=\"100\" >"
			echo reboot
                	sudo /sbin/reboot
  		;;
		halt)
  			echo Content-type: text/html
                	echo ""
			echo "<meta http-equiv=\"refresh\" content=\"100\" >"
                	echo halt
                	sudo /sbin/halt
		;;
		start)
	                echo Content-type: text/html
        	        echo ""
                	echo "<head>
                        	<meta http-equiv=\"refresh\" content=\"1;URL=mine.sh\" />
                        	</head> "
			sudo /etc/init.d/cgminer-lite start 2>/dev/null>/dev/null
  		;;
		stop)
			echo Content-type: text/html
                	echo ""
                	echo "<head>
                        	<meta http-equiv=\"refresh\" content=\"1;URL=mine.sh\" />
                        	</head> "
			sudo /etc/init.d/cgminer-lite stop 2>/dev/null>/dev/null
		;;
		*)
  			echo Content-type: text/html
                        echo ""
                        echo "<head>
                                <meta http-equiv=\"refresh\" content=\"1;URL=mine.sh\" />
                                </head> "

  		;;
	esac
fi
