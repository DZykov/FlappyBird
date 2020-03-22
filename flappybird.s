# Bitmap Display Configuration:
# - Unit width in pixels: 8					     
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
.data
	# Screen
	displayAddress:	.word	0x10008000
	screenLength: 	.word 64
	
	# Colours
	backgroundColour:.word	0x5f87ff	# blue
	birdColour:	.word	0xffff00	# yellow
	pipeColour:	.word	0x00ff00	# green
	
	# Score variables
	score:		.word	0
	scoreIncrease:	.word	10	# changes as game goes harder
	
	# Bird Settings
	birdSpeed:	.word	8	# inreases as game continues
	birdX:		.word	0
	birdY:		.word	0
	
	# Global Settings
	gravity:	.word	1
	dayTime:	.word	0	# either 0 or 1
	
	# Start
	greetingsMessage:.asciiz "Do you want to start? "
	
	# Ending
	loseMessage:.asciiz "You have kissed a pipe! Your score is: "
	againMessage:	.asciiz "Would you like to play again?"
	
.text

Main:
	
	lw $t0, displayAddress
	lw $t1, backgroundColour
	lw $a0, screenLength
	mul $a2, $a0, $a0
	mul $a2, $a2, 4
	add $a2, $a2, $gp
	add $t0, $gp, $zero
	
backgroundLoop:
	beq $t0, $a2, Init
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	j backgroundLoop
	
Init:
	# Initialize a bird
	lw $a0, birdX
	lw $a1, birdY
	jal GetCoordinates
	move $a0, $v0
	lw $a1, birdColour
	jal DrawPixel
	
GravityDraw: # Fix it (doe snot work)
	lw $t0, birdX
	lw $t1, birdY
	lw $t3, gravity($zero)
	add $t1, $t1, $t3
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal GetCoordinates
	add $a0, $v0, $zero
	lw $a1, birdColour
	jal DrawPixel
	j GravityDraw
	
GetCoordinates:
	lw $v0, screenLength
	mul $v0, $v0, $a1	# multiply by y position
	add $v0, $v0, $a0	# add the x position
	mul $v0, $v0, 4		# multiply by 4
	add $v0, $v0, $gp	# add global pointerfrom bitmap display
	jr $ra
	
DrawPixel:
	sw $a1, ($a0)
	jr $ra	

Exit:
	li $v0, 10 # terminate the program gracefully
	syscall
