//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
/**
* This method creates and return JWT object.
*
* @param {Object} $1 Header
* @param {Object} $2 Payload
* @param {Object} $3 Key
* @return {Object} $0 JWS object
* @author: HARADA Koichi
*/

C_OBJECT:C1216($1)  // header
C_OBJECT:C1216($2)  // payload
C_OBJECT:C1216($3)  // key
C_OBJECT:C1216($0;$jwt_o)

C_LONGINT:C283($numParam_l)

$jwt_o:=New object:C1471()
$numParam_l:=Count parameters:C259

  //#####
  // Methods
  //#####

$jwt_o.generate:=Formula:C1597(JWT_generate )
$jwt_o.header:=Formula:C1597(JWT_header )
$jwt_o.key:=Formula:C1597(JWT_key )
$jwt_o.payload:=Formula:C1597(JWT_payload )
$jwt_o.verify:=Formula:C1597(JWT_verify )

  //#####
  // Parameters
  //#####

$jwt_o.data:=New object:C1471()

If ($numParam_l>=1)
	
	$jwt_o.data.header($1)
	
End if 

If ($numParam_l>=2)
	
	$jwt_o.data.payload($2)
	
End if 

If ($numParam_l>=3)
	
	$jwt_o.data.key($3)
	
End if 

$0:=$jwt_o
