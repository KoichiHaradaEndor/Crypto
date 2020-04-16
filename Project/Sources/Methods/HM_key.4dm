//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to set a key to HMAC object.
* When it is already set, it is replaced with the new key.
*
* The key parameter can be of type text or blob.
* When text is given, it must be Base64url encoded.
* When blob is given, it will be encoded with Base64url
* and be sotred. Then the key will be decoded when
* it is used.
*
* @param {Variant} $1 Key to set, of type text or blob
* @return {Object} HMAC object
* @author HARADA Koichi
*/

C_VARIANT:C1683($1)
C_OBJECT:C1216($0)

C_LONGINT:C283($type_l)

ASSERT:C1129(Count parameters:C259>=1;"Lack of parameters")

$type_l:=Value type:C1509($1)

ASSERT:C1129(($type_l=Is text:K8:3) | ($type_l=Is BLOB:K8:12);"Error in value type of $1")

Case of 
	: ($type_l=Is text:K8:3)
		This:C1470.data.key:=$1
		
	: ($type_l=Is BLOB:K8:12)
		This:C1470.data.key:=encodeBase64Url ($1)
		
End case 

$0:=This:C1470
