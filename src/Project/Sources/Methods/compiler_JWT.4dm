//%attributes = {"invisible":true}
C_TEXT:C284(JWT_generate ;$1)

C_TEXT:C284(JWT_getEncodedHMAC ;$1;$2;$3;$0)

C_VARIANT:C1683(JWT_header ;$1)
C_TEXT:C284(JWT_header ;$2)
C_OBJECT:C1216(JWT_header ;$0)

C_OBJECT:C1216(JWT_key ;$1;$0)

C_VARIANT:C1683(JWT_payload ;$1;$2)
C_OBJECT:C1216(JWT_payload ;$0)

C_TEXT:C284(JWT_verify ;$1;$2)
C_OBJECT:C1216(JWT_verify ;$3;$4)
C_BOOLEAN:C305(JWT_verify ;$0)

C_OBJECT:C1216(new JWT ;$1;$2;$3)
