//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* Used to set payload to JWT object.
*
* This method has two forms:
*
* JWT.payload(payload)
* @param {Object} $1 payload : Object that contains full payload information
* @retun {Object} $0 This object
*
* JWT.payload(payloadName; payloadValue)
* @param {Text} $1 payloadName : Payload parameter name to set
* @param {Variant} $2 payloadValue : Payload parameter value to set
* @retun {Object} $0 This object
*
* @author HARADA Koichi
*/

C_VARIANT:C1683($1)
C_VARIANT:C1683($2)
C_OBJECT:C1216($0)

C_LONGINT:C283($type_l;$numParam_l)

ASSERT:C1129(Count parameters:C259>=1;"Lack of parameters")

$numParam_l:=Count parameters:C259
$type_l:=Value type:C1509($1)

If (This:C1470.data.payload=Null:C1517)
	
	This:C1470.data.payload:=New object:C1471()
	
End if 

Case of 
	: ($type_l=Is object:K8:27)
		
		This:C1470.data.payload:=$1
		
	: ($numParam_l<2)
		
	Else 
		
		This:C1470.data.payload[$1]:=$2
		
End case 

$0:=This:C1470
