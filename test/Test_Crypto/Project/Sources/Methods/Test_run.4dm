//%attributes = {"invisible":true,"preemptive":"capable"}
C_LONGINT:C283($i;$j)

ARRAY TEXT:C222($TestFolders_at;0)
METHOD GET FOLDERS:C1206($TestFolders_at;"Test_@")

For ($i;1;Size of array:C274($TestFolders_at))
	
	ARRAY TEXT:C222($PathToTestMethod_at;0)
	METHOD GET PATHS:C1163($TestFolders_at{$i};Path project method:K72:1;$PathToTestMethod_at)
	
	For ($j;1;Size of array:C274($PathToTestMethod_at))
		
		MESSAGE:C88("Testing "+$PathToTestMethod_at{$j}+" method in "+$TestFolders_at{$i}+"folder")
		EXECUTE METHOD:C1007($PathToTestMethod_at{$j})
		
	End for 
	
End for 

ALERT:C41("Done")
