extends RefCounted
class_name ShaderEffects


static func flash(material: ShaderMaterial, active: bool):
	material.set_shader_parameter("active", active)
