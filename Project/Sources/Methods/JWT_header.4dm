//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* Used to set header to JWT object.
*
* This method has two forms:
*
* JWT.header(header)
* @param {Object} $1 header : Object that contains full header information
* @retun {Object} $0 This object
*
* JWT.header(headerName; headerValue)
* @param {Text} $1 headerName : Header parameter name to set
* @param {Text} $2 headerValue : Header parameter value to set
* @retun {Object} $0 This object
*
* Required parameters are:
* alg : "HS256" or "HS512". "none" is not supported for security reason.
* kid : A hint that points the key used to secure JWT data.
* (Though "kid" is optional by specification, to avoid attack,
* the use of this key is mandatory. When verifying JWT, alg and kid combination
* must be checked.)
* Mandatory check and value verification will be done when generating final token,
* since the parameters may be added or altered later.
*
* @author HARADA Koichi
*/

C_VARIANT:C1683($1)
C_TEXT:C284($2;$headerValue_t)
C_OBJECT:C1216($0)

C_LONGINT:C283($type_l;$numParam_l)

$type_l:=Value type:C1509($1)
$numParam_l:=Count parameters:C259

If (This:C1470.data.header=Null:C1517)
	
	This:C1470.data.header:=New object:C1471()
	
End if 

Case of 
	: ($type_l=Is object:K8:27)
		
		This:C1470.data.header:=$1
		
	: ($type_l=Is text:K8:3) & ($numParam_l>=2)
		
		This:C1470.data.header[$1]:=$2
		
End case 

$0:=This:C1470
