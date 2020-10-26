#####################################################################
#
# CSC258H5S Winter 2020 Assembly Programming Project
# University of Toronto Mississauga
#
# Group members:
# - Student 1: Demid Zykov
# - Student 2: Stepan Khytushko
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8					     
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4/5 (choose the one the applies)
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. the bird and obstacle objects are properly drawn (statically) on the screen
# 2. the movement controls of the bird and obstacles (by the keyboard and timers) are properly implemented
# 3. a basic version of the game (similar to the one shown in the video demo above) is properly implemented.
# 4. More realistic physics
# 5. Score
# 6. Level
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################
                    
.data
	# Screen
	displayAddress:	.word	0x10008000
	screenLength: 	.word 64
	
	# Colours
	backgroundColour:.word	0x5f87ff	# blue
	birdColour:	.word	0xffff00	# yellow
	pipeColour:	.word	0x00ff00	# green
	grayColour:	.word	0x584b4b	# gray
	brownColour:  	.word 	0xcc6600	# brown
	
	# Score variables
	score:		.word	0
	scoreIncrease:	.word	10	# changes as game goes harder
	
	# Bird Settings
	birdSpeed:	.word	8	# inreases as game continues
	birdX:		.word	1
	birdY:		.word	8
	birdLX:		.word	5
	birdLY:		.word	8
	
	# Pipe Settings
	pipeX:		.word   32
	pipeY:		.word   10
	pipeLX:		.word   32
	pipeLY:		.word   10
	
	pipeInitX: 	.word  	32
	pipeInitY:	.word 	10
	
	
	# GG
	GGX: 		.word 	11
	GGY:		.word 	8
	
	
	#floor Settings
	floorX:		.word 	1
	floorY: 	.word 	16
	
	# Global Settings
	gravity:	.word	1
	dayTime:	.word	0	# either 0 or 1
	jump:        	.word   -1
	pause:		.word	250
	
	# Start
	greetingsMessage:.asciiz "Do you want to start? "
	
	# Ending
	loseMessage:.asciiz "You have kissed a pipe! Your score is: "
	againMessage:	.asciiz "Would you like to play again?"
	
	
	newline: .asciiz "\n"
	
.text

main:
	lw $a0, screenLength
	lw $a1, backgroundColour
	mul $a2, $a0, $a0 # number of pixels on screen
	mul $a2, $a2, 4 
	add $a2, $a2, $gp 
	add $a0, $gp, $zero
	
BackgroundLoop:
	beq $a0, $a2, Input
	sw $a1, 0($a0) 
	addiu $a0, $a0, 4
	j BackgroundLoop	
	
