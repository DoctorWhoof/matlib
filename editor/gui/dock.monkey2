Namespace matlab

#Import "topMenu"
#Import "leftGrid"
#Import "bottomGrid"


Class Dock Extends DockingView
	
	Field editor:EditorWindow
	Field top:TopMenu
	Field left:LeftGridView
	Field bottom:BottomGridView
	
	Method New( editor:EditorWindow )
		Super.New()
		Self.editor = editor
		
		top = New TopMenu( editor )
		AddView( top, "top" )
		
		bottom = New BottomGridView(11,1, editor )
		AddView( bottom, "bottom" )
		
		left = New LeftGridView( editor )
		AddView( left, "left" )
	End	
	
End
