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
  %mul = mul i32 %2, %3
  store i32 %mul, ptr %acc, align 4
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
  %xor = xor i32 %7, 31
  store i32 %xor, ptr %acc, align 4
  %8 = load i32, ptr %acc, align 4
  %9 = load i32, ptr %y.addr, align 4
  %10 = load i32, ptr %acc, align 4
  %sub = sub i32 %9, %10
  %11 = load i32, ptr %i, align 4
  %add2 = add i32 -1, %11
  %and3 = and i32 %sub, %add2
  %xor4 = xor i32 %8, %and3
  store i32 %xor4, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %13 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %12, %13
  %14 = load i32, ptr %i, align 4
  %xor6 = xor i32 %xor5, %14
  %and7 = and i32 %xor6, 131072
  %cmp8 = icmp eq i32 %and7, 0
  br i1 %cmp8, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %i, align 4
  %add9 = add i32 0, %16
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %i, align 4
  %mul10 = mul i32 %17, %18
  %or = or i32 %add9, %mul10
  %xor11 = xor i32 %or, 173742384
  %xor12 = xor i32 %15, %xor11
  store i32 %xor12, ptr %acc, align 4
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %i, align 4
  %xor13 = xor i32 %19, %20
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %x.addr, align 4
  %23 = load i32, ptr %acc, align 4
  %mul14 = mul i32 %22, %23
  %xor15 = xor i32 %21, %mul14
  store i32 %xor15, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %i, align 4
  %26 = load i32, ptr %acc, align 4
  %or16 = or i32 %25, %26
  %xor17 = xor i32 %or16, 7
  %27 = load i32, ptr %x.addr, align 4
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %mul18 = mul i32 %29, %30
  %or19 = or i32 %28, %mul18
  %mul20 = mul i32 %xor17, %or19
  %xor21 = xor i32 %24, %mul20
  store i32 %xor21, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %31 = load i32, ptr %i, align 4
  %inc = add i32 %31, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %32 = load i32, ptr %x.addr, align 4
  %33 = load i32, ptr %y.addr, align 4
  %xor22 = xor i32 %32, %33
  %and23 = and i32 %xor22, 16
  %cmp24 = icmp eq i32 %and23, 0
  br i1 %cmp24, label %if.then25, label %if.else30

if.then25:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %x.addr, align 4
  %add26 = add i32 %35, %36
  %37 = load i32, ptr %acc, align 4
  %shr = lshr i32 %37, 11
  %sub27 = sub i32 %add26, %shr
  %xor28 = xor i32 %34, %sub27
  store i32 %xor28, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %acc, align 4
  %add29 = add