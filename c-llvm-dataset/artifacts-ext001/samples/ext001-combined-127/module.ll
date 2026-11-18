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
  %8 = load i32, ptr %i, align 4
  %9 = load i32, ptr %x.addr, align 4
  %sub = sub i32 %8, %9
  %xor = xor i32 %7, %sub
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %11 = load i32, ptr %y.addr, align 4
  %xor2 = xor i32 %10, %11
  %12 = load i32, ptr %i, align 4
  %xor3 = xor i32 %xor2, %12
  %and4 = and i32 %xor3, -2147483648
  %cmp5 = icmp eq i32 %and4, 0
  br i1 %cmp5, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %shr = lshr i32 %14, 30
  %15 = load i32, ptr %i, align 4
  %16 = load i32, ptr %acc, align 4
  %or = or i32 %15, %16
  %xor6 = xor i32 %shr, %or
  %17 = load i32, ptr %acc, align 4
  %shl = shl i32 %17, 19
  %shr7 = lshr i32 %shl, 14
  %xor8 = xor i32 %xor6, %shr7
  %xor9 = xor i32 %13, %xor8
  store i32 %xor9, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %xor10 = xor i32 %18, 31
  store i32 %xor10, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %19 = load i32, ptr %i, align 4
  %inc = add i32 %19, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %20 = load i32, ptr %x.addr, align 4
  %21 = load i32, ptr %y.addr, align 4
  %xor11 = xor i32 %20, %21
  %and12 = and i32 %xor11, 8388608
  %cmp13 = icmp eq i32 %and12, 0
  br i1 %cmp13, label %if.then14, label %if.else19

if.then14:                                        ; preds = %for.end
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %x.addr, align 4
  %shl15 = shl i32 %23, 30
  %24 = load i32, ptr %x.addr, align 4
  %25 = load i32, ptr %y.addr, align 4
  %xor16 = xor i32 %24, %25
  %add17 = add i32 %shl15, %xor16
  %xor18 = xor i32 %22, %add17
  store i32 %xor18, ptr %acc, align 4
  br label %if.end22

if.else19:                                        ; preds = %for.end
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %y.addr, align 4
  %or20 = or i32 0, %27
  %xor21 = xor i32 %26, %or20
  store i32 %xor21, ptr %acc, align 4
  br label %if.end22

if.end22:                                         ; preds = %if.else19, %if.then14
  %28 = load i32, ptr %acc, align 4
  ret i32 %28
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
