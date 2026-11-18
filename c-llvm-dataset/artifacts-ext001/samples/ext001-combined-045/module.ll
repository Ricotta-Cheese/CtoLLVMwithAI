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
  %xor = xor i32 %7, -2147483648
  store i32 %xor, ptr %acc, align 4
  %8 = load i32, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %mul = mul i32 0, %9
  %xor3 = xor i32 %8, %mul
  store i32 %xor3, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %xor4 = xor i32 %10, 7
  store i32 %xor4, ptr %acc, align 4
  %11 = load i32, ptr %x.addr, align 4
  %12 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %11, %12
  %13 = load i32, ptr %i, align 4
  %xor6 = xor i32 %xor5, %13
  %and7 = and i32 %xor6, 8388608
  %cmp8 = icmp eq i32 %and7, 0
  br i1 %cmp8, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %i, align 4
  %mul9 = mul i32 %15, 2
  %16 = load i32, ptr %y.addr, align 4
  %shr = lshr i32 %16, 27
  %xor10 = xor i32 %mul9, %shr
  %17 = load i32, ptr %y.addr, align 4
  %and11 = and i32 %xor10, %17
  %xor12 = xor i32 %14, %and11
  store i32 %xor12, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %19, 3
  %shl13 = shl i32 %shl, 6
  %20 = load i32, ptr %i, align 4
  %21 = load i32, ptr %acc, align 4
  %and14 = and i32 %20, %21
  %22 = load i32, ptr %x.addr, align 4
  %shl15 = shl i32 %22, 15
  %sub = sub i32 %and14, %shl15
  %and16 = and i32 %shl13, %sub
  %xor17 = xor i32 %18, %and16
  store i32 %xor17, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %sub18 = sub i32 %24, 3
  %and19 = and i32 %sub18, 31
  %xor20 = xor i32 %23, %and19
  store i32 %xor20, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %y.addr, align 4
  %xor21 = xor i32 %26, 3
  %xor22 = xor i32 %25, %xor21
  store i32 %xor22, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %27 = load i32, ptr %i, align 4
  %inc = add i32 %27, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %28 = load i32, ptr %x.addr, align 4
  %29 = load i32, ptr %y.addr, align 4
  %xor23 = xor i32 %28, %29
  %and24 = and i32 %xor23, 4
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else31

if.then26:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %y.addr, align 4
  %32 = load i32, ptr %y.addr, align 4
  %add27 = add i32 %31, %32
  %33 = load i32, ptr %acc, align 4
  %shl28 = shl i32 %33, 25
  %sub29 = sub i32 %add27, %shl28
  %xor30 = xor i32 %30, %sub29
  store i32 %xor30, ptr %acc, align 4
  br label %if.end36

if.else31:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %shr32 = lshr i32 %35, 31
  %sub33 = sub i32 %shr32, 16
  %36 = load i32, ptr %x.addr, align 4
  %mul34 = mul i32 %sub33, %36
  %xor35 = xor i32 %34, %mul34
  store i32 %xor35, ptr %acc, align 4
  br label %if.end36

if.end36:                                         ; preds = %if.else31, %if.then26
  %37 = load i32, ptr %acc, align 4
  ret i32 %37
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
