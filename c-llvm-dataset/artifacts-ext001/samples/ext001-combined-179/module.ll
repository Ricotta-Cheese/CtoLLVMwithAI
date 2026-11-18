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
  %8 = load i32, ptr %i, align 4
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %i, align 4
  %11 = load i32, ptr %i, align 4
  %xor2 = xor i32 %10, %11
  %sub3 = sub i32 %xor2, 19
  %12 = load i32, ptr %y.addr, align 4
  %mul = mul i32 16, %12
  %13 = load i32, ptr %i, align 4
  %xor4 = xor i32 %13, 3
  %mul5 = mul i32 %mul, %xor4
  %xor6 = xor i32 %sub3, %mul5
  %xor7 = xor i32 %9, %xor6
  store i32 %xor7, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor8 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor9 = xor i32 %xor8, %16
  %and10 = and i32 %xor9, 512
  %cmp11 = icmp eq i32 %and10, 0
  br i1 %cmp11, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %y.addr, align 4
  %19 = load i32, ptr %i, align 4
  %add12 = add i32 %18, %19
  %xor13 = xor i32 %17, %add12
  store i32 %xor13, ptr %acc, align 4
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %i, align 4
  %22 = load i32, ptr %x.addr, align 4
  %and14 = and i32 %21, %22
  %23 = load i32, ptr %acc, align 4
  %shr = lshr i32 %23, 23
  %and15 = and i32 %and14, %shr
  %xor16 = xor i32 %20, %and15
  store i32 %xor16, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %i, align 4
  %or = or i32 %25, 0
  %xor17 = xor i32 %24, %or
  store i32 %xor17, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %xor18 = xor i32 %26, 268435455
  store i32 %xor18, ptr %acc, align 4
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
  %xor19 = xor i32 %28, %29
  %and20 = and i32 %xor19, 131072
  %cmp21 = icmp eq i32 %and20, 0
  br i1 %cmp21, label %if.then22, label %if.else25

if.then22:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %x.addr, align 4
  %add23 = add i32 0, %31
  %shl = shl i32 %add23, 23
  %xor24 = xor i32 %30, %shl
  store i32 %xor24, ptr %acc, align 4
  br label %if.end35

if.else25:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %x.addr, align 4
  %34 = load i32, ptr %acc, align 4
  %or26 = or i32 %33, %34
  %35 = load i32, ptr %x.addr, align 4
  %or27 = or i32 %or26, %35
  %36 = load i32, ptr %y.addr, align 4
  %shl28 = shl i32 %36, 3
  %37 = load i32, ptr %x.addr, align 4
  %shr29 = lshr i32 %37, 10
  %and30 = and i32 %shl28, %shr29
  %xor31 = xor i32 %or27, %and30
  %xor32 = xor i32 %32, %xor31
  store i32 %xor32, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %y.addr, align 4
  %xor33 = xor i32 %39, 0
  %xor34 = xor i32 %38, %xor33
  store i32 %xor34, ptr %acc, align 4
  br label %if.end35

if.end35:                                         ; preds = %if.else25, %if.then22
  %40 = load i32, ptr %acc, align 4
  ret i32 %40
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
