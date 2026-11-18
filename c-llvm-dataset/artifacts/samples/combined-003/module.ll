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
  %8 = load i32, ptr %acc, align 4
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %11 = load i32, ptr %y.addr, align 4
  %mul = mul i32 %10, %11
  %shr = lshr i32 %mul, 18
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %sub = sub i32 %12, %13
  %14 = load i32, ptr %y.addr, align 4
  %15 = load i32, ptr %acc, align 4
  %mul3 = mul i32 %14, %15
  %add4 = add i32 %sub, %mul3
  %sub5 = sub i32 %shr, %add4
  %xor6 = xor i32 %9, %sub5
  store i32 %xor6, ptr %acc, align 4
  %16 = load i32, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %add7 = add i32 %17, %18
  %xor8 = xor i32 %16, %add7
  store i32 %xor8, ptr %acc, align 4
  %19 = load i32, ptr %x.addr, align 4
  %20 = load i32, ptr %y.addr, align 4
  %xor9 = xor i32 %19, %20
  %21 = load i32, ptr %i, align 4
  %xor10 = xor i32 %xor9, %21
  %and11 = and i32 %xor10, 16777216
  %cmp12 = icmp eq i32 %and11, 0
  br i1 %cmp12, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %x.addr, align 4
  %mul13 = mul i32 2, %23
  %24 = load i32, ptr %i, align 4
  %xor14 = xor i32 %24, 3
  %or = or i32 1, %xor14
  %sub15 = sub i32 %mul13, %or
  %xor16 = xor i32 %22, %sub15
  store i32 %xor16, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %y.addr, align 4
  %27 = load i32, ptr %acc, align 4
  %add17 = add i32 %26, %27
  %xor18 = xor i32 %25, %add17
  store i32 %xor18, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %x.addr, align 4
  %xor19 = xor i32 -1, %29
  %shl = shl i32 %xor19, 19
  %xor20 = xor i32 %28, %shl
  store i32 %xor20, ptr %acc, align 4
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
  %xor21 = xor i32 %31, %32
  %and22 = and i32 %xor21, 32768
  %cmp23 = icmp eq i32 %and22, 0
  br i1 %cmp23, label %if.then24, label %if.else28

if.then24:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %xor25 = xor i32 %33, 525539601
  store i32 %xor25, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %y.addr, align 4
  %36 = load i32, ptr %x.addr, align 4
  %add26 = add i32 %35, %36
  %xor27 = xor i32 %34, %add26
  store i32 %xor27, ptr %acc, align 4
  br label %if.end33

if.else28:                                        ; preds = %for.end
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %y.addr, align 4
  %39 = load i32, ptr %y.addr, align 4
  %mul29 = mul i32 %38, %39
  %xor30 = xor i32 %37, %mul29
  store i32 %xor30, ptr %acc, align 4
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %y.addr, align 4
  %42 = load i32, ptr %acc, align 4
  %add31 = add i32 %41, %42
  %xor32 = xor i32 %40, %add31
  store i32 %xor32, ptr %acc, align 4
  br label %if.end33

if.end33:                                         ; preds = %if.else28, %if.then24
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
