; 'Kiloseconds' in Assembler.
; By d.e.e.p. aka hidefromkgb.

; Compile with YASM.
; This is the compilation script:

; #!/bin/bash
; rm ks
; if yasm -f elf -m amd64 -o ks.obj ks.asm; then echo "Assembled successfully!"; else read; fi;
; if ld -strip-all -o ks ks.obj; then echo "Linked successfully!"; else read; fi;
; rm ks.obj

; If you have a 32-bit machine then change '-m amd64' to '-m x86'.


; Main code:
  MOV ECX, msg;          <-- Pointer to the "intro" string
  MOV EDX, num-msg;      <-- Its length
  MOV EAX, 4;            <-- SYS_WRITE
  INT 80h;

  XOR EBX, EBX;
  MOV EAX, 13;           <-- SYS_TIME
  INT 80h;               <-- EAX = kernel time in seconds

  CDQ;
  MOV ECX, 1000;
  DIV ECX;               <-- EAX = <kiloseconds>
  LEA ESP, [EDX+ECX];    <-- ESP = <remainder>+1000

  ; <-- This loop is executed twice:
  ; <-- First time, it outputs <kiloseconds><.>
  ; <-- Then, <#7><remainder><CR>
  ; <-- Nonprintable <#7> aims to mask leading zeros
  @loop:
    MOV EBP, dot-num;
    MOV ECX, end-num;
    TEST ESP, ESP;       <-- ESP = 0? Then EAX = <remainder>
    CMOVE EBP, ECX;      <-- Setting last char: <.> or <CR>
    MOV ECX, 1999999Ah;  <-- ECX := (2^32-1 + 10) div 10
    @conv:
      SHL EBP, 4;        <-- Reserve space for next index N
      MOV EBX, EAX;
      MUL ECX;           <-- EDX := EAX div 10
      MOV EAX, EDX;
      NEG EBX;
      LEA EDX, [EDX*4+EDX];
      LEA EBX, [EBX+EDX*2];
      SUB EBP, EBX;      <-- EBX = -(N mod 10) = (N div 10)*10-N
    TEST EAX, EAX;       <-- Last index? (max. 7, i.e. 10-3)
    JG @conv;

    XOR EBX, EBX;        <-- Output to %STDOUT%
    MOV EDX, 1;          <-- All following strings have length 1

    TEST ESP, ESP;
    JNE @type;
      AND EBP, 0FFFF0h;  <-- Masking potential leading zeros in
      ADD EBP, nul-num;  <-- <remainder> with nonprintable <#7>
    @type:
      MOV ECX, EBP;
      AND ECX, 0Fh;      <-- Getting the current index
      ADD ECX, num;      <-- Computing the corresponding address
      MOV EAX, 4;        <-- SYS_WRITE
      INT 80h;
      SHR EBP, 4;        <-- Moving to the next index
    JNE @type;           <-- Repeat until no indexes are left

    MOV EAX, ESP;        <-- Move on to the next step
    XOR ESP, ESP;        <-- Set the second-step marker
    TEST EAX, EAX;       <-- Has the marker already been set?
  JNE @loop;

  XOR EBX, EBX;          <-- Exit code (0 here)
  MOV EAX, 1;            <-- SYS_EXIT
  INT 80h;

  msg: DB "kS since 01.01.70: "
  num: DB "0123456789";
  dot: DB ".";
  end: DB 10;
  nul: DB 7;
