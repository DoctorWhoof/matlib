Namespace matlab

#Import "<std>"
#Import "<mojo>"
#Import "<mojo3d>"
#Import "<mojox>"

#Reflect std..
#Reflect mojo3d..
#Reflect mojo..
#Reflect matlab..

#Import "../matlab"
#Import "graphics/grid"
#Import "graphics/navigation"
#Import "gui/dock"

#Import "models/"
#Import "textures/"

Using std..
Using mojo..
Using mojo3d..
Using mojox..
Using matlab..

Function Main()
	New AppInstance
	New EditorWindow
	App.Run()
End

Class EditorWindow Extends Window
	
	Field model:Model
	Field defaultMat:PbrMaterial
	Field rotateModel:= False
	Field dock:Dock
	
	Private
	Field _scene:Scene
	Field _camera:Camera
	Field _pivot:Entity
	Field _light:Light
	Field _fog:FogEffect
	Field _grid:Model
	Field _refresh:= True
	
	Public
	Method New()
		Super.New( "MatLab Editor", 1800, 1200, WindowFlags.Resizable | WindowFlags.HighDPI )
		Layout = "fill"
		ClearColor = Color.Black
		
		'Scene Setup
		_scene=Scene.GetCurrent()
		_scene.ClearColor=Color.Grey
		_scene.AmbientLight=Color.Grey
		
		_fog = New FogEffect(Color.DarkGrey, 10,50)
		_scene.AddPostEffect( _fog )
		
		_pivot = New Entity
						
		_camera=New Camera( _pivot )
		_camera.Near=.1
		_camera.Far=50
		_camera.FOV = 60
		_camera.Move( 0,4,-10 )
		_camera.PointAt( New Vec3f(0,2,0) )

		_light=New Light
		_light.Rotate( 45, 45, 0 )
		_light.CastsShadow = True

		'GUI
		dock = New Dock( Self )
		ContentView = dock
		
		'Create models
		LoadModel( "asset::plane.glb" )
			
		'Grid
		Local gridMat := New PbrMaterial( Color.White, 0.0, 1.0, False )
		gridMat.ColorFactor = Color.Grey
		gridMat.ColorTexture = Texture.Load( "asset::grid.png", TextureFlags.FilterMipmap )
	
		Local gridMesh := CreateGrid( 100, 100, 100, 100, True, New Vec2f( 0.5, 0.5 ) ) 
		
		_grid = New Model( gridMesh, gridMat )
		_grid.Rotate(90,0,0)
		
		dock.left.Refresh()
	End
	
	
	Method OnRender( canvas:Canvas ) Override

		If rotateModel
			model.Rotate( 0, 1.0 , 0 )
			_refresh = True
		End
		
		If _refresh
			RequestRender()
			_scene.Update()
			_refresh = False
		End
		
		_scene.Render( canvas,_camera )
	End
	
	
	Method OnMouseEvent( event:MouseEvent ) Override
		Navigate3D( _camera, event, _pivot )
		_refresh = True
	End
	
	
	Method LoadModel( path:String )
		If model Then model.Destroy()
		model = Model.Load( path )
		
		'Push model above ground
		Local min := model.Mesh.Bounds.min.Y
		If  min < 0
			model.Move(0,Abs(min),0 )
		End
		
		'Figure out material name by the filename
		Local pathSplit := path.Split("/")
		Local fileName := pathSplit[ pathSplit.Length-1].Slice(0, -4)
		Local fileNameSplit := fileName.Split("::")
		Local name := fileNameSplit[ fileNameSplit.Length-1 ]
		
		'Create/Update multimaterial
		Local multi := MultiMaterial.Get( name )
		If Not multi
			multi = New MultiMaterial( model, name )
		Else
			multi.Extract( model, name )
		End
		
		'Refresh UI
		dock.left.RefreshTreeLibrary()
		dock.left.RefreshTreeMulti()
		dock.left.RefreshTreeObject()
	End	
End

