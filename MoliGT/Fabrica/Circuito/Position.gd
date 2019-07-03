extends Node



static func sort(a, b):
	if a.x > b.x:
		return true
	if b.y < a.y and a.y < 0:
		return true
	if a.y > 0 and b.y > 0:
		if b.y > a.y and a.y > 1.75 and a.z > 800 and b.z > 800 :
			return true
		if 800 < a.z and a.z < 1675 and 800 < b.z and b.z < 1675 and a.y < b.y:
			return true 
		if a.z > b.z and b.z > 660 and 1.6 > a.y and a.y > 1.3 and 1.6 > b.y and b.y > 1.3:
			return true
		return true
	return false