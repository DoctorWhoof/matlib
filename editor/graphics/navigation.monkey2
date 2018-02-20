Namespace matlab


Function Navigate3D( camera:Camera, event:MouseEvent, target:Entity, panSpeed:Double = 20.0, zoomSpeed:Double = 20.0, orbitSpeed:Double = 0.5 )
	'To do: instead of pivot entity, rotate around target using Translation based on sin/cos, then PointAt( target )
	Global click := New Vec2i
	
	Local parent := camera.Parent
	Assert( parent <> Null, "Navigate3D: Camera needs a parent entity (orbit pivot)" )
	
	If Mouse.ButtonPressed( MouseButton.Left ) Or Mouse.ButtonPressed( MouseButton.Middle ) Or Mouse.ButtonPressed( MouseButton.Right )
		click.X = Mouse.X
		click.Y = Mouse.Y
	End
	
'	If Keyboard.KeyDown( Key.LeftAlt )
		If Mouse.ButtonDown( MouseButton.Left )
			Local diff := New Vec2i( Mouse.X - click.X, Mouse.Y - click.Y )
			parent.Rotate( diff.Y*orbitSpeed, -diff.X*orbitSpeed, 0, True )
			parent.Rz = 0
			click.X = Mouse.X
			click.Y = Mouse.Y
			App.RequestRender()
		Else If Mouse.ButtonDown( MouseButton.Middle )
			Local diff := New Vec2i( Mouse.X - click.X, Mouse.Y - click.Y )
			camera.LocalX -= ( diff.X * (0.5/panSpeed) )
			camera.LocalY += ( diff.Y * (0.5/panSpeed) )
			click.X = Mouse.X
			click.Y = Mouse.Y
			App.RequestRender()
		Else If Mouse.ButtonDown( MouseButton.Right )
			Local diff := New Vec2i( Mouse.X - click.X, Mouse.Y - click.Y )
'			camera.LocalX -= ( diff.X * (0.5/panSpeed) )	'shold be optional
			camera.LocalZ += ( diff.Y * (0.5/panSpeed) )
			click.X = Mouse.X
			click.Y = Mouse.Y
			App.RequestRender()
		End
'	End
	
	Select event.Type
	Case EventType.MouseWheel
		If event.Modifiers = Modifier.LeftAlt
			'Zoom with alt + wheel
			camera.LocalZ += ( ( Exp( event.Wheel.Y/100.0 ) - 1.0 ) * panSpeed )
			camera.LocalX += ( ( Exp( event.Wheel.X/100.0 ) - 1.0 ) * panSpeed )
		Else
			'Pan with wheel (two fingers on touchpad)
			camera.LocalX += ( ( Exp( event.Wheel.X/100.0 ) - 1.0 ) * panSpeed )
			camera.LocalY += ( ( Exp( event.Wheel.Y/100.0 ) - 1.0 ) * panSpeed )
		End
		App.RequestRender()
	End
End



