//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to find a key from JWK set
* that matches given alg and kid combination.
* 
* @param {Text} Algorithm
* @param {Text} Key ID
* @return {Object} JWK type key
* @aurhot HARADA Koichi
*/

C_TEXT:C284($1;$alg_t)
C_TEXT:C284($2;$kid_t)
C_OBJECT:C1216($0;$keyFound_o)

C_COLLECTION:C1488($queryResult_c)

$alg_t:=$1
$kid_t:=$2
$keyFound_o:=Null:C1517

If (Storage:C1525.keys#Null:C1517)
	
	$queryResult_c:=Storage:C1525.keys.query("alg = :1 && kid = :2";$alg_t;$kid_t)
	If ($queryResult_c.length=1)  // <= alg and kid combination must be unique
		
		  // to avoid editing, return copy of the object
		$keyFound_o:=OB Copy:C1225($queryResult_c[0])
		
	End if 
	
End if 

$0:=$keyFound_o
