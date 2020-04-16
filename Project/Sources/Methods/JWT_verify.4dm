//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method parses given JWT and verify it.
* If test passes, it returns true, otherwise false.
* Also the payload parameter receives parsed payload.
*
* In the keys parameter, pass key list whose structure
* is defined as JWK set.
*
* The algorithm value in the JWT header must match
* algorithm parameter value.
*
* Also the combination of "kid" and "alg" in the JWT header
* and JWK set must match.
*
* @param {Text} $1 JWT token
* @param {Text} $2 Algorithm HS256 or HS512
* @param {Object} $3 JWK set
* @param {Object} $4 Object that receives payload data
* @arthor HARADA Koichi
*/

C_TEXT:C284($1;$token_t)
C_TEXT:C284($2;$algorithm_t)
C_OBJECT:C1216($2;$keys_o)
C_OBJECT:C1216($3;$payload_o)
C_BOOLEAN:C305($0;$verified_b)

C_COLLECTION:C1488($token_c)
C_TEXT:C284($encodedHeader_t;$encodedPayload_t;$encodedSignature_t)
C_TEXT:C284($rawHeader_t;$rawPayload_t)
C_TEXT:C284($headerAlg_t;$headerKid_t)
C_TEXT:C284($hmac_t)
C_OBJECT:C1216($header_o;$key_o)
C_BOOLEAN:C305($stop_b)
C_LONGINT:C283($algorithm_l)

$token_t:=$1
$algorithm_t:=$2
$keys_o:=$3
$payload_o:=$4
$verified_b:=False:C215
$stop_b:=False:C215

ASSERT:C1129(compareCaseSensitive ($algorithm_t;"HS256") | compareCaseSensitive ($algorithm_t;"HS512");"Algorithm parameter value is not valid")

$token_c:=Split string:C1554($token_t;".")
If ($token_c.length#3)
	
	$stop_b:=True:C214
	
Else 
	
	$encodedHeader_t:=$token_c[0]
	$encodedPayload_t:=$token_c[1]
	$encodedSignature_t:=$token_c[2]
	
	  //#####
	  // Header verification
	  //#####
	
	$rawHeader_t:=decodeBase64Url ($encodedHeader_t)
	$header_o:=JSON Parse:C1218($rawHeader_t)
	If ($header_o.alg=Null:C1517)
		
		$stop_b:=True:C214
		
	Else 
		
		$headerAlg_t:=$header_o.alg
		
	End if 
	
	If ($header_o.kid=Null:C1517)
		
		$stop_b:=True:C214
		
	Else 
		
		$headerKid_t:=$header_o.kid
		
	End if 
	
	If (compareCaseSensitive ($headerAlg_t;$algorithm_t)=False:C215)
		
		  //The algorithm that contained in JWT header and server expectation must much
		$stop_b:=True:C214
		
	End if 
	
	If ($stop_b=False:C215)
		
		  // OK, signing method seems to be correct, find a key that was used to sign this JWT
		$key_o:=New object:C1471()
		$key_o:=JWK_findKey ($algorithm_t;$headerKid_t)
		If ($key_o.k#Null:C1517)
			
			$hmac_t:=JWT_getEncodedHMAC ($encodedHeader_t+"."+$encodedPayload_t;$algorithm_t;$key_o.k)
			$verified_b:=compareCaseSensitive ($encodedSignature_t;$hmac_t)
			
			If ($verified_b)
				
				$rawPayload_t:=decodeBase64Url ($encodedPayload_t)
				$payload_o:=JSON Parse:C1218($rawPayload_t)
				
			End if 
			
		End if 
		
	End if 
	
End if 

$0:=$verified_b
