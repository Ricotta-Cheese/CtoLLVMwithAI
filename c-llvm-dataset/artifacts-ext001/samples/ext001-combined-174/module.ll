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
  %8 = load i32, ptr %y.addr, align 4
  %9 = load i32, ptr %y.addr, align 4
  %mul2 = mul i32 %9, 3
  %or = or i32 %8, %mul2
  %xor = xor i32 %7, %or
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %i, align 4
  %and3 = and i32 %11, 1
  %add4 = add i32 -1, %and3
  %xor5 = xor i32 %10, %add4
  store i32 %xor5, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %i, align 4
  %xor6 = xor i32 %12, %13
  store i32 %xor6, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor7 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor8 = xor i32 %xor7, %16
  %and9 = and i32 %xor8, 8388608
  %cmp10 = icmp eq i32 %and9, 0
  br i1 %cmp10, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %i, align 4
  %19 = load i32, ptr %i, align 4
  %shr = lshr i32 %19, 2
  %and11 = and i32 %18, %shr
  %xor12 = xor i32 %17, %and11
  store i32 %xor12, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %i, align 4
  %or13 = or i32 %21, 15
  %22 = load i32, ptr %x.addr, align 4
  %or14 = or i32 %22, 16
  %or15 = or i32 %or13, %or14
  %xor16 = xor i32 %20, %or15
  store i32 %xor16, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %23 = load i32, ptr %i, align 4
  %inc = add i32 %23, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %24 = load i32, ptr %x.addr, align 4
  %25 = load i32, ptr %y.addr, align 4
  %xor17 = xor i32 %24, %25
  %and18 = and i32 %xor17, 268435456
  %cmp19 = icmp eq i32 %and18, 0
  br i1 %cmp19, label %if.then20, label %if.else25

if.then20:                                        ; preds = %for.end
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %y.addr, align 4
  %28 = load i32, ptr %acc, align 4
  %add21 = add i32 %27, %28
  %xor22 = xor i32 %26, %add21
  store i32 %xor22, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %y.addr, align 4
  %31 = load i32, ptr %x.addr, align 4
  %and23 = and i32 %30, %31
  %xor24 = xor i32 %29, %and23
  store i32 %xor24, ptr %acc, align 4
  br label %if.end28

if.else25:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %x.addr, align 4
  %and26 = and i32 %33, %34
  %shl = shl i32 %and26, 26
  %xor27 = xor i32 %32, %shl
  store i32 %xor27, ptr %acc, align 4
  br label %if.end28

if.end28:                                         ; preds = %if.else25, %if.then20
  %35 = load i32, ptr %acc, align 4
  ret i32 %35
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
