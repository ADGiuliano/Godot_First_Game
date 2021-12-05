extends Area2D

# How fast the player will move (pixels/sec).
export var speed = 400;
# Size of the game window.
var screen_size;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size;
	hide();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Vector2 is the player moement vecot
	var velocity = Vector2();
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1;
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1;
	
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1;
		
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1;
		
	if velocity.length() > 0:
		# To avoid fast diagonal movement.
		velocity = velocity.normalized() * speed;
		# $ return the rispective node object
		$PlayerAnimatedSprite.play();
	else:
		# $ return the rispective node object
		$PlayerAnimatedSprite.stop();
	
	# Update the player position
	position += velocity * delta;
	
	# Clamp prevent the player from leaving the screen
	position.x = clamp(position.x, 0, screen_size.x);
	position.y = clamp(position.y, 0, screen_size.y);
	
	# Change the animation in base of the vector direction
	if velocity.x != 0:
		$PlayerAnimatedSprite.animation = "walk";
		$PlayerAnimatedSprite.flip_v = false;
		$PlayerAnimatedSprite.flip_h = velocity.x < 0;
	elif velocity.y != 0:
		$PlayerAnimatedSprite.animation = "up";
		$PlayerAnimatedSprite.flip_v = velocity.y > 0;
	
	
