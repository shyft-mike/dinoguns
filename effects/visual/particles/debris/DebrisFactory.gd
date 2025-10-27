class_name DebrisFactory extends Node

enum DebrisType {CARTRIDGE,SHELL}

static var cartridge_template = preload("res://effects/visual/particles/debris/SpentCartridge.tscn")
static var shell_template = preload("res://effects/visual/particles/debris/SpentShell.tscn")


static func generate(type: DebrisType) -> Item:
	var result: Item

	match type:
		DebrisType.CARTRIDGE:
			result = Pooling.get_from_pool(
				Pooling.PoolType.CARTRIDGE,
				func(): return cartridge_template.instantiate())
		DebrisType.SHELL:
			result = Pooling.get_from_pool(
				Pooling.PoolType.SHELL,
				func(): return shell_template.instantiate())

	return result
