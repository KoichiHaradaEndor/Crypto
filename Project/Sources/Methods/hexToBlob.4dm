//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method converts given hex text to blob.
*
* @param {Text} $1 Hex text to convert
* @return {Blob} $0 Converted blob
* @author HARADA Koichi
*/

C_TEXT:C284($1;$toConvert_t)
C_BLOB:C604($0;$converted_x)

C_LONGINT:C283($textLength_l;$blobSize_l;$i)
C_LONGINT:C283($upperByte_l;$lowerByte_l)
C_TEXT:C284($upperByte_t;$lowerByte_t)

$toConvert_t:=$1

$textLength_l:=Length:C16($toConvert_t)

If ($textLength_l%2=0)
	
	$blobSize_l:=$textLength_l\2
	SET BLOB SIZE:C606($converted_x;$blobSize_l)
	
	For ($i;0;$blobSize_l-1)
		
		$upperByte_t:=$toConvert_t[[$i*2+1]]
		$lowerByte_t:=$toConvert_t[[$i*2+2]]
		
		$upperByte_l:=hexCharToNum ($upperByte_t)
		$lowerByte_l:=hexCharToNum ($lowerByte_t)
		
		$converted_x{$i}:=$upperByte_l << 4+$lowerByte_l
		
	End for 
	
End if 

$0:=$converted_x