Input:
	Floor:
	lw $a0, floorX
	lw $a1, floorY
	jal GetCoordinates
	move $a0, $v0
	jal DrawFloor
	
	
	# pause the game -> make a tic
	lw $a0, pause
	jal Sleep
	
	# get coordinates of the old bird and save
	lw $a0, birdLX
	lw $a1, birdLY
	jal GetCoordinates
	move $a0, $v0
	
	# delete the old bird
	jal DeleteBird
	
	# get coordinates of the old pipe and save
	lw $t8, pipeLX
	lw $t9, pipeLY
	
	
	move $a0, $t8
	move $a1, $t9

	jal GetCoordinates
	move $a0, $v0
	
	
	# delete the old pipe
	jal DeletePipe
	
	lw $a0, pipeX
	addi $a1, $a1, 1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipe
		
	lw $a0, pipeX
	addi $a1, $a1, 1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipe
	
	lw $a0, pipeX
	addi $a1, $a1, 1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipe
	
	lw $a0, pipeX
	addi $a1, $a1, 1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipe
	
	lw $a0, pipeX
	addi $a1, $a1, 1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipe
	
	
	lw $a0, pipeX
	addi $a1, $a1, 1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipe
	
	
	lw $a0, pipeX
	addi $a1, $a1, 1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipe
	
	
	lw $a0, pipeX
	addi $a1, $a1, 1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipe
	
	lw $a0, pipeX
	addi $a1, $a1, 1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipe
	
	
	lw $a1, pipeLY
	lw $a0, pipeLX
	addi $a1, $a1, -3
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipeU
	
	
	lw $a0, pipeLX
	addi $a1, $a1, -1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipeU
	
	
	lw $a0, pipeLX
	addi $a1, $a1, -1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipeU
	
	lw $a0, pipeLX
	addi $a1, $a1, -1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipeU
	
	
	lw $a0, pipeLX
	addi $a1, $a1, -1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipeU
	
	
	lw $a0, pipeLX
	addi $a1, $a1, -1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipeU
	
	
	lw $a0, pipeLX
	addi $a1, $a1, -1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipeU
	
	
	
	lw $a0, pipeLX
	addi $a1, $a1, -1
	jal GetCoordinates
	move $a0, $v0
	jal DeletePipeU
	
	# check to create a new pipe or move an old pipe
	lw $t0, birdX
	lw $t2, pipeX
	
	
	IF:
	beqz $t2, THEN
	j ELSE
		
	THEN:	
		
		# Initialize the Pipe
		
		lw $a0, pipeInitX
		lw $a1, pipeInitY
		sw $a0, pipeX
		

		jal RandomInt
		move $a0, $v0
		sw $a0, pipeY
		
		
		
		
		# save x and y of pipe to xLast/yLast
		
		li $t5, 7
		
		lw $a0, pipeInitX
		
		
		sw $a0, pipeLX
		sw $t5, pipeLY
		
		sw $a0, pipeX
		sw $t5, pipeY
		
		lw $a1, pipeY
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		
		lw $a0, pipeX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		
		lw $a0, pipeX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		
		lw $a0, pipeX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		
		lw $a0, pipeX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		
		lw $a0, pipeX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		
		lw $a0, pipeX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		
		lw $a1, pipeY
		lw $a0, pipeX
		addi $a1, $a1, -3
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		lw $a0, pipeX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		
		lw $a0, score
		add $a0, $a0, 1
		sw $a0, score
		beq $a0, 2, levelup
		beq $a0, 4, levelup
		beq $a0, 6, levelup
		beq $a0, 15, levelup
		
		j CNT
		
		levelup:
			lw $a0, pause
			addi $a0, $a0, -45
			sw $a0, pause
		
			j CNT
	
	ELSE:
		
		# move pipe

		lw $t8, pipeX
		addi $t8, $t8, -1
		sw $t8, pipeX
		sw $t8, pipeLX
		
		
		lw $t9, pipeY
		sw $t9, pipeLY
		
		lw $a1, pipeLY
		
		lw $a0, pipeLX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeLX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeLX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeLX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeLX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeLX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeLX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeLX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a0, pipeLX
		addi $a1, $a1, 1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipe
		
		lw $a1, pipeLY
		lw $a0, pipeLX
		addi $a1, $a1, -3
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		lw $a0, pipeLX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeLX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeLX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeLX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeLX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeLX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		lw $a0, pipeLX
		addi $a1, $a1, -1
		jal GetCoordinates
		move $a0, $v0
		jal DrawPipeU
		
		
		j CNT
	
	CNT:
	# get coordinates of the bird and save
	lw $a0, birdX
	lw $a1, birdY
	jal GetCoordinates
	move $a0, $v0
	
	# draw bird
	jal DrawBird
	
	# input
	jal getChar
    	addi $t1, $v0, 0
	beq  $t1, 102, Jump # 102 = f


Fall:
	# load x and y of bird
	lw $t0, birdX
	lw $t1, birdY
	
	# lave x and y of bird to xLast/yLast
	sw $t0, birdLX
	sw $t1, birdLY
	
	# y - 1 of bird
	lw $t3, gravity
	add $t1, $t1, $t3
	
	# save changes
	sw $t0, birdX
	sw $t1, birdY
	
	
	
	j Input

Jump:
	# load x and y of bird
	lw $t0, birdX
	lw $t1, birdY
	
	# lave x and y of bird to xLast/yLast
	sw $t0, birdLX
	sw $t1, birdLY
	
	# y - 1 of bird
	lw $t3, jump
	add $t1, $t1, $t3
	
	# save changes
	sw $t0, birdX
	sw $t1, birdY
	
	j Input


# FUNCTIONS

# takes nothing
# return v0 = key number
getChar:
    	lui $a3, 0xffff
    	loop:
        	lw $t1, 0($a3)
        	andi $t1, $t1, 0x1
        	beqz $t1, Fall
        	lw $v0, 4($a3)
        	jr $ra

# a0 = adress of position at bitmap display
DrawPipe:
	lw $t1, pipeColour
	
	sw $t1, -4($a0)
	sw $t1, -8($a0)
	sw $t1, -12($a0)
	sw $t1, -16($a0)
	sw $t1, 124($a0)
	sw $t1, 120($a0)
	sw $t1, 116($a0)
	sw $t1, 112($a0)
	jr $ra
	
DrawPipeU:
	
	lw $t1, pipeColour
	sw $t1, -4($a0)
	sw $t1, -8($a0)
	sw $t1, -12($a0)
	sw $t1, -16($a0)
	
	sw $t1, -132($a0)
	sw $t1, -136($a0)
	sw $t1, -140($a0)
	sw $t1, -144($a0)
	jr $ra
	

