//%attributes = {"invisible":true}
  // https://jwt.io/

C_OBJECT:C1216($jwt_o)
C_TEXT:C284($jwt_t)

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
SET TEXT TO PASTEBOARD:C523($jwt_t)
