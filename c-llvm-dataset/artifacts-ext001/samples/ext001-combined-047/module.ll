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
  %8 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %8, 26
  %shl2 = shl i32 %shl, 10
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %i, align 4
  %11 = load i32, ptr %x.addr, align 4
  %sub = sub i32 %10, %11
  %xor = xor i32 %9, %sub
  %xor3 = xor i32 %shl2, %xor
  %xor4 = xor i32 %7, %xor3
  store i32 %xor4, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %i, align 4
  %14 = load i32, ptr %x.addr, align 4
  %and5 = and i32 %13, %14
  %xor6 = xor i32 %12, %and5
  store i32 %xor6, ptr %acc, align 4
  %15 = load i32, ptr %x.addr, align 4
  %16 = load i32, ptr %y.addr, align 4
  %xor7 = xor i32 %15, %16
  %17 = load i32, ptr %i, align 4
  %xor8 = xor i32 %xor7, %17
  %and9 = and i32 %xor8, 1073741824
  %cmp10 = icmp eq i32 %and9, 0
  br i1 %cmp10, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %y.addr, align 4
  %sub11 = sub i32 %19, -306163621
  %xor12 = xor i32 %18, %sub11
  store i32 %xor12, ptr %acc, align 4
  %20 = load i32, ptr %acc, align 4
  %xor13 = xor i32 %20, 0
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %21 = load i32, ptr %acc, align 4
  %xor14 = xor i32 %21, 0
  store i32 %xor14, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %i, align 4
  %24 = load i32, ptr %i, align 4
  %add15 = add i32 %23, %24
  %xor16 = xor i32 3, %add15
  %xor17 = xor i32 %22, %xor16
  store i32 %xor17, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %25 = load i32, ptr %i, align 4
  %inc = add i32 %25, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %26 = load i32, ptr %x.addr, align 4
  %27 = load i32, ptr %y.addr, align 4
  %xor18 = xor i32 %26, %27
  %and19 = and i32 %xor18, 1
  %cmp20 = icmp eq i32 %and19, 0
  br i1 %cmp20, label %if.then21, label %if.else24

if.then21:                                        ; preds = %for.end
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %x.addr, align 4
  %sub22 = sub i32 %29, 2
  %xor23 = xor i32 %28, %sub22
  store i32 %xor23, ptr %acc, align 4
  br label %if.end31

if.else24:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %y.addr, align 4
  %sub25 = sub i32 -1, %31
  %32 = load i32, ptr %y.addr, align 4
  %33 = load i32, ptr %acc, align 4
  %sub26 = sub i32 %32, %33
  %xor27 = xor i32 %sub25, %sub26
  %and28 = and i32 0, %xor27
  %xor29 = xor i32 %30, %and28
  store i32 %xor29, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %y.addr, align 4
  %xor30 = xor i32 %34, %35
  store i32 %xor30, ptr %acc, align 4
  br label %if.end31

if.end31:                                         ; preds = %if.else24, %if.then21
  %36 = load i32, ptr %acc, align 4
  ret i32 %36
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
