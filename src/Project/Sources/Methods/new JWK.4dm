//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
/**
* This method creates and returns JWK object.
*
* The JWK set is stored in Storage.
* If it is not exists, the key set will be loaded from file
* named "jwk-secret.key" stored in the database folder.
*
* @return {Object} JWK object
* @author HARADA Koichi
*/

C_OBJECT:C1216($0;$jwk_o)

C_OBJECT:C1216($keyFile_o;$keys_o;$eachKeyItem_o)
C_TEXT:C284($keysJson_t)
C_COLLECTION:C1488($keys_c)
C_LONGINT:C283($i)
C_BOOLEAN:C305($readOK_b)

$jwk_o:=New object:C1471()

$jwk_o.find:=Formula:C1597(JWK_find )

  //#####
  // Initialize Storage.keys collection
  //#####
If (Storage:C1525.keys=Null:C1517)
	
	Use (Storage:C1525)
		
		Storage:C1525.keys:=New shared collection:C1527()
		
	End use   // /Use (Storage)
	
	$keyFile_o:=Folder:C1567(fk database folder:K87:14;*).file("jwk-secret.key")
	If ($keyFile_o.exists)
		
		$keysJson_t:=$keyFile_o.getText()
		$keys_o:=JSON Parse:C1218($keysJson_t)
		If ($keys_o.keys#Null:C1517)
			
			$keys_c:=$keys_o.keys
			If ($keys_c.length>0)
				
				Use (Storage:C1525.keys)
					
					For each ($eachKeyItem_o;$keys_c)
						
						$readOK_b:=False:C215
						Case of 
							: ($eachKeyItem_o.alg=Null:C1517)
								  // alg is mandatory
								
							: (compareCaseSensitive ($eachKeyItem_o.alg;"HS256")) & (compareCaseSensitive ($eachKeyItem_o.alg;"HS512"))
								  // only HS256 and HS512 are accepted, and the comparization will be done in case-sensitive
								
							: ($eachKeyItem_o.kid=Null:C1517)
								  // kid is mandatory
								
							: ($eachKeyItem_o.k=Null:C1517)
								  // k is mandatory
								
							Else 
								$readOK_b:=True:C214
								
						End case 
						
						If ($readOK_b)
							
							ARRAY TEXT:C222($propertyNames_at;0)
							OB GET PROPERTY NAMES:C1232($eachKeyItem_o;$propertyNames_at)
							
							  // In the Storage, normal object cannot be assigned directly
							Storage:C1525.keys.push(New shared object:C1526())
							For ($i;1;Size of array:C274($propertyNames_at))
								
								Storage:C1525.keys[Storage:C1525.keys.length-1][$propertyNames_at{$i}]:=$eachKeyItem_o[$propertyNames_at{$i}]
								
							End for 
							
						End if 
						
					End for each 
					
				End use   // /Use (Storage.keys)
				
			End if   // /If ($keys_c.length>0)
			
		End if   // /If ($keys_o.keys#Null)
		
	End if   // /If ($keyFile_o.exists)
	
End if   // /If (Storage.keys=Null)

$0:=$jwk_o
