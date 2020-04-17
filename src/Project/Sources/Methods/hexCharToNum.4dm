//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method takes one hex character and convert it to
* corresponding number.
*
* If length of the given text is longer than one,
* this method takes the first character.
*
*
* @param {Text} $1 One hex character to be convertred to number
* @return {Longint} $0 Converted number
* @author HARADA Koichi
*/

C_TEXT:C284($1;$hex_t)
C_LONGINT:C283($0;$converted_l)

C_LONGINT:C283($charCode_l)

ASSERT:C1129(Count parameters:C259>=1;"Lack of parameters")

$hex_t:=$1
$converted_l:=0

If (Length:C16($hex_t)#0)
	
	$charCode_l:=Character code:C91($hex_t[[1]])
	
	Case of 
		: ($charCode_l>=0x0030) & ($charCode_l<=0x0039)  // 0 ~ 9
			
			$converted_l:=$charCode_l-0x0030
			
		: ($charCode_l>=0x0041) & ($charCode_l<=0x0046)  // A ~ F
			
			$converted_l:=$charCode_l-0x0041+10
			
		: ($charCode_l>=0x0061) & ($charCode_l<=0x0066)  // a ~ f
			
			$converted_l:=$charCode_l-0x0061+10
			
	End case 
	
End if 

$0:=$converted_l