# a0 = adress of position at bitmap display
DeletePipe:
	lw $t1, backgroundColour
	sw $t1, -4($a0)
	sw $t1, -8($a0)
	sw $t1, -12($a0)
	sw $t1, -16($a0)
	sw $t1, 124($a0)
	sw $t1, 120($a0)
	sw $t1, 116($a0)
	sw $t1, 112($a0)
	jr $ra
	
	
DeletePipeU:

	lw $t1, backgroundColour
	sw $t1, -4($a0)
	sw $t1, -8($a0)
	sw $t1, -12($a0)
	sw $t1, -16($a0)
	
	sw $t1, -132($a0)
	sw $t1, -136($a0)
	sw $t1, -140($a0)
	sw $t1, -144($a0)
	jr $ra
	

# a0 = adress of position at bitmap display
DrawBird:
	# check collision
	lw $t3, backgroundColour
	lw $t4, 0($a0)
	bne $t3, $t4, Exit
	lw $t4, 4($a0)
	bne $t3, $t4, Exit
	lw $t4, 8($a0)
	bne $t3, $t4, Exit
	lw $t4, 128($a0)
	bne $t3, $t4, Exit
	lw $t4, 132($a0)
	bne $t3, $t4, Exit
	lw $t4, 136($a0)
	bne $t3, $t4, Exit
	lw $t4, 140($a0)
	bne $t3, $t4, Exit
	# draw
	lw $t1, birdColour
	lw $t2, grayColour
        sw $t1, 4($a0)
	sw $t1, 8($a0)
	sw $t2, 128($a0)
	sw $t2, 132($a0)
	sw $t2, 136($a0)
	sw $t2, 140($a0)
	jr $ra

# a0 = adress of position at bitmap display
DrawFloor:
	lw $t3, brownColour
	sw $t3, 0($a0)
	sw $t3, 4($a0)
	sw $t3, 8($a0)
	sw $t3, 12($a0)
	sw $t3, 16($a0)
	sw $t3, 20($a0)
	jr $ra


# a0 = adress of position at bitmap display
DeleteBird:
	lw $t1, backgroundColour
        sw $t1, 4($a0)
	sw $t1, 8($a0)
	sw $t1, 128($a0)
	sw $t1, 132($a0)
	sw $t1, 136($a0)
	sw $t1, 140($a0)
	jr $ra

# a0 = x-axis
# a1 = y-axis
# returns v0 = the adress for bitmap display
GetCoordinates:
	lw $v0, screenLength
	mul $v0, $v0, $a1	# multiply by y position
	add $v0, $v0, $a0	# add the x position
	mul $v0, $v0, 4		# multiply by 4
	add $v0, $v0, $gp	# add global pointerfrom bitmap display
	jr $ra 
	
# a0 = adress of position at bitmap display
# a1 = colour of pixel
# return nothing
DrawPixel:
	sw $a1, ($a0)
	jr $ra	
	
	
DrawGG:
	lw $t1, grayColour
	
	sw $t1,	-124($a0)
	sw $t1,	-120($a0)
	sw $t1,	($a0)
	sw $t1,	128($a0)
	sw $t1,	256($a0)
	sw $t1,	388($a0)
	sw $t1,	392($a0)
	sw $t1,	264($a0)
	sw $t1,	268($a0)
	
	sw $t1,	-104($a0)
	sw $t1,	-100($a0)
	sw $t1,	20($a0)
	sw $t1,	148($a0)
	sw $t1,	276($a0)
	sw $t1,	408($a0)
	sw $t1,	412($a0)
	sw $t1,	284($a0)
	sw $t1,	288($a0)
	
	jr $ra



# a0 = number to sleep
Sleep:
	li $v0, 32 #syscall value for sleep
	syscall
	jr $ra


# return v0 = random int
RandomInt:
	li $a0, 0
	li $a1, 0
	
	li $v0, 42
	li $a1, 10
    	syscall
    	add $a0, $a0, 2
	jr $ra
	

Exit:
	lw $a0, screenLength
	lw $a1, backgroundColour
	mul $a2, $a0, $a0 # number of pixels on screen
	mul $a2, $a2, 4 
	add $a2, $a2, $gp 
	add $a0, $gp, $zero
	
BackgroundLoop2:
	beq $a0, $a2, DrawEnd
	sw $a1, 0($a0) 
	addiu $a0, $a0, 4
	j BackgroundLoop2
	
DrawEnd:
	lw $a0, GGX
	lw $a1, GGY
	
	jal GetCoordinates
	move $a0, $v0
	jal DrawGG
	
	
	
	li $v0, 10
	syscall

