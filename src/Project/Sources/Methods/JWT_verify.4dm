//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method parses given JWT and verify it.
* If test passes, it returns true, otherwise false.
* Also the payload parameter receives parsed payload.
*
* The payload parameter must be initialized using
* New object command in the caller method before
* verifying. Otherwise it will not receive the content.
*
* In the algorithm parameter, pass an algorithm that
* was used when generating the JWT. This value must match
* with the one in the JWT header. If not, verification fails.
*
* If it matches, then a key is queried by using
* the alg and the kid specidfied in the JWT header.
* Then the signature is verified.
*
* If "exp" and/or "nbf" claim are specified in the payload,
* they are checked.
* exp  : (IntDate) Expiration Time, must after current IntDate
* nbf  : (IntDate) Not Before, must before current IntDate
*
* In the optional extraVerification parameter, you can
* pass some elements that will be used as additional
* verification element. Supported elements are:
* iss  : (Text) Issuer, case sensitive exact match
* nonce: (Text) Random value, case sensitive exact match
*
* If one of these are specified, each element is checked
* with the one in the payload. If one of the specified element
* does not included in the payload, verification fails.
*
* @param {Text} $1 JWT token
* @param {Text} $2 Algorithm
* @param {Object} $3 Object that receives payload data
* @param {Object} $4 Extra verification values
* @return {Boolean} $0 True if verificatios passes, otherwise false.
* @arthor HARADA Koichi
*/

C_TEXT:C284($1;$token_t)
C_TEXT:C284($2;$algorithm_t)
C_OBJECT:C1216($3;$payload_o)
C_OBJECT:C1216($4;$extraVerification_o)
C_BOOLEAN:C305($0;$verified_b)

C_COLLECTION:C1488($token_c)
C_TEXT:C284($encodedHeader_t;$encodedPayload_t;$encodedSignature_t)
C_TEXT:C284($rawHeader_t;$rawPayload_t;$hmac_t;$propertyName_t)
C_OBJECT:C1216($header_o;$jwk_o;$key_o;$payloadToCopy_o)
C_BOOLEAN:C305($algChecked_b)
C_BLOB:C604($rawHeader_x;$rawPayload_x)
C_LONGINT:C283($numParam_l;$currentIntDate_l)

$numParam_l:=Count parameters:C259

$token_t:=$1
$algorithm_t:=$2
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
	
	  // The algorithm in the JWT header matches the expected one,
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
		
	End if   // /If ($key_o.k#Null)
	
End if   // /If ($key_o#Null)

If ($verified_b)
	
	  // Checks payload
	$rawPayload_x:=base64UrlDecode ($encodedPayload_t)
	$rawPayload_t:=Convert to text:C1012($rawPayload_x;"UTF-8")
	$payloadToCopy_o:=JSON Parse:C1218($rawPayload_t)
	
	  // check exp and nbf if specified
	  // exp  : (IntDate) Expiration Time, must after current IntDate
	Case of 
		: ($verified_b=False:C215)
			
		: ($payloadToCopy_o.exp=Null:C1517)  // exp does not exist in the payload 
			
		: (Value type:C1509($payloadToCopy_o.exp)#Is real:K8:4) & (Value type:C1509($payloadToCopy_o.exp)#Is longint:K8:6)
			$verified_b:=False:C215
			
		Else 
			
			$currentIntDate_l:=toIntDate ()
			$verified_b:=($payloadToCopy_o.exp>$currentIntDate_l)
			
	End case 
	
	  // nbf  : (IntDate) Not Before, must before current IntDate
	Case of 
		: ($verified_b=False:C215)
			
		: ($payloadToCopy_o.nbf=Null:C1517)  // nbf does not exist in the payload 
			
		: (Value type:C1509($payloadToCopy_o.nbf)#Is real:K8:4) & (Value type:C1509($payloadToCopy_o.nbf)#Is longint:K8:6)
			$verified_b:=False:C215
			
		Else 
			
			$currentIntDate_l:=toIntDate ()
			$verified_b:=($payloadToCopy_o.nbf<=$currentIntDate_l)
			
	End case 
	
End if 

If ($verified_b)
	
	If ($numParam_l>=4)
		
		  // Extra verification parameter was passed
		$extraVerification_o:=$4
		
		  // iss  : (Text) Issuer, case sensitive exact match
		Case of 
			: ($verified_b=False:C215)
			: ($extraVerification_o.iss=Null:C1517)
			: (Value type:C1509($extraVerification_o.iss)#Is text:K8:3)
				$verified_b:=False:C215
				
			: ($payloadToCopy_o.iss=Null:C1517)  // iss does not exist in the payload 
				$verified_b:=False:C215
				
			: (Value type:C1509($payloadToCopy_o.iss)#Is text:K8:3)
				$verified_b:=False:C215
				
			Else 
				$verified_b:=compareCaseSensitive ($payloadToCopy_o.iss;$extraVerification_o.iss)
				
		End case 
		
		  // nonce: (Text) Random value, case sensitive exact match
		Case of 
			: ($verified_b=False:C215)
			: ($extraVerification_o.nonce=Null:C1517)
			: (Value type:C1509($extraVerification_o.nonce)#Is text:K8:3)
				$verified_b:=False:C215
				
			: ($payloadToCopy_o.nonce=Null:C1517)  // nonce does not exist in the payload 
				$verified_b:=False:C215
				
			: (Value type:C1509($payloadToCopy_o.nonce)#Is text:K8:3)
				$verified_b:=False:C215
				
			Else 
				$verified_b:=compareCaseSensitive ($payloadToCopy_o.nonce;$extraVerification_o.nonce)
				
		End case 
		
	End if   // /If ($numParam_l>=4)
	
	Case of 
		: ($numParam_l<3)
			
		: ($verified_b=False:C215)
			
		Else 
			
			  // Return the payload content to the payload parameter
			  // Caution: assigning payload object directly to the payload 
			  // parameter will cause caller method losts payload object
			  // reference. 
			$payload_o:=$3
			
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
			
	End case 
	
End if 

$0:=$verified_b
