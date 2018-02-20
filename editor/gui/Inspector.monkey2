Namespace matlab


Class Inspector Extends ScrollView
	
	Private
	Field _children:= New Stack<mojo.app.View>
	Field _target:Variant
	
	'******************************** Properties ********************************
	
	Public
	Property Target:Variant()
		Return _target
	Setter( v:Variant )
		For Local c := Eachin _children
			RemoveView( c )	
		End
		If v
			Local json := New JsonObject
			json.Serialize( v )
			SaveString( json.ToJson(), HomeDir() + "out.json" )
			For Local attrib := Eachin json.ToObject().Keys

			Next

			json = Null
		End
	End

	'******************************** Methods ********************************
	
	Method New()
		Layout = "fill"
		Style.Border = New Recti(1,1,1,1)
		Style.BackgroundColor = Color.Black
		
		Local label := New Label( "Inspector" )
		AddView( label, "top" )
	End
	
	
	
End
