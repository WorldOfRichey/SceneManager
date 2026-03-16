class_name SceneTransition
extends Node

signal signal_in_transition_started
signal signal_in_transition_ended
signal signal_out_transition_started
signal signal_out_transition_ended

func _trigger_transition_in() -> void :
	signal_in_transition_started.emit()

func _trigger_transition_out() -> void :
	signal_out_transition_started.emit()
