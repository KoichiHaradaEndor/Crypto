//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method parses given JWT and verify it.
* If test passes, it returns true, otherwise false.
* Also the payload parameter receives parsed payload.
*
* In the algorithm parameter, pass an algorithm that
* was used when generating the JWT. This value must match
* with the one in the JWT header. If not, verification fails.
*
* If they matched, then a key will be queried by using
* the alg and the kid specidfied in the JWT header.
*
* The payload parameter must be initialized using
* New object command in the caller method before
* verifying. Otherwise it will not receive the content.
*
* @param {Text} $1 JWT token
* @param {Text} $2 Algorithm
* @param {Object} $3 Object that receives payload data
* @return {Boolean} $0 True if verificatios passes, otherwise false.
* @arthor HARADA Koichi
*/

C_TEXT:C284($1;$token_t)
C_TEXT:C284($2;$algorithm_t)
C_OBJECT:C1216($3;$payload_o)
C_BOOLEAN:C305($0;$verified_b)

C_COLLECTION:C1488($token_c)
C_TEXT:C284($encodedHeader_t;$encodedPayload_t;$encodedSignature_t)
C_TEXT:C284($rawHeader_t;$rawPayload_t;$hmac_t;$propertyName_t)
C_OBJECT:C1216($header_o;$jwk_o;$key_o;$payloadToCopy_o)
C_BOOLEAN:C305($algChecked_b)
C_BLOB:C604($rawHeader_x;$rawPayload_x)

$token_t:=$1
$algorithm_t:=$2
$payload_o:=$3
$verified_b:=False:C215

$token_c:=Split string:C1554($token_t;".")
If ($token_c.length=3)
	
	$encodedHeader_t:=$token_c[0]
	$encodedPayload_t:=$token_c[1]
	$encodedSignature_t:=$token_c[2]
	
End if 

  //#####
  // Algorithm verification
  //#####
$algChecked_b:=False:C215
If ($encodedHeader_t#"")
	
	$rawHeader_x:=base64UrlDecode ($encodedHeader_t)
	$rawHeader_t:=Convert to text:C1012($rawHeader_x;"UTF-8")
	$header_o:=JSON Parse:C1218($rawHeader_t)
	
	If ($header_o.alg#Null:C1517)
		
		$algChecked_b:=compareCaseSensitive ($header_o.alg;$algorithm_t)
		
	End if 
	
End if 

$key_o:=Null:C1517
If ($algChecked_b)
	
	  // The algorithm in the SWT header matches the expected one,
	  // so we can proceed
	
	If ($header_o.kid#Null:C1517)
		
		$jwk_o:=new JWK ()
		$key_o:=New object:C1471()
		$key_o:=$jwk_o.find($algorithm_t;$header_o.kid)
		
	End if 
	
End if 

If ($key_o#Null:C1517)
	
	  // Key that matches alg and kid is found
	  // Verify JWT
	If ($key_o.k#Null:C1517)
		
		$hmac_t:=JWT_getEncodedHMAC ($encodedHeader_t+"."+$encodedPayload_t;$algorithm_t;$key_o.k)
		$verified_b:=compareCaseSensitive ($encodedSignature_t;$hmac_t)
		
		If ($verified_b)
			
			$rawPayload_x:=base64UrlDecode ($encodedPayload_t)
			$rawPayload_t:=Convert to text:C1012($rawPayload_x;"UTF-8")
			$payloadToCopy_o:=JSON Parse:C1218($rawPayload_t)
			
			  // Return the payload content to the payload parameter
			  // Caution: assigning payload object directly to the payload 
			  // parameter will cause that caller method losts payload object
			  // reference. 
			
			  // Remove the current content of the payload parameter
			If ($payload_o#Null:C1517)
				
				For each ($propertyName_t;$payload_o)
					
					OB REMOVE:C1226($payload_o;$propertyName_t)
					
				End for each 
				
				  // Then append payload content
				For each ($propertyName_t;$payloadToCopy_o)
					
					$payload_o[$propertyName_t]:=$payloadToCopy_o[$propertyName_t]
					
				End for each 
				
			End if   // /If ($payload_o#Null)
			
		End if   // /If ($verified_b)
		
	End if   // /If ($key_o.k#Null)
	
End if   // /If ($key_o#Null)

$0:=$verified_b
