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
  %add = add i32 %2, %3
  store i32 %add, ptr %acc, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, ptr %i, align 4
  %5 = load i32, ptr %x.addr, align 4
  %and = and i32 %5, 15
  %6 = load i32, ptr %y.addr, align 4
  %and1 = and i32 %6, 1
  %add2 = add i32 %and, %and1
  %cmp = icmp ult i32 %4, %add2
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %7 = load i32, ptr %acc, align 4
  %8 = load i32, ptr %x.addr, align 4
  %9 = load i32, ptr %y.addr, align 4
  %sub = sub i32 %8, %9
  %shr = lshr i32 %sub, 29
  %xor = xor i32 %7, %shr
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %mul = mul i32 %11, 3
  %12 = load i32, ptr %i, align 4
  %or = or i32 -1, %12
  %xor3 = xor i32 %mul, %or
  %13 = load i32, ptr %y.addr, align 4
  %and4 = and i32 7, %13
  %14 = load i32, ptr %x.addr, align 4
  %and5 = and i32 1053758749, %14
  %mul6 = mul i32 %and4, %and5
  %and7 = and i32 %xor3, %mul6
  %xor8 = xor i32 %10, %and7
  store i32 %xor8, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %i, align 4
  %mul9 = mul i32 %16, -1715158469
  %xor10 = xor i32 %15, %mul9
  store i32 %xor10, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %xor11 = xor i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor12 = xor i32 %xor11, %19
  %and13 = and i32 %xor12, 2097152
  %cmp14 = icmp eq i32 %and13, 0
  br i1 %cmp14, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %y.addr, align 4
  %22 = load i32, ptr %y.addr, align 4
  %23 = load i32, ptr %acc, align 4
  %sub15 = sub i32 %22, %23
  %24 = load i32, ptr %i, align 4
  %sub16 = sub i32 16, %24
  %xor17 = xor i32 %sub15, %sub16
  %xor18 = xor i32 %21, %xor17
  %xor19 = xor i32 %20, %xor18
  store i32 %xor19, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %y.addr, align 4
  %xor20 = xor i32 %25, %26
  store i32 %xor20, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %shr21 = lshr i32 %28, 0
  %29 = load i32, ptr %y.addr, align 4
  %add22 = add i32 %shr21, %29
  %30 = load i32, ptr %i, align 4
  %shr23 = lshr i32 %30, 13
  %shr24 = lshr i32 %shr23, 10
  %add25 = add i32 %add22, %shr24
  %xor26 = xor i32 %27, %add25
  store i32 %xor26, ptr %acc, align 4
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %y.addr, align 4
  %add27 = add i32 %32, %33
  %xor28 = xor i32 %31, %add27
  store i32 %xor28, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %34 = load i32, ptr %i, align 4
  %inc = add i32 %34, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %35 = load i32, ptr %x.addr, align 4
  %36 = load i32, ptr %y.addr, align 4
  %xor29 = xor i32 %35, %36
  %and30 = and i32 %xor29, 128
  %cmp31 = icmp eq i32 %and30, 0
  br i1 %cmp31, label %if.then32, label %if.else37

if.then32:                                        ; preds = %for.end
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %y.addr, align 4
  %and33 = and i32 %38, -1
  %39 = load i32, ptr %acc, align 4
  %mul34 = mul i32 %and33, %39
  %xor35 = xor i32 %37, %mul34
  store i32 %xor35, ptr %acc, align 4
  %40 = load i32, ptr %acc, align 4
  %xor36 = xor i32 %40, 0
  store i32 %xor36, ptr %acc, align 4
  br label %if.end39

if.else37:                                        ; preds = %for.end
  %41 = load i32, ptr %acc, align 4
  %42 = load i32, ptr %x.addr, align 4
  %xor38 = xor i32 %41, %42
  store i32 %xor38, ptr %acc, align 4
  br label %if.end39

if.end39:                                         ; preds = %if.else37, %if.then32
  %43 = load i32, ptr %acc, align 4
  ret i32 %43
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 27, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
