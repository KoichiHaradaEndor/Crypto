//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method takes a text parameter which was encoded with URL safe Base64,
* then decode it.
*
* @param {Text} $1 Text to decode
* @return {Blob} $0 Decoded blob
* @author HARADA Koichi
*/

C_TEXT:C284($1;$textToDecode_t)
C_BLOB:C604($0;$decodedBlob_x)

C_LONGINT:C283($modulo_l)
C_BOOLEAN:C305($proceed_b)

ASSERT:C1129(Count parameters:C259>=1;"Lack of parameters")

$textToDecode_t:=$1
$decodedText_t:=""

$textToDecode_t:=Replace string:C233($textToDecode_t;"-";"+")
$textToDecode_t:=Replace string:C233($textToDecode_t;"_";"/")

  // Pad with trailing '='s
$modulo_l:=Length:C16($textToDecode_t)%4

$proceed_b:=True:C214
Case of 
	: ($modulo_l=0)
		  // No pad chars in this case
		
	: ($modulo_l=2)
		  // Two pad chars
		$textToDecode_t:=$textToDecode_t+"=="
		
	: ($modulo_l=3)
		  // One pad char
		$textToDecode_t:=$textToDecode_t+"="
		
	Else 
		  // Illegal base64url string
		$proceed_b:=False:C215
		
End case 

If ($proceed_b)
	
	BASE64 DECODE:C896($textToDecode_t;$decodedBlob_x)
	
	$0:=$decodedBlob_x
	
End if 
