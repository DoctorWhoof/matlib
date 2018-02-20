Namespace matlab


Class MaterialLibrary
	
	Private
	Global _allMaterials := New Map< String,Material >
	Global _allMaterialNames := New Map< Material, String >
	
	Global _allTextures := New Map< String,Texture >
	Global _allTextureNames := New Map< Texture, String >
	Global _allTexturePaths := New Map< String, String >
	
	Global _allModelMultiMaterials := New Map< Model, MultiMaterial >
	
	Public
	
	Function Clear()
		_allMaterials.Clear()
		_allMaterialNames.Clear()
		_allTextures.Clear()
		_allTextureNames.Clear()
		_allTexturePaths.Clear()
	End
	
	'******************************** materials '********************************
	
	'It's usually a better idea to simply set Material.Name, instead of using the MaterialLibrary directly!
	
	Function AddMaterial( name:String, mat:Material )
		If _allMaterials.Get( name )
			Print "MaterialLibrary: Warning, overriding material definitions for " + name
		End
		_allMaterials.Add( name, mat )
		_allMaterialNames.Add( mat, name )
		Print "Added " + name 
	End
	
	Function GetMaterial:Material( name:String )
		If Not name Return Null
		Return _allMaterials[ name ]	
	End
	
	Function GetName:String( mat:Material )
		Return _allMaterialNames[ mat ]	
	End
	
	Function Remove( mat:Material )
		Local name := GetName( mat )
		If name Then _allMaterials.Remove( name )
		_allMaterialNames.Remove( mat )
	End
	
	Function AllMaterials:Map< String,Material >()
		Return _allMaterials
	End
	
	Function ClearMaterials()
		_allMaterials.Clear()
		_allMaterialNames.Clear()
	End
	
	Function ClearUnusedMaterials()
		'WARNING: Currently only searches root entities.
		
		'Stores all used materials.
		Local used:= New Map<Material,String>	'A map is used because keys can only be stored once
		For Local e:= Eachin Scene.GetCurrent().GetRootEntities()
			Local m := Cast<Model>( e )
			If m
				For Local submat := Eachin m.Materials
					used.Add( submat, "" )
				Next
			End
		Next
		
		'Cleans unused
		For Local m := Eachin _allMaterials.Values
			If Not used.Contains( m )
				Remove( m )
			End
		Next
		
	End
	
	'******************************** textures '********************************
	
	'It's usually a better idea to simply set Texture.Name, instead of using the MaterialLibrary directly!
	
	Function AddTexture( name:String, tex:Texture )
		_allTextures.Add( name, tex )
		_allTextureNames.Add( tex, name )
	End
	
	Function AddTexturePath( name:String, path:String )
		_allTexturePaths.Add( name, path )
	End
	
	Function GetTexture:Texture( name:String )
		If Not name Return Null
		Return _allTextures[ name ]	
	End
	
	Function GetTexturePath:String( name:String )
		If Not name Return Null
		Return _allTexturePaths[ name ]	
	End
	
	Function GetName:String( tex:Texture )
		Return _allTextureNames[ tex ]	
	End
	
	Function AllTextures:Map< String,Texture >()
		Return _allTextures
	End
	
	'******************************** model management '********************************
	
'	Function AddModel( model:Model )
'		Local multi := New MultiMaterial( model )
'		
'		For Local n := 0 Until multi.indices.Length
'			Local name := multi.names[n]
'			AddMaterial( name, model.Materials[n] )
'			Print"Added " + name
'		Next
'
'		_allModelMultiMaterials.Add( model, multi )
'	End
'	
'	Function GetMultiMaterial:MultiMaterial( model:Model )
'		Return 	_allModelMultiMaterials[ model ]
'	End
	
End
