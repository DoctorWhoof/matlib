Namespace matlab

'
'Function  CreateBottomGrid:GridView( editor:EditorWindow )
'	
'	Local _turnButton := New Button( "Turntable" )
'	_turnButton.Clicked += Lambda()
'		editor.rotateModel = Not editor.rotateModel
'	End
'	
'	Local _currentLabel := New Label( "Material" )
'	_currentLabel.Gravity = New Vec2f( 0.5 )
'	
'	Local _gridBottom := New GridView( 11, 1 )
'	_gridBottom.MinSize = New Vec2i( 800, 100 )
'	_gridBottom.Gravity = New Vec2f( 0.5 )
'	_gridBottom.Layout = "fill"
'
'	_gridBottom.AddView( _turnButton, 9, 0 )
'	
'	_gridBottom.AddView( _currentLabel, 5, 0 )
'	Return _gridBottom
'	
'End


Class BottomGridView Extends GridView
	
	Field editor:EditorWindow
	
	Field turnButton:Button
	Field currentLabel:Label

	Method New( width:Int, height:Int, editor:EditorWindow )
		Super.New(width, height)
		Self.editor = editor
		
		turnButton = New Button( "Turntable" )
		turnButton.Clicked += Lambda()
			editor.rotateModel = Not editor.rotateModel
		End
		
		currentLabel = New Label( "Material" )
		currentLabel.Gravity = New Vec2f( 0.5 )
		
'		Local grid := New GridView( 11, 1 )
		MinSize = New Vec2i( 800, 100 )
		Gravity = New Vec2f( 0.5 )
		Layout = "fill"
	
		AddView( turnButton, 9, 0 )
		AddView( currentLabel, 5, 0 )
	End	
	
End