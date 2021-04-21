.text
START:
# 初始化数据
addi $t1, $0, 0     # t1: x坐标
addi $t2, $0, 0     # t2: y坐标
addi $t3, $0, 0     # t3: 玩家
addi $t4, $0, 0     # t4: 连珠数
addi $t5, $0, 0     # t5: 8848
# 绘制棋盘
addi $a0, $0, 1
sll $a0, $a0, 24
addi $v0, $0, 34
syscall
#addi $v0, $0, 1
#syscall

PLAYING:
addi $v0, $0, 1

#syscall

beq $t5, 8848, EXIT
j PLAYING

EXIT:
addi $v0, $0, 1
syscall

Interrupt_left:
# 恢复原状
sll $s1, $t2, 8
add $s1, $s1, $t1
sll $s2, $t2, 4
add $s2, $s2, $t1
lw $s3, ($s2)
sll $s3, $s3, 16
addi, $a0, $0, 2
sll $a0, $a0, 24
add $a0, $a0, $s3
add $a0, $a0, $s1
addi $v0, $0, 34
syscall
#addi $v0, $0, 1
#syscall
# 绘制光标
beq $t1, 0,LEFT2
sub $t1, $t1, 1
LEFT_ERET:
sll $s1, $t2, 8
add $s1, $t1, $s1
addi $s2, $t3, 3
sll $s2, $s2, 16
add $s1, $s1, $s2
addi, $a0, $0, 2
sll $a0, $a0, 24
add $a0, $a0, $s1
addi $v0, $0, 34
syscall
#addi $v0, $0, 1
#syscall
eret
LEFT2:
addi $t1, $0, 12
j LEFT_ERET

Interrupt_right:
# 恢复原状
sll $s1, $t2, 8
add $s1, $s1, $t1
sll $s2, $t2, 4
add $s2, $s2, $t1
lw $s3, ($s2)
sll $s3, $s3, 16
addi, $a0, $0, 2
sll $a0, $a0, 24
add $a0, $a0, $s3
add $a0, $a0, $s1
addi $v0, $0, 34
syscall
#addi $v0, $0, 1
#syscall
# 绘制光标
beq $t1, 12, RIGHT2
addi $t1, $t1, 1
RIGHT_ERET:
sll $s2, $t2, 8

#add $s2, $t1, $s1
add $s2, $t1, $s2

addi $s1, $t3, 3
sll $s1, $s1, 16
add $s1, $s1, $s2
addi, $a0, $0, 2
sll $a0, $a0, 24
add $a0, $a0, $s1
addi $v0, $0, 34
syscall
#addi $v0, $0, 1
#syscall
eret
RIGHT2:
addi $t1, $0, 0
j RIGHT_ERET

Interrupt_up:
# 恢复原状
sll $s1, $t2, 8
add $s1, $s1, $t1
sll $s2, $t2, 4
add $s2, $s2, $t1
lw $s3, ($s2)
sll $s3, $s3, 16
addi, $a0, $0, 2
sll $a0, $a0, 24
add $a0, $a0, $s3
add $a0, $a0, $s1
addi $v0, $0, 34
syscall
#addi $v0, $0, 1
#syscall
# 绘制光标
beq $t2, 0, UP2
sub $t2, $t2, 1
UP_ERET:
sll $s2, $t2, 8

#add $s2, $t1, $s1
add $s2, $t1, $s2

addi $s1, $t3, 3
sll $s1, $s1, 16
add $s1, $s1, $s2
addi, $a0, $0, 2
sll $a0, $a0, 24
add $a0, $a0, $s1
addi $v0, $0, 34
syscall
#addi $v0, $0, 1
#syscall
eret
UP2:
addi $t2, $0, 12
j UP_ERET

Interrupt_down:
# 恢复原状
sll $s1, $t2, 8
add $s1, $s1, $t1
sll $s2, $t2, 4
add $s2, $s2, $t1
lw $s3, ($s2)
sll $s3, $s3, 16
addi, $a0, $0, 2
sll $a0, $a0, 24
add $a0, $a0, $s3
add $a0, $a0, $s1
addi $v0, $0, 34
syscall
#addi $v0, $0, 1
#syscall
# 绘制光标
beq $t2, 12, DOWN2
addi $t2, $t2, 1
DOWN_ERET:
sll $s2, $t2, 8
add $s2, $t1, $s2#add $s2, $t1, $s1
addi $s1, $t3, 3
sll $s1, $s1, 16
add $s1, $s1, $s2
addi, $a0, $0, 2
sll $a0, $a0, 24
add $a0, $a0, $s1
addi $v0, $0, 34
syscall
#addi $v0, $0, 1
#syscall
eret
DOWN2:
addi $t2, $0, 0
j DOWN_ERET

Interrupt_confirm:
# 计算地址
sll $s1, $t2, 4
add $s1, $s1, $t1
# 判断是否有子
lw  $s2, ($s1)
bne $s2, 0, Confirm_exit
# 落子
addi $s3, $t3, 1
sw $s3, ($s1)
sll $s1, $t2, 8
add $s1, $s1, $t1
sll $s4, $s3, 16
add $s4, $s4, $s1
addi $a0, $0, 3
sll $a0, $a0, 24
add $a0, $s4, $a0
addi $v0, $0, 34
syscall
xor $t3, $t3, 1
#addi $v0, $0, 1
#syscall
# 判断是否胜利
# 是否出现横线
judge_1:
addi $t4, $0, 0
sll $s1, $t2, 4
addi $s5, $t2, 13
turn1:
lw $s2, ($s1)
beq $s2, $s3, link1
addi $t4, $0, 0
rl1:
addi $s1, $s1, 1
beq $s1, $s5, turn1
j judge_2
link1:
addi $t4, $t4, 1
beq $t4, 5, AWIN
j rl1


# 是否出现竖线
judge_2:
addi $t4, $0, 0
addi $s1, $t1, 0
addi $s5, $0, 13
sll $s5, $s5, 4
add $s5, $s5, $t1
turn2:
lw $s2, ($s1)
beq $s2, $s3, link2
addi $t4, $t4, 0
rl2:
addi $s1, $s1, 0x10
beq $s1, $s5, turn2
j Confirm_exit
link2:
addi $t4, $t4, 1
beq $t4, 5, AWIN
j rl2

# 是否出现斜上到斜下
judge_3:
addi $t4, $0, 0


#是否出现斜下到斜上
judge_4:



Confirm_exit:
eret

AWIN:
addi $a0, $0, 0x5000000
addi $v0, $0, 34
syscall
addi $v0, $0, 1
syscall
addi $t5, $0, 8848
j Confirm_exit






