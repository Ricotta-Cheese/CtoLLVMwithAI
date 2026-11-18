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
  %8 = load i32, ptr %acc, align 4
  %shr = lshr i32 %8, 31
  %9 = load i32, ptr %acc, align 4
  %xor = xor i32 3, %9
  %or = or i32 %shr, %xor
  %xor2 = xor i32 %7, %or
  store i32 %xor2, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %shl = shl i32 %11, 14
  %shr3 = lshr i32 %shl, 6
  %xor4 = xor i32 %10, %shr3
  store i32 %xor4, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %xor5 = xor i32 %12, %13
  store i32 %xor5, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %16
  %and8 = and i32 %xor7, 8388608
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %acc, align 4
  %mul = mul i32 %18, %19
  %20 = load i32, ptr %y.addr, align 4
  %21 = load i32, ptr %acc, align 4
  %and10 = and i32 %20, %21
  %xor11 = xor i32 %mul, %and10
  %22 = load i32, ptr %i, align 4
  %23 = load i32, ptr %x.addr, align 4
  %xor12 = xor i32 %22, %23
  %and13 = and i32 0, %xor12
  %sub14 = sub i32 %xor11, %and13
  %xor15 = xor i32 %17, %sub14
  store i32 %xor15, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %y.addr, align 4
  %26 = load i32, ptr %x.addr, align 4
  %shr16 = lshr i32 %26, 2
  %add17 = add i32 %25, %shr16
  %27 = load i32, ptr %y.addr, align 4
  %shr18 = lshr i32 %27, 0
  %xor19 = xor i32 %shr18, 32505856
  %and20 = and i32 %add17, %xor19
  %xor21 = xor i32 %24, %and20
  store i32 %xor21, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %y.addr, align 4
  %30 = load i32, ptr %acc, align 4
  %add22 = add i32 %29, %30
  %mul23 = mul i32 939524096, %add22
  %31 = load i32, ptr %i, align 4
  %sub24 = sub i32 %31, -1
  %32 = load i32, ptr %i, align 4
  %33 = load i32, ptr %x.addr, align 4
  %mul25 = mul i32 %32, %33
  %and26 = and i32 %sub24, %mul25
  %or27 = or i32 %mul23, %and26
  %xor28 = xor i32 %28, %or27
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
  %and30 = and i32 %xor29, 536870912
  %cmp31 = icmp eq i32 %and30, 0
  br i1 %cmp31, label %if.then32, label %if.else37

if.then32:                                        ; preds = %for.end
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %acc, align 4
  %xor33 = xor i32 %38, %39
  %shl34 = shl i32 %xor33, 12
  %shl35 = shl i32 %shl34, 3
  %xor36 = xor i32 %37, %shl35
  store i32 %xor36, ptr %acc, align 4
  br label %if.end40

if.else37:                                        ; preds = %for.end
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %acc, align 4
  %shr38 = lshr i32 %41, 4
  %xor39 = xor i32 %40, %shr38
  store i32 %xor39, ptr %acc, align 4
  br label %if.end40

if.end40:                                         ; preds = %if.else37, %if.then32
  %42 = load i32, ptr %acc, align 4
  ret i32 %42
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
