//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method calculates HMAC digest based on
* the values stored in this object, then returns it.
*
* @return {Text} Digest text
* @author HARADA Koichi
*/

C_TEXT:C284($0;$hmac_t)

C_TEXT:C284($message_t;$key_t;$command_t;$error_t)
C_LONGINT:C283($algorithm_l;$blockSize_l)
C_BLOB:C604($key_x)

Case of 
	: (This:C1470.data.message=Null:C1517)
	: (This:C1470.data.key=Null:C1517)
	: (This:C1470.data.key="")
	: (This:C1470.data.algorithm=Null:C1517)
	: (This:C1470.data.algorithm#SHA256 digest:K66:4) & (This:C1470.data.algorithm#SHA512 digest:K66:5)
	Else 
		
		$message_t:=This:C1470.data.message
		$key_t:=This:C1470.data.key
		$algorithm_l:=This:C1470.data.algorithm
		
		Case of 
			: ($algorithm_l=SHA256 digest:K66:4)
				$blockSize_l:=64
				
			: ($algorithm_l=SHA512 digest:K66:5)
				$blockSize_l:=128
				
		End case 
		
		  // Key preprocess
		CONVERT FROM TEXT:C1011($key_t;"UTF-8";$key_x)
		
		If (BLOB size:C605($key_x)>$blockSize_l)
			
			  // When the given key length is greater than hash's block size,
			  // hashing down first
			$key_t:=Generate digest:C1147($key_x;$algorithm_l)
			$key_x:=hexToBlob ($key_t)
			
		End if 
		
		  // then padding to the right with 0x00 up to the block size.
		SET BLOB SIZE:C606($key_x;$blockSize_l;0x0000)
		
		  // create ipad and opad keys
		SET BLOB SIZE:C606($ipadKey_x;$blockSize_l;0x0036)
		SET BLOB SIZE:C606($opadKey_x;$blockSize_l;0x005C)
		
		For ($i;0;$blockSize_l-1)
			
			$ipadKey_x{$i}:=$key_x{$i} ^| $ipadKey_x{$i}
			$opadKey_x{$i}:=$key_x{$i} ^| $opadKey_x{$i}
			
		End for 
		
		  // The first hash H(K XOR ipad, M)
		CONVERT FROM TEXT:C1011($message_t;"UTF-8";$message_x)
		
		  // ipadkey concat message
		COPY BLOB:C558($message_x;$ipadKey_x;0;BLOB size:C605($ipadKey_x);BLOB size:C605($message_x))
		
		  // generate digest
		SET BLOB SIZE:C606($firstDigest_x;0)
		$firstDigest_t:=Generate digest:C1147($ipadKey_x;$algorithm_l)
		$firstDigest_x:=hexToBlob ($firstDigest_t)
		
		  // The second digest H(K XOR opad, FirstDigest)
		
		  // opadkey concat firstDigest
		COPY BLOB:C558($firstDigest_x;$opadKey_x;0;BLOB size:C605($opadKey_x);BLOB size:C605($firstDigest_x))
		
		  // generate digest
		$hmac_t:=Generate digest:C1147($opadKey_x;$algorithm_l)
		
End case 

$0:=$hmac_t
