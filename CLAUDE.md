# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Dinoguns** is a Godot 4.5 game featuring dinosaurs with guns in a survivor-like gameplay style. It's a top-down action game with ability-based combat, enemy waves, and character progression.

## Running the Project

- **Open in Godot**: Open the project in Godot 4.5 or later
- **Run Game**: Press F5 in Godot Editor or use the "Run Project" button
- **Main Scene**: `res://main.tscn`

## Required Development Practices

### Use Context7 for Godot Best Practices

**IMPORTANT**: When implementing new features, refactoring code, or making significant changes to Godot-specific systems, you MUST use the Context7 MCP tools to reference up-to-date Godot documentation and best practices:

1. Use `mcp__context7__resolve-library-id` with `libraryName: "godot"` to get the Godot library ID
2. Use `mcp__context7__get-library-docs` with the resolved library ID and relevant `topic` to fetch documentation

This ensures:
- Adherence to Godot 4.5+ API and conventions
- Proper use of GDScript idioms and patterns
- Correct node lifecycle management (_ready, _process, _physics_process)
- Appropriate signal usage and scene tree manipulation
- Performance best practices for game development

Always consult Context7 documentation when working with:
- Node management and scene tree operations
- Signal connections and custom signals
- Physics bodies and collision layers
- Resource loading and management
- Animation systems
- Input handling
- Custom editor plugins or tools

## Core Architecture

### Global Autoloads

The game uses several singleton autoloads defined in `project.godot`:

- **GameManager**: Handles game state transitions (start, game over, level up), character selection
- **SceneManager**: Manages scene transitions with deferred loading and callbacks
- **TimeManager**: Controls game time progression
- **SpawnManager**: Handles enemy spawning using object pooling
- **State**: Holds global state (current player reference)
- **Events**: Event bus for game-wide signals (character_selected, player_leveled_up, time_of_day_changed)
- **Logger**: Logging utility
- **Pooling**: Object pooling system for frequently instantiated objects (bullets, enemies, popups, items)
- **DialogueManager**: Third-party dialogue addon

### Actor System (Command Pattern)

The game uses a command pattern for actor control:

- **Actor** (`actors/Actor.gd`): Base class for all game entities (players, enemies). Extends CharacterBody2D
  - Contains `ActorStatManager` for stats
  - Has a `ControllerContainer` that holds an `ActorController`
  - Controllers issue `Command` objects to control actors

- **ActorController** (`actors/ActorController.gd`): Base controller class
  - **PlayerController**: Handles player input and ability activation
  - **EnemyController**: Simple AI that moves toward player with randomized movement cycles

- **Commands** (`actors/commands/`):
  - **MoveCommand**: Executes movement for actors

This separation allows the same Actor class to be controlled differently (player input vs AI).

### Ability System

Abilities are attached to actors via an `AbilityContainer` node:

- **Ability** (`abilities/ability.gd`): Base class for all abilities
  - Has `interval` (cooldown in ms) and `elapsed` time
  - Supports attaching modifiers that affect the ability or its damagers
  - `activate()` is called when ability triggers

- **Damager** (`abilities/Damager.gd`): Anything that can deal damage
  - Has `damage_type`, `base_damage`, `piercing`
  - References the `user` (Actor) to calculate final damage
  - Contains `HitBox` for collision detection
  - **Projectile** extends Damager with movement logic

- **Modifiers** (`abilities/modifiers/`): Modify ability behavior (e.g., RicochetModifier)

### Damage System

- **DamageService** (`actors/common/DamageService.gd`): Static utility for damage calculation
  - Supports damage types: PHYSICAL, FIRE, UNSTOPPABLE
  - Calculates actual damage based on target's stats (defense, fire_resist)

- **HitBox/HurtBox** (`actors/common/`):
  - HitBox: Attached to Damagers, detects collisions
  - HurtBox: Attached to Actors, receives damage

### Stats System

- **ActorStatManager** (`actors/ActorStatManager.gd`): Manages actor stats
  - Stats: attack, defense, health, move_speed, attack_speed, health_regen, fire_resist
  - Each stat is a `Stat` object that supports base values and modifiers
  - Handles damage calculation, death state, health regeneration

### Item System

- **Item** (`items/item.gd`): Base class for pickupable items (extends RigidBody2D)
  - Uses state machine pattern (STATIC, LAUNCHED, SEEKING)
  - Items can be launched (with physics) then seek toward player
  - **ItemFactory** (`items/item_factory.gd`): Creates items using pooling

### Level System

- **Level** (`levels/level.gd`): Base class for game levels
  - Contains: `map` (TileMap), `items_container`, `spawns_container`, `popup_container`
  - Parses spawn patterns from files via `SpawnFlow`
  - Responds to time-of-day changes

### Scene Structure

- Physics Layers (defined in `project.godot`):
  - Layer 1: player
  - Layer 2: enemy
  - Layer 3: wall
  - Layer 4: item
  - Layer 5: projectile

### Object Pooling

The `Pooling` autoload manages pools for frequently created objects:
- Pool types: BULLET, FIREBALL, POPUP, COMPY, AMBER, BIG_AMBER
- Use `Pooling.get_from_pool(type, instance_func)` to get pooled instances
- Objects automatically return to pool when removed from scene tree
- All pooled objects must implement `setup()` method for reinitialization

### State Machines

Generic `StateMachine` class (`state_machine.gd`) used for both items and potentially other systems:
- Methods: `enter_state()`, `exit_state()`, `process_movement()`, `process_physics()`
- Concrete implementations handle specific state logic

## Development Patterns

### Adding New Abilities

1. Create new script extending `Ability` class
2. Override `_internal_activate(user, spawn_marker)`
3. Create damagers and attach them to the scene
4. Use `attached_modifiers` or `attached_damager_modifiers` to modify behavior
5. Add ability node to actor's `AbilityContainer`

### Adding New Enemies

1. Create scene extending `Enemy` (which extends `Actor`)
2. Set up `ActorStatManager` resource with base stats
3. Enemy automatically uses `EnemyController` for AI
4. Add to `Pooling.PoolType` enum and update `SpawnManager` if needed

### Using Events

Connect to signals in the `Events` autoload for game-wide communication:
```gdscript
Events.player_leveled_up.connect(_on_player_leveled_up)
Events.character_selected.connect(_on_character_selected)
Events.time_of_day_changed.connect(_on_time_of_day_changed)
```

### Scene Transitions

Use `SceneManager.change_scene(path, callback)` for safe scene transitions with deferred loading and optional callbacks.
