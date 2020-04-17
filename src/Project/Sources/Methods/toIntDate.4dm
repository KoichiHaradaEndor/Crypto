//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to convert 4D date and time to an IntDate.
* IntDate is UNIX origin time (seconds from 1970-01-01 00:00:00)
*
* If date and time parameters are omitted, current date and time
* are used.
*
* Consideration:
* Max number of 4D's longint is (2^31)-1 (2,147,483,647)
* (2^31)-1 / 60 / 60 / 24 / 365 is approx. 68.
* 1970 + 68 = 2038 
*
* @param {Date} 
* @param {Time} 
* @return {Longint} IntDate
*/

C_DATE:C307($1;$date_d)
C_TIME:C306($2;$time_h)
C_LONGINT:C283($0;$intDate_l)

C_LONGINT:C283($numParam_l)
C_DATE:C307($base_d)

$numParam_l:=Count parameters:C259

If ($numParam_l>=2)
	
	$date_d:=$1
	$time_h:=$2
	
Else 
	
	$date_d:=Current date:C33
	$time_h:=Current time:C178
	
End if 

$intDate_l:=0

$base_d:=Add to date:C393(!00-00-00!;1970;1;1)
$intDate_l:=(($date_d-$base_d)*(24*60*60))+($time_h+0)

$0:=$intDate_l
