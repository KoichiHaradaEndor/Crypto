//%attributes = {"invisible":true}
  // This test looks jwt.key located root of host prohect folder.

C_OBJECT:C1216($key_o)

$key_o:=new JWK ().find("HS256";"For testing purpose")

ASSERT:C1129($key_o#Null:C1517;"Key is not returned.")
ASSERT:C1129($key_o.k#Null:C1517;"Key content is empty.")
ASSERT:C1129($key_o.k="AyM1SysPpbyDfgZld3umj1qzKObwVMkoqQ-EstJQLr_T-1qS0gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr1Z9CAow";"Key content is invalid.")

