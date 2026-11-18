; ModuleID = 'source.c'
source_filename = "source.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx27.2.0"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @compute(i32 noundef %x, i32 noundef %y) #0 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %acc = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  store i32 %y, ptr %y.addr, align 4
  %0 = load i32, ptr %x.addr, align 4
  %1 = load i32, ptr %y.addr, align 4
  %2 = load i32, ptr %x.addr, align 4
  %3 = load i32, ptr %y.addr, align 4
  %sub = sub i32 %2, %3
  store i32 %sub, ptr %acc, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, ptr %i, align 4
  %5 = load i32, ptr %x.addr, align 4
  %and = and i32 %5, 15
  %6 = load i32, ptr %y.addr, align 4
  %and1 = and i32 %6, 1
  %add = add i32 %and, %and1
  %cmp = icmp ult i32 %4, %add
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %7 = load i32, ptr %acc, align 4
  %8 = load i32, ptr %i, align 4
  %9 = load i32, ptr %i, align 4
  %sub2 = sub i32 %8, %9
  %xor = xor i32 %7, %sub2
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %x.addr, align 4
  %12 = load i32, ptr %x.addr, align 4
  %and3 = and i32 %11, %12
  %xor4 = xor i32 %10, %and3
  store i32 %xor4, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %x.addr, align 4
  %or = or i32 %14, %15
  %xor5 = xor i32 %13, %or
  store i32 %xor5, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %16, %17
  %18 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %18
  %and8 = and i32 %xor7, 2
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %x.addr, align 4
  %shr = lshr i32 %20, 1
  %xor10 = xor i32 %19, %shr
  store i32 %xor10, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %i, align 4
  %23 = load i32, ptr %acc, align 4
  %and11 = and i32 %22, %23
  %xor12 = xor i32 %21, %and11
  store i32 %xor12, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %24 = load i32, ptr %i, align 4
  %inc = add i32 %24, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %25 = load i32, ptr %x.addr, align 4
  %26 = load i32, ptr %y.addr, align 4
  %xor13 = xor i32 %25, %26
  %and14 = and i32 %xor13, 2
  %cmp15 = icmp eq i32 %and14, 0
  br i1 %cmp15, label %if.then16, label %if.else22

if.then16:                                        ; preds = %for.end
  %27 = load i32, ptr %acc, align 4
  %xor17 = xor i32 %27, 0
  store i32 %xor17, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %y.addr, align 4
  %add18 = add i32 %29, %30
  %add19 = add i32 %28, %add18
  %xor20 = xor i32 %28, %add19
  store i32 %xor20, ptr %acc, align 4
  br label %if.end28

if.else22:                                        ; preds = %for.end
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %acc, align 4
  %xor21 = xor i32 %32, 7
  %33 = load i32, ptr %y.addr, align 4
  %34 = load i32, ptr %x.addr, align 4
  %add23 = add i32 %33, %34
  %or24 = or i32 %xor21, %add23
  %35 = load i32, ptr %x.addr, align 4
  %36 = load i32, ptr %x.addr, align 4
  %and25 = and i32 %35, %36
  %37 = load i32, ptr %y.addr, align 4
  %xor26 = xor i32 %and25, %37
  %xor27 = xor i32 %or24, %xor26
  %xor28 = xor i32 %31, %xor27
  store i32 %xor28, ptr %acc, align 4
  br label %if.end28

if.end28:                                         ; preds = %if.else22,