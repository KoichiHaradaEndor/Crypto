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
* Both "alg" and "kid" parameters are included in key object and they are
* used. Event though those parameters are specified in header, it will be
* ignored and overwritten.
* If those parameters are not included in key object, JWT will not be generated.
*
* @return {Text} JWT text
* @author HARADA Koichi
*/

C_TEXT:C284($0;$jwt_t)

C_TEXT:C284($header_t;$payload_t;$key_t;$alg_t;$hmac_t)
C_LONGINT:C283($algorithm_l)
C_OBJECT:C1216($hmac_o)
C_BLOB:C604($key_x;$hmac_x)

Case of 
	: (This:C1470.data.header=Null:C1517)
	: (This:C1470.data.payload=Null:C1517)
	: (This:C1470.data.key=Null:C1517)
	: (This:C1470.data.key.alg=Null:C1517)
	: (compareCaseSensitive (This:C1470.data.key.alg;"HS256")=False:C215) & (compareCaseSensitive (This:C1470.data.key.alg;"HS512")=False:C215)
	: (This:C1470.data.key.kid=Null:C1517)
	: (This:C1470.data.key.kid="")
	: (This:C1470.data.key.k=Null:C1517)
	: (This:C1470.data.key.k="")
	Else 
		
		This:C1470.data.header.alg:=This:C1470.data.key.alg
		This:C1470.data.header.kid:=This:C1470.data.key.kid
		
		$header_t:=JSON Stringify:C1217(This:C1470.data.header)
		$payload_t:=JSON Stringify:C1217(This:C1470.data.payload)
		$key_t:=This:C1470.data.key.k
		$alg_t:=This:C1470.data.header.alg
		
		  // Base64url encoding
		$header_t:=encodeBase64Url ($header_t)
		$payload_t:=encodeBase64Url ($payload_t)
		
		  // Signing
		$jwt_t:=$header_t+"."+$payload_t+"."+JWT_getEncodedHMAC ($header_t+"."+$payload_t;$alg_t;$key_t)
		
End case 

$0:=$jwt_t
