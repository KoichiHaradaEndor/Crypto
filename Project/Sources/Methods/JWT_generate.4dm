//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method generates digested JWT digest based on
* the values stored in this object, then returns it.
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
* @return {Text} JWT text
* @author HARADA Koichi
*/

C_TEXT:C284($0;$jwt_t)

C_TEXT:C284($header_t;$payload_t;$key_t;$alg_t;$hmac_t)
C_LONGINT:C283($algorithm_l)
C_OBJECT:C1216($hmac_o)
C_BLOB:C604($hmac_x)

Case of 
	: (This:C1470.data.header=Null:C1517)
	: (This:C1470.data.header.alg=Null:C1517)
	: (This:C1470.data.header.alg#"HS256") & (This:C1470.data.header.alg#"HS512")
	: (This:C1470.data.header.kid=Null:C1517)
	: (This:C1470.data.payload=Null:C1517)
	: (This:C1470.data.key=Null:C1517)
	: (This:C1470.data.key="")
	Else 
		
		$header_t:=JSON Stringify:C1217(This:C1470.data.header)
		$payload_t:=JSON Stringify:C1217(This:C1470.data.payload)
		$key_t:=This:C1470.data.key
		$alg_t:=This:C1470.data.header.alg
		
		Case of 
			: ($alg_t="HS256")
				$algorithm_l:=SHA256 digest:K66:4
				
			: ($alg_t="HS512")
				$algorithm_l:=SHA512 digest:K66:5
				
		End case 
		
		  // Base64url encoding
		$header_t:=encodeBase64Url ($header_t)
		$payload_t:=encodeBase64Url ($payload_t)
		SET TEXT TO PASTEBOARD:C523($header_t+"."+$payload_t)
		  // Signing
		$hmac_t:=new HMAC ()\
			.key($key_t)\
			.message($header_t+"."+$payload_t)\
			.algorithm($algorithm_l)\
			.hexDigest()
		
		SET BLOB SIZE:C606($hmac_x;0)
		$hmac_x:=hexToBlob ($hmac_t)
		
		$hmac_t:=encodeBase64Url ($hmac_x)
		$jwt_t:=$header_t+"."+$payload_t+"."+$hmac_t
		
End case 

$0:=$jwt_t
