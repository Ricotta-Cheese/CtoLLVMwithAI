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
  %and2 = and i32 16, %8
  %9 = load i32, ptr %y.addr, align 4
  %mul = mul i32 %and2, %9
  %10 = load i32, ptr %i, align 4
  %11 = load i32, ptr %acc, align 4
  %and3 = and i32 %10, %11
  %12 = load i32, ptr %x.addr, align 4
  %13 = load i32, ptr %acc, align 4
  %add4 = add i32 %12, %13
  %xor = xor i32 %and3, %add4
  %add5 = add i32 %mul, %xor
  %xor6 = xor i32 %7, %add5
  store i32 %xor6, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %i, align 4
  %xor7 = xor i32 %14, %15
  store i32 %xor7, ptr %acc, align 4
  %16 = load i32, ptr %acc, align 4
  %17 = load i32, ptr %y.addr, align 4
  %18 = load i32, ptr %acc, align 4
  %mul8 = mul i32 %17, %18
  %xor9 = xor i32 %16, %mul8
  store i32 %xor9, ptr %acc, align 4
  %19 = load i32, ptr %x.addr, align 4
  %20 = load i32, ptr %y.addr, align 4
  %xor10 = xor i32 %19, %20
  %21 = load i32, ptr %i, align 4
  %xor11 = xor i32 %xor10, %21
  %and12 = and i32 %xor11, 2
  %cmp13 = icmp eq i32 %and12, 0
  br i1 %cmp13, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %x.addr, align 4
  %24 = load i32, ptr %y.addr, align 4
  %or = or i32 %23, %24
  %xor14 = xor i32 %22, %or
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %x.addr, align 4
  %27 = load i32, ptr %i, align 4
  %add15 = add i32 %26, %27
  %xor16 = xor i32 %25, %add15
  store i32 %xor16, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %sub17 = sub i32 1, %29
  %shl = shl i32 %sub17, 8
  %shl18 = shl i32 %shl, 19
  %xor19 = xor i32 %28, %shl18
  store i32 %xor19, ptr %acc, align 4
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
  %xor20 = xor i32 %31, %32
  %and21 = and i32 %xor20, 8
  %cmp22 = icmp eq i32 %and21, 0
  br i1 %cmp22, label %if.then23, label %if.else26

if.then23:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %y.addr, align 4
  %or24 = or i32 %34, %35
  %xor25 = xor i32 %33, %or24
  store i32 %xor25, ptr %acc, align 4
  br label %if.end29

if.else26:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %xor27 = xor i32 %37, %38
  %xor28 = xor i32 %36, %xor27
  store i32 %xor28, ptr %acc, align 4
  br label %if.end29

if.end29:                                         ; preds = %if.else26, %if.then23
  %39 = load i32, ptr %acc, align 4
  ret i32 %39
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
