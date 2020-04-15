//%attributes = {}
C_OBJECT:C1216($jwt_o)

$t:=new JWT ()\
.header("typ";"JWT")\
.header("alg";"HS256")\
.payload("iss";"joe")\
.payload("exp";1422779638)\
.payload("http://example.com/is_root";True:C214)\
.key("AyM1SysPpbyDfgZld3umj1qzKObwVMkoqQ-EstJQLr_T-1qS0gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr1Z9CAow")\
.generate()

SET TEXT TO PASTEBOARD:C523($t)
