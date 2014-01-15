#!/bin/bash
export DISPLAY=:0
echo Content-type: text/html
echo ""

function card_name {
        NAME=`DISPLAY=:0 sudo aticonfig --adapter=$1 --odgc|grep -E 'AMD|ATI'|sed 's/Adapter . - //'`
        echo $NAME
}

echo "<HTML>
        <HEAD><TITLE>video card $1 stats</TITLE>
        </HEAD>
        <BODY bgcolor=\"#cccccc\" text=\"#000000\">"

if [ $# -gt 0 ]; then
	CARD=$1
        EDIT=0
        SET=0
        EDITFAN=0
        SETFAN=0
	if [ $# -gt 1 ]; then
   		CARD=`echo "$1"|cut -d'#' -f1`
		EDIT=`echo "$@"|grep -i 'edit_freq'|wc -l`
		SET=`echo "$@"|grep -i 'set_freq'|wc -l`
		EDITFAN=`echo "$@"|grep -i 'edit_fan'|wc -l`
		SETFAN=`echo "$@"|grep -i 'set_fan'|wc -l`
	fi
fi

#echo $CARD=$1
#echo EDIT=$EDIT
#echo SET=$SET
#echo EDITFAN=$EDITFAN
#echo SETFAN=$SETFAN

if [[ "$CARD" =~ ^[0-9]+$ ]] ; then
	if [ $SET -gt 0 ] || [ $SETFAN -gt 0 ]; then
		POST_DATA=$(</dev/stdin)
		echo $POST_DATA
		if [ $SET -gt 0 ]; then
			RANGE=`aticonfig --adapter=$1 --odgc|grep 'Configurable Peak Range'|awk '{print $5}'|sed 's/[][]//g'`
			MAX=`echo $RANGE|cut -d'-' -f 2`
			MIN=`echo $RANGE|cut -d'-' -f 1`
                	SETVAL=`echo "$POST_DATA"|grep 'Clock'|cut -d'=' -f2`
			if [ $SETVAL -ge $MIN -a $SETVAL -le $MAX ]; then
				sudo aticonfig --adapter=$1 --odsc=$SETVAL,0;
				sudo aticonfig --adapter=$1 --odcc	
			fi
		fi
		if [ $SETFAN -gt 0 ]; then
			SETVAL=`echo "$POST_DATA"|grep 'Fan'|cut -d'=' -f2`
			echo SETVAL;
                        if [ $SETVAL -ge 10 -a $SETVAL -le 100 ]; then
                                DISPLAY=:0.$CARD sudo aticonfig --pplib-cmd "set fanspeed 0 $SETVAL";
                        fi
		fi
		echo "<meta http-equiv=\"refresh\" content=\"1;URL=stats.sh?$CARD\" />"	
	else
	 	if [ $EDIT -lt 1 -a $EDITFAN -lt 1 ]; then
			echo "<meta http-equiv=\"refresh\" content=\"10\" >"
		fi;
		echo "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
                <tr bgcolor=\"#D8D8D8\">
                        <td  height=\"25\" style=\"font-size: 160%; font-family: sans-serif\">"
                card_name $1
                echo " stats</td>
                </tr>
                <td width=\"100%\">"
                        echo "Max Freq: "
				if [ $EDIT -gt 0 ]; then
				RANGE=`aticonfig --adapter=$1 --odgc|grep 'Configurable Peak Range'|awk '{print $5}'|sed 's/[][]//g'`
				echo $RANGE
					echo "<form action="/cgi-bin/stats.sh?$CARD+set_freq" method="post">
						<input type="text" name="Clock" size="5" value=\"`sudo aticonfig --adapter=$1 --odgc|grep 'Current Peak'|awk '{print $4}'`\"></input>
						<input type=SUBMIT value="Set clocks">
					<form>"
				else
					echo "<a href=\"stats.sh?$1+edit_freq\">"`sudo aticonfig --adapter=$1 --odgc|grep 'Current Peak'|awk '{print $4}'`"</a>"
				fi
                echo "</td>
                <tr>
                <td width=\"100%\">"
                        echo Load: `sudo aticonfig --adapter=$1 --odgc|grep 'GPU load'|awk '{print $4}'`
                echo "</td>
                </tr>
                <tr>
                <td width=\"100%\">"
                        echo Temp: `sudo aticonfig --adapter=$1 --odgt|grep 'Temperature'|awk '{print $5}'`
		echo "</td>
                </tr>
                <tr>
                <td width=\"100%\">"
                        echo Fan Speed:
			if [ $EDITFAN -gt 0 ]; then
                                echo 10-100
                                        echo "<form action="/cgi-bin/stats.sh?$CARD+set_fan" method="post">
                                                <input type="text" name="Fan" size="5" value=\"`/opt/monscripts/fan.sh $CARD`\"></input>
                                                <input type=SUBMIT value="Set speed">
                                        <form>"
                                else   
                                        echo "<a href=\"stats.sh?$1+edit_fan\">"`/opt/monscripts/fan.sh $CARD`"</a>"
                                fi
                echo "</td>
                </tr>"
		if [ $EDIT -lt 1 -a $EDITFAN -lt 1 ]; then
                echo "<tr width=\"100%\">
                	<td>
                        <form action=\"mine.sh\">
                        <input type=\"submit\" value=\"Go back\">
                        </form>
                	</td>"
		fi
                echo "</tr>
		</table>"
	fi
fi

echo "</BODY>
        </HTML>"
