//%attributes = {}
/*********************
* This does not work.
**********************/


C_TEXT:C284($message_t)
C_TEXT:C284($key_t)
C_LONGINT:C283($algorithm_l)
C_TEXT:C284($hmac_t)

C_BLOB:C604($key_x;$ipadKey_x;$opadKey_x;$message_x;$firstDigest_x)
C_LONGINT:C283($blockSize_l;$realKeyLength_l;$i)
C_TEXT:C284($firstDigest_t;$result_t)

$message_t:="what do ya want for nothing?"
$key_t:="Jefe"
$algorithm_l:=SHA512 digest:K66:5

Case of 
	: ($algorithm_l=SHA256 digest:K66:4)
		$blockSize_l:=64
		$result_t:="5bdcc146bf60754e6a042426089575c7\n5a003f089d2739839dec58b964ec3843"
	: ($algorithm_l=SHA512 digest:K66:5)
		$blockSize_l:=128
		$result_t:="164b7a7bfcf819e2e395fbe73b56e0a387bd64222e831fd610270cd7ea2505549758bf75c05a994a6d034f65f8f0e6fdcaeab1a34d4a6b4b636e070a38bce737"
End case 

  // Key preprocess
CONVERT FROM TEXT:C1011($key_t;"UTF-8";$key_x)

If (BLOB size:C605($key_x)>$blockSize_l)
	
	  // When the given key length is greater than hash's block size,
	  // hashing down first
	$key_t:=Generate digest:C1147($key_x;$algorithm_l)
	CONVERT FROM TEXT:C1011($key_t;"UTF-8";$key_x)
	
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

  // The first hash  H(K XOR ipad, M)
CONVERT FROM TEXT:C1011($message_t;"UTF-8";$message_x)

  // ipadkey concat message
COPY BLOB:C558($message_x;$ipadKey_x;0;BLOB size:C605($ipadKey_x);BLOB size:C605($message_x))

  // generate digest
$firstDigest_t:=Generate digest:C1147($ipadKey_x;$algorithm_l)
CONVERT FROM TEXT:C1011($firstDigest_t;"UTF-8";$firstDigest_x)

  // The second digest H(K XOR opad, FirstDigest)

  // opadkey concat firstDigest
COPY BLOB:C558($firstDigest_x;$opadKey_x;0;BLOB size:C605($opadKey_x);BLOB size:C605($firstDigest_x))

  // generate digest
$hmac_t:=Generate digest:C1147($opadKey_x;$algorithm_l)

ASSERT:C1129($hmac_t=$result_t)
