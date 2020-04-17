//%attributes = {"invisible":true}
  // Each JWT value is verified at
  // https://jwt.io/

C_OBJECT:C1216($jwt_o;$payload_o;$key_o)
C_TEXT:C284($jwt_t)
C_BOOLEAN:C305($verified_b)
C_LONGINT:C283($intDate_l)

$intDate_l:=toIntDate ()
$key_o:=New object:C1471(\
"kty";"oct";\
"alg";"HS256";\
"kid";"For testing purpose";\
"k";"AyM1SysPpbyDfgZld3umj1qzKObwVMkoqQ-EstJQLr_T-1qS0gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr1Z9CAow"\
)

  // Test 1: no exp and nbf, no extra verification
$jwt_t:=new JWT ()\
.header("typ";"JWT")\
.payload("iss";"joe")\
.payload("http://example.com/is_root";True:C214)\
.key($key_o)\
.generate()

ASSERT:C1129($jwt_t="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6IkZvciB0ZXN0aW5nIHB1cnBvc2UifQ.eyJpc3MiOiJqb2UiLCJodHRwOi8vZXhhbXBsZS5jb20vaXNfcm9vdCI6dHJ1ZX0.pfPM7zqyTYUmtKqq3Qh3GqPdB6DAPzA7BcUvJSFB3Cg")

$payload_o:=New object:C1471()
$verified_b:=new JWT ()\
.verify($jwt_t;"HS256";$payload_o)

ASSERT:C1129($verified_b)
ASSERT:C1129($payload_o.iss="joe")

  // Test 2: with valid exp and nbf, no extra verification
$jwt_t:=new JWT ()\
.header("typ";"JWT")\
.payload("iss";"joe")\
.payload("http://example.com/is_root";True:C214)\
.payload("exp";2000000000)\
.payload("nbf";1000000000)\
.key($key_o)\
.generate()

ASSERT:C1129($jwt_t="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6IkZvciB0ZXN0aW5nIHB1cnBvc2UifQ.eyJpc3MiOiJqb2UiLCJodHRwOi8vZXhhbXBsZS5jb20vaXNfcm9vdCI6dHJ1ZSwiZXhwIjoyMDAwMDAwMDAwLCJuYmYiOjEwMDAwMDAwMDB9.xmRMjPVe-HkI6v_G3QAKkcBVY9kjRDq-kERUDLTDwXg")

$payload_o:=New object:C1471()
$verified_b:=new JWT ()\
.verify($jwt_t;"HS256";$payload_o)

ASSERT:C1129($verified_b)
ASSERT:C1129($payload_o.exp=2000000000)

  // Test 3: with invalid exp, no extra verification
$jwt_t:=new JWT ()\
.header("typ";"JWT")\
.payload("iss";"joe")\
.payload("http://example.com/is_root";True:C214)\
.payload("exp";1500000000)\
.payload("nbf";1000000000)\
.key($key_o)\
.generate()

ASSERT:C1129($jwt_t="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6IkZvciB0ZXN0aW5nIHB1cnBvc2UifQ.eyJpc3MiOiJqb2UiLCJodHRwOi8vZXhhbXBsZS5jb20vaXNfcm9vdCI6dHJ1ZSwiZXhwIjoxNTAwMDAwMDAwLCJuYmYiOjEwMDAwMDAwMDB9.KkWezkDGUZ6CzZ324iB0MMa0vwJrc7RvWK0kYKbkznw")

$payload_o:=New object:C1471()
$verified_b:=new JWT ()\
.verify($jwt_t;"HS256";$payload_o)

ASSERT:C1129($verified_b=False:C215)
ASSERT:C1129($payload_o.exp=Null:C1517)

  // Test 4: with invalid nbf, no extra verification
$jwt_t:=new JWT ()\
.header("typ";"JWT")\
.payload("iss";"joe")\
.payload("http://example.com/is_root";True:C214)\
.payload("exp";2000000000)\
.payload("nbf";1700000000)\
.key($key_o)\
.generate()

ASSERT:C1129($jwt_t="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6IkZvciB0ZXN0aW5nIHB1cnBvc2UifQ.eyJpc3MiOiJqb2UiLCJodHRwOi8vZXhhbXBsZS5jb20vaXNfcm9vdCI6dHJ1ZSwiZXhwIjoyMDAwMDAwMDAwLCJuYmYiOjE3MDAwMDAwMDB9.T53-Hx4bvHURbipOEwR2LmwFe9Uz2FKc-Q9qn45adM8")

$payload_o:=New object:C1471()
$verified_b:=new JWT ()\
.verify($jwt_t;"HS256";$payload_o)

ASSERT:C1129($verified_b=False:C215)
ASSERT:C1129($payload_o.nbf=Null:C1517)

  // Test 5: no exp and nbf, but with extra verification - success case
$jwt_t:=new JWT ()\
.header("typ";"JWT")\
.payload("iss";"https://my.company.com")\
.payload("nonce";"some-random-value")\
.key($key_o)\
.generate()

ASSERT:C1129($jwt_t="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6IkZvciB0ZXN0aW5nIHB1cnBvc2UifQ.eyJpc3MiOiJodHRwczovL215LmNvbXBhbnkuY29tIiwibm9uY2UiOiJzb21lLXJhbmRvbS12YWx1ZSJ9.hY0wTfktiUCRvpmLIpaFtcyjaJOk58mEr17qnPmEAqc")

$payload_o:=New object:C1471()
$verified_b:=new JWT ()\
.verify($jwt_t;"HS256";$payload_o;New object:C1471("iss";"https://my.company.com";"nonce";"some-random-value"))

ASSERT:C1129($verified_b)
ASSERT:C1129($payload_o.iss="https://my.company.com")

  // Test 5: no exp and nbf, but with extra verification - fail case
$payload_o:=New object:C1471()
$verified_b:=new JWT ()\
.verify($jwt_t;"HS256";$payload_o;New object:C1471("iss";"https://My.company.com";"nonce";"some-random-value"))
  // note one character in iss is uppercase
ASSERT:C1129($verified_b=False:C215)
ASSERT:C1129($payload_o.iss=Null:C1517)

  // Test 6: no exp and nbf, but with extra verification - fail case
$payload_o:=New object:C1471()
$verified_b:=new JWT ()\
.verify($jwt_t;"HS256";$payload_o;New object:C1471("iss";"https://my.company.com";"nonce";"sOme-random-value"))
  // note one character in nonce is uppercase
ASSERT:C1129($verified_b=False:C215)
ASSERT:C1129($payload_o.nonce=Null:C1517)

