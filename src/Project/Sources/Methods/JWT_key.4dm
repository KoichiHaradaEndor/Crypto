//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to set a key to JWT object.
* When it is already set, it is replaced with the new key.
*
* The key is an object whose structure is as follows.
* example:
* {
*     "kty" : "oct", etc => key type (required by spec)
*     "alg" : "HS256" or "HS512", => algorithm  (required even though its optional under spec),
*     "kid" : "any", => key ID (required even though its optional under spec),
*     "k"   : key encoded with Base64url
* }
* Note that one of the above parameters are missing, this function does nothing.
*
* @param {Object} $1 Key to set
* @return {Object} JWT object
* @author HARADA Koichi
*/

C_OBJECT:C1216($1;$key_o)
C_OBJECT:C1216($0)

C_BOOLEAN:C305($algOK_b)

ASSERT:C1129(Count parameters:C259>=1;"Lack of parameters")

$key_o:=$1

Case of 
	: ($key_o.kty=Null:C1517)
	: (compareCaseSensitive ($key_o.kty;"oct")=False:C215)
	: ($key_o.alg=Null:C1517)
	: ($key_o.kid=Null:C1517)
	: ($key_o.kid="")
	: ($key_o.k=Null:C1517)
	: ($key_o.k="")
	Else 
		
		  // Check alg value
		$algOK_b:=True:C214
		Case of 
			: (compareCaseSensitive ($key_o.alg;"HS256"))
				
			: (compareCaseSensitive ($key_o.alg;"HS512"))
				
			Else 
				
				$algOK_b:=False:C215
				
		End case 
		
		If ($algOK_b)
			
			If (This:C1470.data.key=Null:C1517)
				
				This:C1470.data.key:=New object:C1471()
				
			End if 
			
			This:C1470.data.key:=$key_o
			
		End if 
		
End case 

$0:=This:C1470
