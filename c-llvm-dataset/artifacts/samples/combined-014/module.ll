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
  %9 = load i32, ptr %i, align 4
  %xor = xor i32 %8, %9
  %xor2 = xor i32 %7, %xor
  store i32 %xor2, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %11, 29
  %shl3 = shl i32 %shl, 5
  %xor4 = xor i32 %10, %shl3
  store i32 %xor4, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %13 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %12, %13
  %14 = load i32, ptr %i, align 4
  %xor6 = xor i32 %xor5, %14
  %and7 = and i32 %xor6, 524288
  %cmp8 = icmp eq i32 %and7, 0
  br i1 %cmp8, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %xor9 = xor i32 %16, %17
  %mul10 = mul i32 7, %xor9
  %xor11 = xor i32 %15, %mul10
  store i32 %xor11, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %y.addr, align 4
  %shl12 = shl i32 %19, 14
  %20 = load i32, ptr %x.addr, align 4
  %mul13 = mul i32 %20, 31
  %or = or i32 %shl12, %mul13
  %21 = load i32, ptr %x.addr, align 4
  %22 = load i32, ptr %acc, align 4
  %or14 = or i32 2, %22
  %xor15 = xor i32 %21, %or14
  %xor16 = xor i32 %or, %xor15
  %xor17 = xor i32 %18, %xor16
  store i32 %xor17, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %sub = sub i32 %24, 2
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %i, align 4
  %sub18 = sub i32 %25, %26
  %and19 = and i32 %sub, %sub18
  %27 = load i32, ptr %x.addr, align 4
  %add20 = add i32 %and19, %27
  %xor21 = xor i32 %23, %add20
  store i32 %xor21, ptr %acc, align 4
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
  %xor22 = xor i32 %29, %30
  %and23 = and i32 %xor22, 8
  %cmp24 = icmp eq i32 %and23, 0
  br i1 %cmp24, label %if.then25, label %if.else31

if.then25:                                        ; preds = %for.end
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %x.addr, align 4
  %mul26 = mul i32 %32, 31
  %mul27 = mul i32 2, %mul26
  %xor28 = xor i32 %31, %mul27
  store i32 %xor28, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %y.addr, align 4
  %xor29 = xor i32 %34, %35
  %xor30 = xor i32 %33, %xor29
  store i32 %xor30, ptr %acc, align 4
  br label %if.end34

if.else31:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %acc, align 4
  %mul32 = mul i32 %37, 16
  %xor33 = xor i32 %36, %mul32
  store i32 %xor33, ptr %acc, align 4
  br label %if.end34

if.end34:                                         ; preds = %if.else31, %if.then25
  %38 = load i32, ptr %acc, align 4
  ret i32 %38
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
