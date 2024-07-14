extends Path2D
class_name UpCurvePath

const ARBITRARY_INOUT_DIVISOR_VALUE = 2

# relative positions, not global
@export var pos1 = Vector2.ZERO
@export var pos2 = Vector2.ZERO

func _ready():
	curve.add_point(pos1)
	curve.add_point(pos2)
	
	var xInOutCurve = (pos2.x-pos1.x)/ARBITRARY_INOUT_DIVISOR_VALUE
	var yInOutCurve = (pos2.y-pos1.y)/ARBITRARY_INOUT_DIVISOR_VALUE
	
	curve.set_point_out(0, Vector2(  xInOutCurve, -max(abs(xInOutCurve), -yInOutCurve)) )
	curve.set_point_out(1, Vector2( -xInOutCurve, 0) )
		

func _process(delta):
	pass
