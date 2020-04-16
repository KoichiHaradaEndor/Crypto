//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
/**
* This method creates and returns HMAC object.
* 
* For digest parameter, only "sha256" (SHA256 digest) or
* "sha512" (SHA512 digest) are supported.
*
* The key parameter can be of type text or blob.
* When text is given, it must be Base64url encoded.
* When blob is given, it will be encoded with Base64url
* and be sotred.
*
* @param {Text} $1 Message to hash
* @param {Variant} $2 Key to set, of type text or blob
* @param {Variant} $3 Digest algorithm SHA256 and SHA512 can be used
* @return {Object} $0 HMAC object
* @author: HARADA Koichi
*/

C_VARIANT:C1683($1)  //Message
C_VARIANT:C1683($2)  // Key
C_VARIANT:C1683($3)  // Algorithm
C_OBJECT:C1216($0;$hmac_o)

C_LONGINT:C283($numParam_l)

$hmac_o:=New object:C1471()
$numParam_l:=Count parameters:C259

  //#####
  // Methods
  //#####

$hmac_o.algorithm:=Formula:C1597(HM_algorithm )
$hmac_o.hexDigest:=Formula:C1597(HM_hexDigest )
$hmac_o.message:=Formula:C1597(HM_message )
$hmac_o.key:=Formula:C1597(HM_key )

  //#####
  // Properties
  //#####
$hmac_o.data:=New object:C1471()

If ($numParam_l>=1)
	
	$hmac_o.message($1)
	
End if 

If ($numParam_l>=2)
	
	$hmac_o.key($2)
	
End if 

If ($numParam_l>=3)
	
	$hmac_o.algorithm($3)
	
End if 

$0:=$hmac_o
