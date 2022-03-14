# to be a term for relative error due to rounding in floating point arithmetic
# Jingbo Wang
  .data
newline:
  .asciiz "\n"
string1:
  .asciiz "0.5^52 = "
string2:
  .asciiz "(1 + 0.5^52) - 1 = "
string3:
  .asciiz "(1 + 0.5^53) - 1 = "
string4:
  .asciiz "(1 + (0.5^53+0.5^54)) - 1 = "
string5:
  .asciiz "(1 + (0.5^53+0.5^105)) - 1 = "
zero:
  .double 0.0
one:
  .double 1.0
num2:
  .word 52
num3:
  .word 53
num4:
  .word 54
num5:
  .word 105
double_num:
  .double 0.5
  .text
  .globl main
main:
  la    $a0, string1        # load address string1 into a0
  jal   printString         # function call
  ldc1 $f0, zero            # f0 = 0.0
  ldc1  $f2, double_num     # save double_num into a1
  lw    $a2, num2           # load num2 into a2
  jal   power               # function call: 0.5^52
  jal   printDouble         # function call
  jal   printNewline        # function call

  la    $a0, string2        # load address string1 into a0
  jal   printString         # function call
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f4, one            # f2 = 1.0
  mov.d $f2, $f12           # f2 = f12
  jal   addDouble           # function call: 1 + 0.5^52
  mov.d $f2, $f0            # f2 = f0
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f4, one            # f2 = 1
  jal   subDouble           # function call: (1 + 0.5^52) - 1
  jal   printDouble         # function call
  jal   printNewline        # function call

  la    $a0, string3        # load address string1 into a0
  jal   printString         # function call
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f2, double_num     # save double_num into a1
  lw    $a2, num3           # load num2 into a2
  jal   power               # function call: 0.5^53
  mov.d $f2, $f0            # f2 = f0
  ldc1  $f4, one            # f2 = 1.0
  ldc1  $f0, zero           # f0 = 0.0
  jal   addDouble           # function call: 1 + 0.5^53
  mov.d $f2, $f0            # f2 = f0
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f4, one            # f2 = 1
  jal   subDouble           # function call: (1 + 0.5^53) - 1
  jal   printDouble         # function call
  jal   printNewline        # function call

  la    $a0, string4        # load address string1 into a0
  jal   printString         # function call
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f2, double_num     # save double_num into a1
  lw    $a2, num3           # load num2 into a2
  jal   power               # function call: 0.5^53
  mov.d $f6, $f0            # f6 = f0
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f2, double_num     # save double_num into a1
  lw    $a2, num4           # load num2 into a2
  jal   power               # function call: 0.5^54
  mov.d $f2, $f0            # f2 = f0
  mov.d $f4, $f6            # f4 = f6
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f6, zero           # f6 = 0.0
  jal   addDouble           # function call: 0.5^53 + 0.5^54
  mov.d $f2, $f0            # f2 = f0
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f4, one            # f2 = 1
  jal   addDouble           # function call 1 +(0.5^53 + 0.5^54)
  mov.d $f2, $f0            # f2 = f0
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f4, one            # f2 = 1
  jal   subDouble           # function call: (1 +(0.5^53 + 0.5^54)) - 1
  jal   printDouble         #function call
  jal   printNewline        # function call

  la    $a0, string5      # load address string1 into a0
  jal   printString         # function call
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f2, double_num     # save double_num into a1
  lw    $a2, num3           # load num2 into a2
  jal   power               # function call: 0.5^53
  mov.d $f6, $f0            # f6 = f0
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f2, double_num     # save double_num into a1
  lw    $a2, num5           # load num2 into a2
  jal   power               # function call: 0.5^105
  mov.d $f2, $f0            # f2 = f0
  mov.d $f4, $f6            # f4 = f6
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f6, zero           # f6 = 0.0
  jal   addDouble           # function call: 0.5^53 + 0.5^105
  mov.d $f2, $f0            # f2 = f0
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f4, one            # f2 = 1
  jal   addDouble           # function call 1 +(0.5^53 + 0.5^105)
  mov.d $f2, $f0            # f2 = f0
  ldc1  $f0, zero           # f0 = 0.0
  ldc1  $f4, one            # f2 = 1
  jal   subDouble           # function call: (1 +(0.5^53 + 0.5^105)) - 1
  jal   printDouble         #function call
  jal   printNewline        # function call
end_main:
  li    $v0, 10             # exit
  syscall
  .end main

printNewline:
  addi  $sp, $sp, -4        # "push" opearation into register
  sw    $a0, 0($sp)         # save a0

  li    $v0, 4              # print newline
  la    $a0, newline        # save newline into v1
  syscall
printNewline_exit:
  lw    $a0, 0($sp)         #  restore the $ra into register
  addi  $sp, $sp, 4         #  "pop" operateration
  jr    $ra                 #  return

printString:
  li    $v0, 4              # print_string
  syscall
printString_exit:
  jr    $ra                 #  return

printDouble:
  li    $v0, 3              # print double value
  mov.d $f12, $f0
  syscall
printDouble_exit:
  jr    $ra                 #  return

addDouble:
  add.d $f0, $f2, $f4       # f0 = f2 + f4
addDouble_exit:  
  jr    $ra                 #  return

subDouble:
  sub.d $f0, $f2, $f4       # f0 = f2 - f4
subDouble_exit:
  jr    $ra                 #  return

power:
  addi  $sp, $sp, -4        # "push" opearation into register
  sw    $t0, 0($sp)         # save t0
  addi  $sp, $sp, -4        # "push" opearation into register
  sw    $t1, 0($sp)         # save t1

  ldc1  $f4, one            # f4 = 1.0
  move  $t1, $zero          # index= 0

power_while:
  slt   $t0, $t1, $a2       # t0 = t1 < a0? 1 : 0
  bne   $t0, 1, power_done  # goto down if t0 != 1
  mul.d $f4, $f4, $f2       # f4 *= f2
  addiu $t1, $t1, 1         # index++
  j     power_while
power_done:
  mov.d $f0, $f4            # f0 = f4

power_exit:
  ldc1  $f4, zero           # f4 = 0.0
  lw    $t1, 0($sp)         #  restore the $ra into register
  addi  $sp, $sp, 4         #  "pop" operateration
  addi  $sp, $sp, -4        # "push" opearation into register
  sw    $t0, 0($sp)         # save a0
  jr    $ra                 #  return
