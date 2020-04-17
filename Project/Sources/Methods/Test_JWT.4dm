//%attributes = {"invisible":true}
  // https://jwt.io/

C_OBJECT:C1216($jwt_o;$key_o;$payload_o)
C_TEXT:C284($jwt_t)
C_BOOLEAN:C305($verified_b)
C_LONGINT:C283($intDate_l)

$intDate_l:=toIntDate ()

$jwt_t:=new JWT ()\
.header("typ";"JWT")\
.payload("iss";"joe")\
.payload("exp";$intDate_l+100)\
.payload("nbf";$intDate_l-100)\
.payload("http://example.com/is_root";True:C214)\
.key(new JWK ().find("HS256";"For testing purpose"))\
.generate()

$payload_o:=New object:C1471()
$verified_b:=new JWT ()\
.verify($jwt_t;"HS256";$payload_o)




If (False:C215)
	
	$jwt_o:=new JWT ()
	
	$jwt_o.header("typ";"JWT")
	
	$jwt_o.payload("iss";"joe")
	$jwt_o.payload("exp";1300819380)
	$jwt_o.payload("http://example.com/is_root";True:C214)
	
	$jwt_o.key(New object:C1471(\
		"kty";"oct";\
		"alg";"HS256";\
		"kid";"test key id";\
		"k";"AyM1SysPpbyDfgZld3umj1qzKObwVMkoqQ-EstJQLr_T-1qS0gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr1Z9CAow"\
		))
	
	$jwt_t:=$jwt_o.generate()
	
End if 

