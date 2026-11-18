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
  %8 = load i32, ptr %y.addr, align 4
  %9 = load i32, ptr %i, align 4
  %mul = mul i32 %8, %9
  %xor = xor i32 %7, %mul
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %xor2 = xor i32 %10, %11
  store i32 %xor2, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %13 = load i32, ptr %y.addr, align 4
  %xor3 = xor i32 %12, %13
  %14 = load i32, ptr %i, align 4
  %xor4 = xor i32 %xor3, %14
  %and5 = and i32 %xor4, 33554432
  %cmp6 = icmp eq i32 %and5, 0
  br i1 %cmp6, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %i, align 4
  %or = or i32 -1, %16
  %shl = shl i32 %or, 30
  %17 = load i32, ptr %y.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %add7 = add i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %i, align 4
  %xor8 = xor i32 %19, %20
  %add9 = add i32 %add7, %xor8
  %xor10 = xor i32 %shl, %add9
  %xor11 = xor i32 %15, %xor10
  store i32 %xor11, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %i, align 4
  %shl12 = shl i32 %22, 23
  %shl13 = shl i32 %shl12, 5
  %23 = load i32, ptr %i, align 4
  %24 = load i32, ptr %acc, align 4
  %or14 = or i32 %23, %24
  %25 = load i32, ptr %x.addr, align 4
  %26 = load i32, ptr %y.addr, align 4
  %or15 = or i32 %25, %26
  %add16 = add i32 %or14, %or15
  %xor17 = xor i32 %shl13, %add16
  %xor18 = xor i32 %21, %xor17
  store i32 %xor18, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %and19 = and i32 %28, 15
  %29 = load i32, ptr %i, align 4
  %shl20 = shl i32 %29, 17
  %mul21 = mul i32 %and19, %shl20
  %xor22 = xor i32 %27, %mul21
  store i32 %xor22, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %30 = load i32, ptr %i, align 4
  %inc = add i32 %30, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %31 = load i32, ptr %x.addr, align 4
  %32 = load i32, ptr %y.addr, align 4
  %xor23 = xor i32 %31, %32
  %and24 = and i32 %xor23, 64
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else30

if.then26:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %x.addr, align 4
  %35 = load i32, ptr %y.addr, align 4
  %36 = load i32, ptr %acc, align 4
  %sub27 = sub i32 %35, %36
  %xor28 = xor i32 %34, %sub27
  %xor29 = xor i32 %33, %xor28
  store i32 %xor29, ptr %acc, align 4
  br label %if.end37

if.else30:                                        ; preds = %for.end
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %y.addr, align 4
  %39 = load i32, ptr %y.addr, align 4
  %mul31 = mul i32 16, %39
  %add32 = add i32 %38, %mul31
  %shr = lshr i32 %add32, 6
  %xor33 = xor i32 %37, %shr
  store i32 %xor33, ptr %acc, align 4
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %y.addr, align 4
  %42 = load i32, ptr %x.addr, align 4
  %xor34 = xor i32 %41, %42
  %xor35 = xor i32 1, %xor34
  %xor36 = xor i32 %40, %xor35
  store i32 %xor36, ptr %acc, align 4
  br label %if.end37

if.end37:                                         ; preds = %if.else30, %if.then26
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
