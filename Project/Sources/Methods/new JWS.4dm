//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
/**
* This method creates and return JWS object.
*
* Required parameters are:
* # Header
* alg : "HS256" or "HS512". "none" is not supported for security reason.
* kid : A hint that points the key used to secure JWS data.
* (Though "kid" is optional according to specification, to avoid attack,
* the use of this key is mandatory. When verifying JWS, alg and kid combination
* must be checked.)
* Mandatory check will be done when generating JWS, since the keys
* may be added later.
*
* @param {Object} $1 Header
* @param {Object} $2 Payload
* @param {Text} $3 Key
* @return {Object} $0 JWS object
* @author: HARADA Koichi
*/

C_OBJECT:C1216($1)  // header
C_OBJECT:C1216($2)  // payload
C_TEXT:C284($3)  // key
C_OBJECT:C1216($0;$jws_o)

C_LONGINT:C283($numParam_l)

$jws_o:=New object:C1471()
$numParam_l:=Count parameters:C259

If ($numParam_l>=1)
	
	$jws_o.header:=$1
	
End if 

If ($numParam_l>=2)
	
	$jws_o.payload:=$2
	
End if 

If ($numParam_l>=3)
	
	$jws_o.key:=$3
	
End if 


$0:=$jws_o
