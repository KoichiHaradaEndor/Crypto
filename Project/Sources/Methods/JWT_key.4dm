//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to set key to JWT object.
* When it is already set, it is replaced with the new key.
*
* The key is a object that follows JWK specification.
*
* @param {Text} $1 Key to set
* @return {Object} JWT object
* @author HARADA Koichi
*/

C_OBJECT:C1216($1;$key_o)
C_OBJECT:C1216($0)

$key_t:=$1

If (This:C1470.data.key=Null:C1517)
	
	This:C1470.data.key:=New object:C1471()
	
End if 

This:C1470.data.key:=$key_t

$0:=This:C1470
