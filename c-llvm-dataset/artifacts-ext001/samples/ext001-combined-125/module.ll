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
  %8 = load i32, ptr %i, align 4
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %xor3 = xor i32 %9, %10
  store i32 %xor3, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %i, align 4
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %add4 = add i32 %13, %14
  %xor5 = xor i32 %12, %add4
  %xor6 = xor i32 %11, %xor5
  store i32 %xor6, ptr %acc, align 4
  %15 = load i32, ptr %x.addr, align 4
  %16 = load i32, ptr %y.addr, align 4
  %xor7 = xor i32 %15, %16
  %17 = load i32, ptr %i, align 4
  %xor8 = xor i32 %xor7, %17
  %and9 = and i32 %xor8, 512
  %cmp10 = icmp eq i32 %and9, 0
  br i1 %cmp10, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %i, align 4
  %and11 = and i32 %19, %20
  %xor12 = xor i32 %and11, 0
  %xor13 = xor i32 %18, %xor12
  store i32 %xor13, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %acc, align 4
  %and14 = and i32 %22, %23
  %add15 = add i32 0, %and14
  %24 = load i32, ptr %y.addr, align 4
  %xor16 = xor i32 %24, -1104335334
  %25 = load i32, ptr %x.addr, align 4
  %26 = load i32, ptr %x.addr, align 4
  %or = or i32 %25, %26
  %xor17 = xor i32 %xor16, %or
  %and18 = and i32 %add15, %xor17
  %xor19 = xor i32 %21, %and18
  store i32 %xor19, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %28, 5
  %29 = load i32, ptr %y.addr, align 4
  %30 = load i32, ptr %i, align 4
  %and20 = and i32 %29, %30
  %31 = load i32, ptr %y.addr, align 4
  %32 = load i32, ptr %x.addr, align 4
  %sub = sub i32 %31, %32
  %add21 = add i32 %and20, %sub
  %or22 = or i32 %shl, %add21
  %xor23 = xor i32 %27, %or22
  store i32 %xor23, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %33 = load i32, ptr %i, align 4
  %inc = add i32 %33, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %34 = load i32, ptr %x.addr, align 4
  %35 = load i32, ptr %y.addr, align 4
  %xor24 = xor i32 %34, %35
  %and25 = and i32 %xor24, 1073741824
  %cmp26 = icmp eq i32 %and25, 0
  br i1 %cmp26, label %if.then27, label %if.else41

if.then27:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %x.addr, align 4
  %38 = load i32, ptr %x.addr, align 4
  %sub28 = sub i32 %37, %38
  %sub29 = sub i32 16, %sub28
  %39 = load i32, ptr %x.addr, align 4
  %40 = load i32, ptr %acc, align 4
  %and30 = and i32 %39, %40
  %sub31 = sub i32 %and30, 3968
  %xor32 = xor i32 %sub29, %sub31
  %xor33 = xor i32 %36, %xor32
  store i32 %xor33, ptr %acc, align 4
  %41 = load i32, ptr %acc, align 4
  %42 = load i32, ptr %y.addr, align 4
  %43 = load i32, ptr %acc, align 4
  %or34 = or i32 %42, %43
  %sub35 = sub i32 %or34, 7
  %44 = load i32, ptr %acc, align 4
  %or36 = or i32 2, %44
  %45 = load i32, ptr %x.addr, align 4
  %46 = load i32, ptr %acc, align 4
  %xor37 = xor i32 %45, %46
  %and38 = and i32 %or36, %xor37
  %sub39 = sub i32 %sub35, %and38
  %xor40 = xor i32 %41, %sub39
  store i32 %xor40, ptr %acc, align 4
  br label %if.end47

if.else41:                                        ; preds = %for.end
  %47 = load i32, ptr %acc, align 4
  %48 = load i32, ptr %acc, align 4
  %and42 = and i32 31, %48
  %xor43 = xor i32 %47, %and42
  store i32 %xor43, ptr %acc, align 4
  %49 = load i32, ptr %acc, align 4
  %50 = load i32, ptr %y.addr, align 4
  %shl44 = shl i32 %50, 9
  %51 = load i32, ptr %acc, align 4
  %sub45 = sub i32 %shl44, %51
  %xor46 = xor i32 %49, %sub45
  store i32 %xor46, ptr %acc, align 4
  br label %if.end47

if.end47:                                         ; preds = %if.else41, %if.then27
  %52 = load i32, ptr %acc, align 4
  ret i32 %52
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
