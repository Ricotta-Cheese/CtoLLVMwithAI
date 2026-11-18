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
  %8 = load i32, ptr %x.addr, align 4
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %xor2 = xor i32 %9, %10
  store i32 %xor2, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %y.addr, align 4
  %13 = load i32, ptr %acc, align 4
  %shr = lshr i32 %13, 20
  %add3 = add i32 %12, %shr
  %14 = load i32, ptr %i, align 4
  %15 = load i32, ptr %acc, align 4
  %add4 = add i32 %14, %15
  %sub5 = sub i32 %add4, 3
  %or = or i32 %add3, %sub5
  %xor6 = xor i32 %11, %or
  store i32 %xor6, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %xor7 = xor i32 %16, %17
  %18 = load i32, ptr %i, align 4
  %xor8 = xor i32 %xor7, %18
  %and9 = and i32 %xor8, 65536
  %cmp10 = icmp eq i32 %and9, 0
  br i1 %cmp10, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %i, align 4
  %shr11 = lshr i32 %20, 26
  %xor12 = xor i32 %19, %shr11
  store i32 %xor12, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %xor13 = xor i32 %21, 15
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %x.addr, align 4
  %24 = load i32, ptr %acc, align 4
  %xor14 = xor i32 %23, %24
  %25 = load i32, ptr %acc, align 4
  %add15 = add i32 -1, %25
  %or16 = or i32 %xor14, %add15
  %26 = load i32, ptr %i, align 4
  %27 = load i32, ptr %x.addr, align 4
  %and17 = and i32 %26, %27
  %sub18 = sub i32 %and17, 9
  %and19 = and i32 %or16, %sub18
  %xor20 = xor i32 %22, %and19
  store i32 %xor20, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %28 = load i32, ptr %i, align 4
  %inc = add i32 %28, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %29 = load i32, ptr %x.addr, align 4
  %30 = load i32, ptr %y.addr, align 4
  %xor21 = xor i32 %29, %30
  %and22 = and i32 %xor21, 524288
  %cmp23 = icmp eq i32 %and22, 0
  br i1 %cmp23, label %if.then24, label %if.else30

if.then24:                                        ; preds = %for.end
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %x.addr, align 4
  %33 = load i32, ptr %y.addr, align 4
  %or25 = or i32 %32, %33
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %and26 = and i32 %34, %35
  %mul = mul i32 %or25, %and26
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %y.addr, align 4
  %or27 = or i32 %36, %37
  %shl = shl i32 %or27, 5
  %or28 = or i32 %mul, %shl
  %xor29 = xor i32 %31, %or28
  store i32 %xor29, ptr %acc, align 4
  br label %if.end35

if.else30:                                        ; preds = %for.end
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %acc, align 4
  %xor31 = xor i32 %39, 1
  %xor32 = xor i32 %38, %xor31
  store i32 %xor32, ptr %acc, align 4
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %y.addr, align 4
  %42 = load i32, ptr %y.addr, align 4
  %sub33 = sub i32 %41, %42
  %xor34 = xor i32 %40, %sub33
  store i32 %xor34, ptr %acc, align 4
  br label %if.end35

if.end35:                                         ; preds = %if.else30, %if.then24
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
