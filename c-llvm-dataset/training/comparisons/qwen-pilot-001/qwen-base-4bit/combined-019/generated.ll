// LLVM IR
define i32 @compute(i32 %x, i32 %y) {
  %acc = sub i32 %x, %y
  br i1 @.L1, label %L1, label %L2

  ; L1:
  br label %L1

  ; L2:
  %i = alloca i32
  store i32 0, i32* %i
  br label %L3

  ; L3:
  %i = load i32, i32* %i
  %i = add i32 %i, 1
  store i32 %i, i32* %i
  br label %L3

  ; L4:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  %acc = xor i32 %acc, i32 %x
  %acc = xor i32 %acc, i32 %x
  br label %L4

  ; L5:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L5

  ; L6:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L6

  ; L7:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L7

  ; L8:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L8

  ; L9:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L9

  ; L10:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L10

  ; L11:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L11

  ; L12:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L12

  ; L13:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L13

  ; L14:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L14

  ; L15:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L15

  ; L16:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L16

  ; L17:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L17

  ; L18:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L18

  ; L19:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L19

  ; L20:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L20

  ; L21:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L21

  ; L22:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L22

  ; L23:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L23

  ; L24:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L24

  ; L25:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L25

  ; L26:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L26

  ; L27:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L27

  ; L28:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L28

  ; L29:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L29

  ; L30:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L30

  ; L31:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L31

  ; L32:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L32

  ; L33:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L33

  ; L34:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L34

  ; L35:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L35

  ; L36:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L36

  ; L37:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L37

  ; L38:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L38

  ; L39:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L39

  ; L40:
  %i = load i32, i32* %i
  %acc = xor i32 %acc, i32 %i
  %acc = xor i32 %acc, i32 %x
  br label %L40

  ; L41:
  %