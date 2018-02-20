Namespace matlab

#Import "MenuLibrary"
#Import "MenuModel"

Class TopMenu Extends MenuBar
	
	Field editor:EditorWindow
	
	Method New( editor:EditorWindow )
		Self.editor = editor
	
		AddMenu( New MenuLibrary( "Materials", editor ) )
		AddMenu( New MenuModel( "Model", editor ) )
	End
	
End