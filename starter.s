.data
sequence:  .byte 0,0,0,0
usersequence: .byte 0,0,0,0
count:     .byte 4
num0: .byte 0
num1: .byte 1
num2: .byte 2
num3: .byte 3

prompt: .string "Want to play again? Enter 0 for yes and 1 for No: "
prompt1: .string "  You Made a mistake!!!"
prompt2: .string "  Congratulations! You are great at this game!!"
prompt3: .string "  You timed out"
prompt4: .string "Enter the number of players: "
prompt5: .string "It is time to play! Go ahead player "
prompt6: .string "=============Game Summary=========="
prompt7: .string "Player "
prompt8: .string "Start Guessing!"
nextLine: .string "\n"
white: .byte 255 255 255
black: .byte 0 0 0
.globl main
.text

main:
    # part of the multiplayer enhancement
    la a0, prompt4
    li a7, 4
    ecall
    call readInt
    mv s2, a0 # s2 contains the number of players 
    li s3,0 # counter to keep track of how many plyers have played
    li s4, 0x10000120 # current end of .data segment 
    add s5, s4, s2 # The new end
    mv a0, s5
    li a7, 214
    ecall
    li s9, 0x10000120 # multiplayer enhancement 

    
    
    RESTART:
     li s9, 0x10000120 # multiplayer enhancement 
    # TODO: Before we deal with the LEDs, we need to generate a random
    # sequence of numbers that we will use to indicate the button/LED
    # to light up. For example, we can have 0 for UP, 1 for DOWN, 2 for
    # LEFT, and 3 for RIGHT. Store the sequence in memory. We provided 
    # a declaration above that you can use if you want.
    # HINT: Use the rand function provided to generate each number
    
    # prints which player's turn 
    addi s3, s3, 1
    la a0, prompt5
    li a7, 4
    ecall
    
    mv a0, s3
    li a7, 1
    ecall
    
    la a0, nextLine
    li a7, 4
    ecall
    
    
    
    
    # Now, generating a sequence of random integers
    
        
    li t2, 4        # store 4 to choose a random number from 0 - 4
    mv a0, t2       # setting up arguments for rand
    jal rand        # function call
    mv t1, a0
    la t0, sequence 
    sb t1, 0(t0)

    
    li t2, 4        # store 4 to choose a random number from 0 - 4
    mv a0, t2       # setting up arguments for rand
    jal rand        # function call
    la t0, sequence 
    sb a0, 1(t0)


    li t2, 4        # store 4 to choose a random number from 0 - 4
    mv a0, t2       # setting up arguments for rand
    jal rand        # function call
    la t0, sequence 
    sb a0, 2(t0)
    
    
      
    li t2, 4        # store 4 to choose a random number from 0 - 4
    mv a0, t2       # setting up arguments for rand
    jal rand        # function call
    la t0, sequence 
    sb a0, 3(t0)

    
    # TODO: Now read the sequence and replay it on the LEDs. You will
    # need to use the delay function to ensure that the LEDs light up 
    # slowly. In general, for each number in the sequence you should:
    # 1. Figure out the corresponding LED location and colour
    # 2. Light up the appropriate LED (with the colour)
    # 2. Wait for a short delay (e.g. 500 ms)
    # 3. Turn off the LED (i.e. set it to black)
    # 4. Wait for a short delay (e.g. 1000 ms) before repeating
    
    # 0 - TOPLEFT - (0,0)
    # 1 - TOPRIGHT - (1,0)
    # 2 - LOWERLEFT - (0,1)
    # 3 - LOWERRIGHT- (1,1)
    li a6, 0 # loop counter
    la t0, sequence
    lb t2, 0(t0)
    IF:
        lb t1, num0
        beq t1, t2, TOPLEFT
    
        lb t1, num1
        beq t1, t2, TOPRIGHT
   
        lb t1, num2
        beq t1, t2, LOWERLEFT
    
        lb t1, num3
        beq t1, t2, LOWERRIGHT    
    
    TOPLEFT:
        lb a0, white
        li a1, 0
        li a2, 0
        jal setLED
        li a0, 500
        jal delay
        lb a0, black
        li a1, 0
        li a2, 0
        jal setLED
        j END
    TOPRIGHT:
        lb a0, white
        li a1, 1
        li a2, 0
        jal setLED
        li a0, 500
        jal delay
        lb a0, black
        li a1, 1
        li a2, 0
        jal setLED
        j END
    LOWERLEFT:
        lb a0, white
        li a1, 0
        li a2, 1
        jal setLED
        li a0, 500
        jal delay
        lb a0, black
        li a1, 0
        li a2, 1
        jal setLED
        j END
    LOWERRIGHT:
        lb a0, white
        li a1, 1
        li a2, 1
        jal setLED
        li a0, 500
        jal delay
        lb a0, black
        li a1, 1
        li a2, 1
        jal setLED
        j END
    END:
        li a0 ,1000
        jal delay
        lb t0, count
        addi a6, a6, 1
        beq t0, a6, ENDFOREVER
        
        li t6, 1
        beq t6, a6, FIRSTINCREMENT
        li t6, 2
        beq t6, a6, SECONDINCREMENT
        li t6, 3
        beq t6, a6, THIRDINCREMENT
        j ENDFOREVER
    FIRSTINCREMENT:
        la t0, sequence
        lb t2, 1(t0)
        j IF
    SECONDINCREMENT:
        la t0, sequence
        lb t2, 2(t0)
        j IF
    THIRDINCREMENT:
        la t0, sequence
        lb t2, 3(t0)
        j IF
    
    ENDFOREVER:
        la, a0, prompt8
        li a7, 4
        ecall
        la, a0, nextLine
        li a7, 4
        ecall
        
 
    
    # TODO: Read through the sequence again and check for user input
    # using pollDpad. For each number in the sequence, check the d-pad
    # input and compare it against the sequence. If the input does not
    # match, display some indication of error on the LEDs and exit. 
    # Otherwise, keep checking the rest of the sequence and display 
    # some indication of success once you reach the end.
    # 0 - TOPLEFT - (0,0)
    # 1 - TOPRIGHT - (1,0)
    # 2 - LOWERLEFT - (0,1)
    # 3 - LOWERRIGHT- (1,1)
    li a7,30
    ecall
    mv t6, a0 # time out enhancement 
    
    jal pollDpad
    la t0, sequence
    lb t1, 0(t0)
    bne a0, t1, ERROR
    
    jal pollDpad
    la t0, sequence
    lb t1, 1(t0)
    bne a0, t1, ERROR
    
    jal pollDpad
    la t0, sequence
    lb t1, 2(t0)
    bne a0, t1, ERROR
    
    jal pollDpad
    la t0, sequence
    lb t1, 3(t0)
    bne a0, t1, ERROR
    
    li a7, 30
    ecall
    sub t0, a0, t6
    li t1, 5000
    bge t0, t1, TIME # timeout enhancement 
     
    j SUCCESS
    
    ERROR:
        # error display
        lb a0, white
        li a1, 0
        li a2, 0
        jal setLED
        
        
        lb a0, white
        li a1, 0
        li a2, 1
        jal setLED
        
         lb a0, white
        li a1, 1
        li a2, 0
        jal setLED
        
         lb a0, white
        li a1, 1
        li a2, 1
        jal setLED
         # change in colour
         li a0, 1000
         jal delay
         
         lb a0, black
        li a1, 0
        li a2, 0
        jal setLED
        
        
        lb a0, black
        li a1, 0
        li a2, 1
        jal setLED
        
         lb a0, black
        li a1, 1
        li a2, 0
        jal setLED
        
         lb a0, black
        li a1, 1
        li a2, 1
        jal setLED
        
        li t0, 0
        sb t0, 0(s9)
        addi s9, s9, 1
        #la t0, prompt1
        #mv a0, t0
        #li a7, 4
        #ecall
        j NEXT
        
    SUCCESS:
        li t0, 1
        sb t0, 0(s9)
        addi s9, s9, 1
       # la t0, prompt2
        #mv a0, t0
       # li a7, 4
        #ecall
        j NEXT
    TIME:
        li t0, 2
        sb t0, 0(s9)
        addi s9, s9, 1
       # la t0, prompt3
       # mv a0, t0
       # li a7, 4
        #ecall
        j NEXT
        
    # TODO: Ask if the user wishes to play again and either loop back to
    # start a new round or terminate, based on their input.
    NEXT:

        beq s3, s2 ,NEXT1
        j RESTART
        
    # enhancement 1: MULTIPLAYER 
        
    NEXT1:
        # print the heading of game summary 
        la a0, prompt6
        li a7, 4
        ecall
        # printing new line 
        la a0, nextLine
        li a7, 4
        ecall
        
        li s10, 0 # counter to keep tract of prints of result
        li s11, 0x10000120 # stack pointer
        NEXT11:
        beq s10,s2, ASK
        addi s10, s10, 1
        
        # printing player number 
        la, a0, prompt7
        li a7, 4
        ecall
        mv a0, s10
        li a7, 1
        ecall 
        
        # accessing player's record
        lb t3, 0(s11)
        li t2, 0
        beq t2, t3, OUTPUT0
        li t2, 1
        beq t2, t3, OUTPUT1
         li t2, 2
        beq t2, t3, OUTPUT3
        
        OUTPUT0:
             la t0, prompt1
             mv a0, t0
             li a7, 4
             ecall
             la t0, nextLine
             mv a0, t0
             li a7, 4
             ecall
             addi s11, s11, 1
             j NEXT11
         OUTPUT1:
             la t0, prompt2
             mv a0, t0
             li a7, 4
             ecall
                la t0, nextLine
             mv a0, t0
             li a7, 4
             ecall
             addi s11, s11, 1
             j NEXT11
         OUTPUT3:
             la t0, prompt3
             mv a0, t0
             li a7, 4
             ecall
                la t0, nextLine
             mv a0, t0
             li a7, 4
             ecall
             addi s11, s11, 1
             j NEXT11
 
     ASK:
        li a7, 4
        ecall
        li s3, 0
        la t0, prompt
        mv a0, t0
        li a7, 4
        ecall
        call readInt
        mv t0, a0
        li t1, 0
        beq t0, t1, RESTART

        j exit
    
