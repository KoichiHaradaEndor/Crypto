//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method takes a text or blob parameter,
* encode with URL safe Base64, then return it.
* URL safe Base64 is similar with Base64 except,
* no padding "="
* "+" => "-", "/" => "_"
* Charset is fixed to UTF-8.
*
* @param {Variant} $1 Text or Blob to endcode
* @return {Text} $0 Encoded text
* @author HARADA Koichi
*/

C_VARIANT:C1683($1)
C_TEXT:C284($0;$encodedText_t)

C_BLOB:C604($blobToEncode_x)
C_LONGINT:C283($type_l)

ASSERT:C1129(Count parameters:C259>=1;"Lack of parameters")

$type_l:=Value type:C1509($1)

ASSERT:C1129(($type_l=Is text:K8:3) | ($type_l=Is BLOB:K8:12);"Error in value type of $1")

$encodedText_t:=""

Case of 
	: ($type_l=Is text:K8:3)
		
		CONVERT FROM TEXT:C1011($1;"UTF-8";$blobToEncode_x)
		
	: ($type_l=Is BLOB:K8:12)
		
		$blobToEncode_x:=$1
		
End case 

BASE64 ENCODE:C895($blobToEncode_x;$encodedText_t)
$encodedText_t:=Replace string:C233($encodedText_t;"\n";"";*)
$encodedText_t:=Replace string:C233($encodedText_t;"\r";"";*)
$encodedText_t:=Replace string:C233($encodedText_t;"=";"";*)
$encodedText_t:=Replace string:C233($encodedText_t;"+";"-";*)
$encodedText_t:=Replace string:C233($encodedText_t;"/";"_";*)

$0:=$encodedText_t
