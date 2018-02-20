Namespace matlab

#Import "Inspector"

Class LeftGridView Extends GridView
	
	Field editor:EditorWindow

	Field treeLibrary:TreeView
	Field treeMulti:TreeView
	Field treeObject:TreeView
	Field inspector:Inspector

	Method New( editor:EditorWindow )
		Super.New(2, 20)
		Self.editor = editor
		Style.Border = New Recti(5,5,5,5)
		MinSize = New Vec2i( 250, 600 )
		
		Local inspector := New Inspector
		
		Local rootLib := New TreeView.Node( "Library" )
		treeLibrary = New TreeView
		treeLibrary.RootNode = rootLib
		treeLibrary.Style.Border = New Recti(1,1,1,1)
		
		treeLibrary.NodeClicked+=Lambda( node:TreeView.Node )
			Local nodetarget := Cast<NodeTarget>( node )
			Local target := nodetarget.target
			If target
				inspector.Target = Variant( target )
			End
		End
		
		Local rootMulti := New TreeView.Node( "MultiMaterials" )
		treeMulti = New TreeView
		treeMulti.RootNode = rootMulti
		treeMulti.Style.Border = New Recti(1,1,1,1)

		Local rootObj := New TreeView.Node( "Current Surfaces" )
		treeObject = New TreeView
		treeObject.RootNode = rootObj
		treeObject.Style.Border = New Recti(1,1,1,1)
		
		AddView( treeLibrary, 0, 1, 1, 5 )
		AddView( treeMulti, 1, 1, 1, 5 )
		AddView( treeObject, 0, 6, 2, 5 )
		AddView( inspector, 0, 11, 2, 10 )
	End
	
	
	Method Refresh()
		If Not editor.defaultMat
			editor.defaultMat = New PbrMaterial( Color.Grey )
			editor.defaultMat.Name = "Default"
		End
		RefreshTreeLibrary()
		RefreshTreeMulti()
		RefreshTreeObject()
	End
	
	
	Method RefreshTreeLibrary()
		Local root := treeLibrary.RootNode
		root.RemoveAllChildren()
		
		For Local mat := Eachin MaterialLibrary.AllMaterials().Values
			Local newNode := New NodeTarget( mat.Name, root, mat )
			Print mat.InstanceType
		Next
		
		root.Expanded = True
	End
	
	
	Method RefreshTreeMulti()
		Local root := treeMulti.RootNode
		root.RemoveAllChildren()
		
		Local n:= 0
		For Local mat := Eachin MultiMaterial.All()
			Local newNode := New TreeView.Node( mat.Name, root)
			n += 1
		Next
		
		root.Expanded = True
	End
	
	
	Method RefreshTreeObject()
		Local root := treeObject.RootNode
		root.RemoveAllChildren()
		
		Local n:= 0
		For Local mat := Eachin editor.model.Materials
			Local newNode := New TreeView.Node( n + ": " + mat.Name, root)
			n += 1
		Next
		
		root.Expanded = True
	End
	
End

Class NodeTarget Extends TreeView.Node

	Field target:Variant
	
	Method New( text:String, parent:TreeView.Node, target:Variant )
		Super.New( text, parent )
		Self.target = Variant(target)
	End
		
End


'Class NodeLibrary Extends TreeView.Node
'	
'	Field buttonAssign:= "Assign To Surface"
'
'	Method New( text:String, parent:TreeView.Node )
'		Super.New( text, parent )
'	End
'	
'	
'End