exit:
 
    li a7, 10
    ecall
    



     
    
# --- HELPER FUNCTIONS ---
# Feel free to use (or modify) them however you see fit
     
# Takes in the number of milliseconds to wait (in a0) before returning
delay:
    mv t0, a0
    li a7, 30
    ecall
    mv t1, a0
delayLoop:
    ecall
    sub t2, a0, t1
    bgez t2, delayIfEnd
    addi t2, t2, -1
delayIfEnd:
    bltu t2, t0, delayLoop
    jr ra

# Takes in a number in a0, and returns a (sort of) random number from 0 to
# this number (exclusive)
rand:
    mv t0, a0
    li a7, 30
    ecall
    remu a0, a0, t0
    jr ra
    
# Takes in an RGB color in a0, an x-coordinate in a1, and a y-coordinate
# in a2. Then it sets the led at (x, y) to the given color.
setLED:
    li t1, LED_MATRIX_0_WIDTH
    mul t0, a2, t1
    add t0, t0, a1
    li t1, 4
    mul t0, t0, t1
    li t1, LED_MATRIX_0_BASE
    add t0, t1, t0
    sw a0, (0)t0
    jr ra
    
# Polls the d-pad input until a button is pressed, then returns a number
# representing the button that was pressed in a0.
# The possible return values are:
# 0: UP
# 1: DOWN
# 2: LEFT
# 3: RIGHT
pollDpad:
    mv a0, zero
    li t1, 4
pollLoop:
    bge a0, t1, pollLoopEnd
    li t2, D_PAD_0_BASE
    slli t3, a0, 2
    add t2, t2, t3
    lw t3, (0)t2
    bnez t3, pollRelease
    addi a0, a0, 1
    j pollLoop
pollLoopEnd:
    j pollDpad
pollRelease:
    lw t3, (0)t2
    bnez t3, pollRelease
pollExit:
    jr ra
    
readInt:
    addi sp, sp, -12
    li a0, 0
    mv a1, sp
    li a2, 12
    li a7, 63
    ecall
    li a1, 1
    add a2, sp, a0
    addi a2, a2, -2
    mv a0, zero
parse:
    blt a2, sp, parseEnd
    lb a7, 0(a2)
    addi a7, a7, -48
    li a3, 9
    bltu a3, a7, error
    mul a7, a7, a1
    add a0, a0, a7
    li a3, 10
    mul a1, a1, a3
    addi a2, a2, -1
    j parse
parseEnd:
    addi sp, sp, 12
    ret

error:
    li a7, 93
    li a0, 1
    ecall
