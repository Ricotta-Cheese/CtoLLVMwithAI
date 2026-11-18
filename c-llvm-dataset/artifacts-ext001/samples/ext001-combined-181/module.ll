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
  %9 = load i32, ptr %i, align 4
  %shl = shl i32 %9, 26
  %10 = load i32, ptr %y.addr, align 4
  %add3 = add i32 %shl, %10
  %add4 = add i32 %8, %add3
  %xor = xor i32 %7, %add4
  store i32 %xor, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %11, %12
  store i32 %xor5, ptr %acc, align 4
  %13 = load i32, ptr %x.addr, align 4
  %14 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %13, %14
  %15 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %15
  %and8 = and i32 %xor7, 8388608
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %16 = load i32, ptr %acc, align 4
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %xor10 = xor i32 %17, %18
  %19 = load i32, ptr %x.addr, align 4
  %xor11 = xor i32 3, %19
  %add12 = add i32 %xor10, %xor11
  %20 = load i32, ptr %i, align 4
  %21 = load i32, ptr %acc, align 4
  %add13 = add i32 %20, %21
  %22 = load i32, ptr %x.addr, align 4
  %add14 = add i32 %22, 7
  %or = or i32 %add13, %add14
  %xor15 = xor i32 %add12, %or
  %xor16 = xor i32 %16, %xor15
  store i32 %xor16, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %xor17 = xor i32 %23, %24
  store i32 %xor17, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %y.addr, align 4
  %shl18 = shl i32 %26, 7
  %xor19 = xor i32 %25, %shl18
  store i32 %xor19, ptr %acc, align 4
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
  %xor20 = xor i32 %28, %29
  %and21 = and i32 %xor20, 536870912
  %cmp22 = icmp eq i32 %and21, 0
  br i1 %cmp22, label %if.then23, label %if.else26

if.then23:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %y.addr, align 4
  %shl24 = shl i32 %31, 3
  %xor25 = xor i32 %30, %shl24
  store i32 %xor25, ptr %acc, align 4
  br label %if.end30

if.else26:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %y.addr, align 4
  %shl27 = shl i32 %33, 14
  %shl28 = shl i32 %shl27, 3
  %xor29 = xor i32 %32, %shl28
  store i32 %xor29, ptr %acc, align 4
  br label %if.end30

if.end30:                                         ; preds = %if.else26, %if.then23
  %34 = load i32, ptr %acc, align 4
  ret i32 %34
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
