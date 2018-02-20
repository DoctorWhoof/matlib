Namespace matlab


Class MenuModel Extends Menu
	
	Field editor:EditorWindow
	
	Method New( name:String, editor:EditorWindow )
	
		Super.New( name )
		Self.editor = editor
		
		AddAction( "Load Model" ).Triggered=Lambda()
			Local path := RequestFile( "Load Model", "GLTF:glb", False )
			If path
				editor.LoadModel( path )
			End
			editor.dock.left.Refresh()
		End
		
		'-------------------------------------------------------------------------------------
		
		AddAction( "Reset Model's Materials" ).Triggered=Lambda()
			Local n := 0
			For Local mat := Eachin editor.model.Materials
				editor.model.Materials[n] = editor.defaultMat
				n += 1
			Next
			editor.dock.left.Refresh()
		End
		
	End
		
End





		

	
