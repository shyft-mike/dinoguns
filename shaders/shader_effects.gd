extends RefCounted
class_name ShaderEffects


static func flash(material: ShaderMaterial, active: bool, color: Color = Color.WHITE):
	material.set_shader_parameter("active", active)
	material.set_shader_parameter("flash_color", color)
