Namespace matlab


Class MenuLibrary Extends Menu
	
	Field editor:EditorWindow
	
	Method New( name:String, editor:EditorWindow )
	
		Super.New( name )
		Self.editor = editor
		'-------------------------------------------------------------------------------------
		
		AddAction( "Reset Library" ).Triggered=Lambda()
			
			MaterialLibrary.ClearUnusedMaterials()
		
			editor.defaultMat = New PbrMaterial( Color.Grey )
			editor.defaultMat.Name = "Default"
			
			Local n := 0
			For Local mat := Eachin editor.model.Materials
				editor.model.Materials[n] = editor.defaultMat
				n += 1
			Next
			
			editor.dock.left.Refresh()
		End
		
		'-------------------------------------------------------------------------------------
		
		AddAction( "Clean Up Library" ).Triggered=Lambda()
			MaterialLibrary.ClearUnusedMaterials()
			If Material.Get( "Default" )
				editor.defaultMat = New PbrMaterial( Color.Grey )
				editor.defaultMat.Name = "Default"
			End
			editor.dock.left.Refresh()
		End
		
		'-------------------------------------------------------------------------------------
		
		AddAction( "Load Library" ).Triggered=Lambda()
			MaterialLibrary.ClearUnusedMaterials()
		
			Local path := RequestFile( "Load Material Library", "Json Files:json", False )
			If path Then Material.Load( path )
			
			Local materialStack:= New Stack<Material>
			For Local m := Eachin MaterialLibrary.AllMaterials().Keys
				materialStack.Push( MaterialLibrary.GetMaterial(m) )
			Next
			
			editor.dock.left.Refresh()
		End
		
		'-------------------------------------------------------------------------------------
		
		AddAction( "Save Library" ).Triggered=Lambda()
			Local path := RequestFile( "Save Material Library", "Json Files:json", True )
			If path Then Print( Material.Save( path ) ).ToJson()
		End
		
		'-------------------------------------------------------------------------------------
		
		AddSeparator()
		
		'-------------------------------------------------------------------------------------
		
		AddAction( "Quit" ).Triggered=Lambda()
			App.Terminate()
		End
		
	End
	
End
