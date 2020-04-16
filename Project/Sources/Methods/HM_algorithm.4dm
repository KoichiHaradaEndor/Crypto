//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sets algorithm parameter.
* It accepts text literal or 4D constant (Digest theme).
* 
* Only "sha256" (SHA256 digest) or "sha512" (SHA512 digest)
* are supported.
*
* @param {Longint} $1 Digest algorithm SHA256 and SHA512 can be used
* @return {Object} $0 HMAC object
* @author: HARADA Koichi
*/

C_VARIANT:C1683($1)
C_OBJECT:C1216($0)

C_LONGINT:C283($algorithm_l;$type_l)
C_TEXT:C284($algorithm_t)

ASSERT:C1129(Count parameters:C259>=1;"Lack of parameters")

$type_l:=Value type:C1509($1)

ASSERT:C1129(($type_l=Is text:K8:3) | ($type_l=Is real:K8:4) | ($type_l=Is longint:K8:6);"Error in value type of $1")

Case of 
	: ($type_l=Is text:K8:3)
		
		$algorithm_t:=$1
		
		Case of 
			: ($algorithm_t="sha256")
				This:C1470.data.algorithm:=SHA256 digest:K66:4
				
			: ($algorithm_t="sha512")
				This:C1470.data.algorithm:=SHA512 digest:K66:5
				
			Else 
				ASSERT:C1129(False:C215;"Given digest algorithm is not supported.")
				
		End case 
		
	: ($type_l=Is real:K8:4) | ($type_l=Is longint:K8:6)
		
		$algorithm_l:=$1
		
		Case of 
			: ($algorithm_l=SHA256 digest:K66:4)
				This:C1470.data.algorithm:=SHA256 digest:K66:4
				
			: ($algorithm_l=SHA512 digest:K66:5)
				This:C1470.data.algorithm:=SHA512 digest:K66:5
				
			Else 
				ASSERT:C1129(False:C215;"Given digest algorithm is not supported.")
				
		End case 
		
End case 

$0:=This:C1470
