Namespace matlab

Class MultiMaterial
	
	'TO Do: Serialize this!
	'A Multimaterial object contains references to several material names.
	'Materials can be referenced more than once by different material IDs.
	
	Private
	Global _all:= New Stack<MultiMaterial>
	Global _allByName := New Map<String,MultiMaterial>
'	Global _allByModel := New Map<Model,MultiMaterial>
	
	Field _names := New StringStack
	Field _name:String
	Field _models:= New Stack<Model>
	
	Public
	Property Name:String()
		Return _name
	Setter( n:String )
		_allByName.Remove( _name )
		_allByName.Add( n, Self )
		_name = n
	End
	
	
	Method New( model:Model, name:String )
		If _allByName.Contains( name )
			Print( "~nMultiMaterial: Error, names can't be reassigned")
			App.Terminate()
		End
		Name = name
		Extract( model, name )
'		_allByModel.Add( model, Self )
		_all.Add( Self )
		_models.Add( model )
	End
	
	
'	Function Get:MultiMaterial( model:Model )
'		Return _allByModel[ model ]
'	End
	

	Function Get:MultiMaterial( name:String )
		Return _allByName[ name ]
	End
	
	
	Function All:MultiMaterial[]()
		Return _all.ToArray()
	End
	
	
	Method Apply( model:Model )
		Print "About to assign " + _names.Length + " materials..."
		For Local n := 0 Until model.Materials.Length
			Print "~tAssigning " + _names[n]
			model.Materials[n] = Material.Get( _names[n] )
		Next
		If Not _models.Contains( model )
			_models.Add( model )	
		End
	End
	
	
	Method Extract( model:Model, subMatName:String )
		_names.Clear()
		For Local n := 0 Until model.Mesh.NumMaterials
			If model.Materials[n].Name = ""
				model.Materials[n].Name = subMatName + n	'setting the name automatically adds material to the library
			End
			_names.Push( model.Materials[n].Name )
		Next
		If Not _models.Contains( model )
			_models.Add( model )	
		End
	End
	
End