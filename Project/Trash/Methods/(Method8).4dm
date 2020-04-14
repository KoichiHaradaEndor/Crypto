//%attributes = {}
$message_t:="what do ya want for nothing?"
$key_t:="Jefe"
$algorithm_l:=SHA256 digest:K66:4

Case of 
	: ($algorithm_l=SHA256 digest:K66:4)
		$result_t:="5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843"
	: ($algorithm_l=SHA512 digest:K66:5)$blockSize_l:=128
		$result_t:="164b7a7bfcf819e2e395fbe73b56e0a387bd64222e831fd610270cd7ea2505549758bf75c05a994a6d034f65f8f0e6fdcaeab1a34d4a6b4b636e070a38bce737"
End case 

$hmac:=new HMAC ().key($key_t).message($message_t).algorithm($algorithm_l).hexDigest()
ASSERT:C1129($hmac=$result_t)
