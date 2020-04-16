//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* Used to set header to JWT object.
*
* Important note:
* The 'alg' parameter in the JWT header will be set by
* this component by following the description of
* key parameter. The key parameter is a JWK object
* that contains 'alg' parameter, then it will be used.
* So if 'alg' is set by this function, it will be overwritten.
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
* @author HARADA Koichi
*/

C_VARIANT:C1683($1)
C_TEXT:C284($2;$headerValue_t)
C_OBJECT:C1216($0)

C_LONGINT:C283($type_l;$numParam_l)

ASSERT:C1129(Count parameters:C259>=1;"Lack of parameters")

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
