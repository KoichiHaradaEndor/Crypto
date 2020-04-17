//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to set message to HMAC object.
* When a message is already set, given text is appended to the original message.
*
* The message parameter can be of type text or blob.
* When text is given, it is stored and used as is.
* When blob is given, it will be encoded with Base64url
* and be sotred. Then the message will be decoded when
* it is used.
*
* For above reason, text and blob cannot be mixed.
*
* @param {Variant} $1 Message to set
* @return {Object} HMAC object
* @author HARADA Koichi
*/

C_VARIANT:C1683($1)
C_OBJECT:C1216($0)

C_LONGINT:C283($type_l)
C_BLOB:C604($message_x)

ASSERT:C1129(Count parameters:C259>=1;"Lack of parameters")

$type_l:=Value type:C1509($1)

ASSERT:C1129(($type_l=Is text:K8:3) | ($type_l=Is BLOB:K8:12);"Error in value type of $1")

Case of 
	: ($type_l=Is text:K8:3)
		
		If (This:C1470.data.message=Null:C1517)
			
			This:C1470.data.message:=$1
			
		Else 
			
			This:C1470.data.message:=This:C1470.data.message+$1
			
		End if 
		
		This:C1470.data.messageEncoded:=False:C215
		
	: ($type_l=Is BLOB:K8:12)
		
		If (This:C1470.data.message=Null:C1517)
			
			This:C1470.data.message:=base64UrlEncode ($1)
			
		Else 
			
			$message_x:=base64UrlDecode (This:C1470.data.message)
			COPY BLOB:C558($1;$message_x;0;BLOB size:C605($message_x);BLOB size:C605($1))
			This:C1470.data.message:=base64UrlEncode ($message_x)
			
		End if 
		
		This:C1470.data.messageEncoded:=True:C214
		
	Else 
		
		This:C1470.data.message:=Null:C1517
		This:C1470.data.messageEncoded:=Null:C1517
		
End case 

$0:=This:C1470
