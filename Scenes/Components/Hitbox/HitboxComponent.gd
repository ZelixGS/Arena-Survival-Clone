class_name HitboxComponent extends Area2D

signal strike(node: Node2D)

var damage: int = 0
var crit_amp: float = 1.0
var type: G.Damage = G.Damage.PHYSICAL
