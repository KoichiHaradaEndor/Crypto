//%attributes = {"invisible":true,"preemptive":"capable"}
/**
*
*/

C_TEXT:C284($1;$alg_t)
C_TEXT:C284($2;$kid_t)
C_OBJECT:C1216($0;$keyFound_o)

C_OBJECT:C1216($keyFile_o;$keys_o;$key_o)
C_TEXT:C284($keysJson_t)
C_COLLECTION:C1488($keys_c;$queryResult_c)
C_LONGINT:C283($i)

$alg_t:=$1
$kid_t:=$2
$keyFound_o:=Null:C1517

If (Storage:C1525.keys=Null:C1517)
	
	Use (Storage:C1525)
		
		Storage:C1525.keys:=New shared collection:C1527()
		
	End use   // /Use (Storage)
	
	$keyFile_o:=Folder:C1567(fk database folder:K87:14).file("jwt.key")
	If ($keyFile_o.exists)
		
		$keysJson_t:=$keyFile_o.getText()
		$keys_o:=JSON Parse:C1218($keysJson_t)
		If ($keys_o.keys#Null:C1517)
			
			$keys_c:=$keys_o.keys
			If ($keys_c.length>0)
				
				Use (Storage:C1525.keys)
					
					For each ($key_o;$keys_c)
						
						ARRAY TEXT:C222($propertyNames_at;0)
						OB GET PROPERTY NAMES:C1232($key_o;$propertyNames_at)
						
						Storage:C1525.keys.push(New shared object:C1526())
						For ($i;1;Size of array:C274($propertyNames_at))
							
							Storage:C1525.keys[Storage:C1525.keys.length-1][$propertyNames_at{$i}]:=$key_o[$propertyNames_at{$i}]
							
						End for 
						
					End for each 
					
				End use   // /Use (Storage.keys)
				
			End if   // /If ($keys_c.length>0)
			
		End if   // /If ($keys_o.keys#Null)
		
	End if   // /If ($keyFile_o.exists)
	
End if   // /If (Storage.keys=Null)

$queryResult_c:=Storage:C1525.keys.query("alg = :1 && kid = :2";$alg_t;$kid_t)
If ($queryResult_c.length=1)
	
	  // to avoid editing, return copy of the object
	$keyFound_o:=OB Copy:C1225($queryResult_c[0])
	
End if 

$0:=$keyFound_o
