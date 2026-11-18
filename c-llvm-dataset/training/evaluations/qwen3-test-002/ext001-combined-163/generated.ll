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
  %9 = load i32, ptr %x.addr, align 4
  %add3 = add i32 %8, %9
  %10 = load i32, ptr %i, align 4
  %shr = lshr i32 %10, 19
  %add4 = add i32 %add3, %shr
  %11 = load i32, ptr %acc, align 4
  %add5 = add i32 %11, -1
  %12 = load i32, ptr %i, align 4
  %sub = sub i32 31, %12
  %or = or i32 %add5, %sub
  %xor = xor i32 %add4, %or
  %xor6 = xor i32 %7, %xor
  store i32 %xor6, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %y.addr, align 4
  %15 = load i32, ptr %i, align 4
  %sub7 = sub i32 %14, %15
  %16 = load i32, ptr %x.addr, align 4
  %sub8 = sub i32 %sub7, %16
  %17 = load i32, ptr %acc, align 4
  %shl = shl i32 %17, 27
  %18 = load i32, ptr %y.addr, align 4
  %19 = load i32, ptr %i, align 4
  %mul = mul i32 %18, %19
  %xor9 = xor i32 %shl, %mul
  %or10 = or i32 %sub8, %xor9
  %xor11 = xor i32 %13, %or10
  store i32 %xor11, ptr %acc, align 4
  %20 = load i32, ptr %x.addr, align 4
  %21 = load i32, ptr %y.addr, align 4
  %xor12 = xor i32 %20, %21
  %22 = load i32, ptr %i, align 4
  %xor13 = xor i32 %xor12, %22
  %and14 = and i32 %xor13, 8388608
  %cmp15 = icmp eq i32 %and14, 0
  br i1 %cmp15, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %shr16 = lshr i32 %24, 10
  %shr17 = lshr i32 %shr16, 19
  %shr18 = lshr i32 %shr17, 29
  %xor19 = xor i32 %23, %shr18
  store i32 %xor19, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %shr20 = lshr i32 %26, 10
  %shr21 = lshr i32 %shr20, 19
  %shr22 = lshr i32 %shr21, 29
  %xor23 = xor i32 %25, %shr22
  store i32 %xor23, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %x.addr, align 4
  %xor24 = xor i32 %27, %28
  store i32 %xor24, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %x.addr, align 4
  %xor25 = xor i32 2, %30
  %shr26 = lshr i32 %xor25, 22
  %shr27 = lshr i32 %shr26, 6
  %xor28 = xor i32 %29, %shr27
  store i32 %xor28, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %31 = load i32, ptr %i, align 4
  %inc = add i32 %31, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %32 = load i32, ptr %x.addr, align 4
  %33 = load i32, ptr %y.addr, align 4
  %xor29 = xor i32 %32, %33
  %and30 = and i32 %xor29, 262144
  %cmp31 = icmp eq i32 %and30, 0
  br i1 %cmp31, label %if.then32, label %if.else34

if.then32:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %y.addr, align 4
  %xor33 = xor i32 2, %35
  %shl34 = shl i32 %xor33, 7
  %xor35 = xor i32 %34, %shl34
  store i32 %xor35, ptr %acc, align 4
  br label %if.end36

if.else34:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %xor37 = xor i32 %36, 1073741824
  store i32 %xor37, ptr %acc, align 4
  br label %if.end36

if.end36:                                         ; preds = %if.else34, %if.then32
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
