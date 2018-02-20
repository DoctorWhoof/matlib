Namespace myapp3d

#Import "<std>"
#Import "<mojo>"
#Import "<mojo3d>"

#Reflect mojo3d..

Using std..
Using mojo..
Using mojo3d..

Class MyWindow Extends Window
	
	Field _scene:Scene
	Field _camera:Camera
	Field _light:Light
	Field _donut:Model
	Field _material:PbrMaterial

	Method New( title:String="Simple mojo3d app",width:Int=640,height:Int=480,flags:WindowFlags=WindowFlags.Resizable )
		Super.New( title,width,height,flags )
		_scene=Scene.GetCurrent()
		_scene.ClearColor=Color.Black
		
		'create camera
		_camera=New Camera
		_camera.Near=.1
		_camera.Far=100
		_camera.Move( 0,10,-10 )
		_camera.AddComponent<FlyBehaviour>()
		
		'create light
		_light=New Light
		_light.Rotate( 45, 45, 0 )
		
		_material = New PbrMaterial( Color.Red, 0.1, 0.25 )
		_material.EmissiveFactor=New Color( 0,.25, 0 )
		
		_donut=Model.CreateTorus( 2,.5,48,24,_material )
		_donut.Move( 0,10,0 )
	End
	
	
	Method OnRender( canvas:Canvas ) Override
		RequestRender()
		_donut.Rotate( .2,.4,.6 )
		_scene.Update()
		_scene.Render( canvas,_camera )
		canvas.DrawText( "Width="+Width+", Height="+Height+", FPS="+App.FPS,0,0 )
	End
	
End

Function Main()
	New AppInstance
	New MyWindow
	App.Run()
End
