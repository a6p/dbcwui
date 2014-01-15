#!/bin/bash
#www-data ALL=NOPASSWD: /usr/bin/aticonfig /sbin/halt /sbin/reboot #for ubuntu
#Defaults:apache !requiretty
#apache ALL=NOPASSWD: /usr/bin/aticonfig /sbin/halt /sbin/reboot /etc/init.d/cgminer#for redhat,centos
DISPLAY=:0
HOSTNAME=`hostname`
CARDCOUNT=`DISPLAY=:0 sudo aticonfig --lsa|grep -E 'AMD|ATI'|wc -l`
ICON='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
AABJRU5ErkJggg=='

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
		icon)
			echo Content-type: image/png
                	echo ""
                	echo "$ICON"|base64 -d
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
