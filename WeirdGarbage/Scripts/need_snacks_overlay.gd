class_name NeedSnacksOverlay extends Control

export(String) var needMoarSnacks:String
export(String) var noMoarSnacks:String

export(NodePath) var pathToLabel:NodePath

export(float) var displayDuration:float

export(float) var blinkFrequency:float

var label:Label
var timer:Timer
var elapsed_time:float

func _ready():
	self.label = self.get_node(self.pathToLabel)
	
	self.timer = Timer.new()
	timer.process_mode = Timer.TIMER_PROCESS_PHYSICS
	timer.autostart = false	
	timer.one_shot = true
	timer.wait_time = displayDuration
	self.timer.connect("timeout", self, "on_timeout")
	add_child(self.timer)
	
	self.elapsed_time = 0

func we_need_snacks() -> void:
	if !self.visible:
		display_message(self.needMoarSnacks)
	
func no_moar_snacks() -> void:
	self.timer.stop()
	
	display_message(self.noMoarSnacks)

func display_message(msg:String) -> void:
	self.label.text = msg
	
	self.visible = true
	
	self.timer.start()

func on_timeout() -> void:
	self.visible = false
	
func _process(delta):
	self.elapsed_time += delta
	
	if self.elapsed_time >= self.blinkFrequency:
		self.label.visible = !self.label.visible
		self.elapsed_time = 0
