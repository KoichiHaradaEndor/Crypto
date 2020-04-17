//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method calculates HMAC,
* ecode, then return it.
* This function is used internally.
*
* @param {Text} $1 JWT signature input
* @param {Longint} $2 Algorithm
* @param {Text} $3 Key
* @return {Text} $0 Encoded jwt
*/

C_TEXT:C284($1;$input_t)
C_TEXT:C284($2;$algorithm_t)
C_TEXT:C284($3;$key_t)
C_TEXT:C284($0;$hmac_t)

C_BLOB:C604($key_x;$hmac_x)
C_LONGINT:C283($algorithm_l)

$input_t:=$1
$algorithm_t:=$2
$key_t:=$3
$jwt_t:=""

Case of 
	: ($algorithm_t="HS256")
		$algorithm_l:=SHA256 digest:K66:4
		
	: ($algorithm_t="HS512")
		$algorithm_l:=SHA512 digest:K66:5
		
End case 

$key_x:=base64UrlDecode ($key_t)
$hmac_t:=new Hmac ()\
.key($key_x)\
.message($input_t)\
.algorithm($algorithm_l)\
.hexDigest()

SET BLOB SIZE:C606($hmac_x;0)
$hmac_x:=hexToBlob ($hmac_t)

$0:=base64UrlEncode ($hmac_x)
