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
  %xor = xor i32 %7, 31
  store i32 %xor, ptr %acc, align 4
  %8 = load i32, ptr %acc, align 4
  %9 = load i32, ptr %y.addr, align 4
  %10 = load i32, ptr %acc, align 4
  %sub = sub i32 %9, %10
  %11 = load i32, ptr %i, align 4
  %add2 = add i32 -1, %11
  %and3 = and i32 %sub, %add2
  %xor4 = xor i32 %8, %and3
  store i32 %xor4, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %13 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %12, %13
  %14 = load i32, ptr %i, align 4
  %xor6 = xor i32 %xor5, %14
  %and7 = and i32 %xor6, 131072
  %cmp8 = icmp eq i32 %and7, 0
  br i1 %cmp8, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %i, align 4
  %add9 = add i32 0, %16
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %i, align 4
  %mul10 = mul i32 %17, %18
  %or = or i32 %add9, %mul10
  %19 = load i32, ptr %i, align 4
  %mul11 = mul i32 %19, 1
  %and12 = and i32 43581440, %mul11
  %xor13 = xor i32 %or, %and12
  %xor14 = xor i32 %15, %xor13
  store i32 %xor14, ptr %acc, align 4
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %i, align 4
  %xor15 = xor i32 %20, %21
  store i32 %xor15, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %x.addr, align 4
  %24 = load i32, ptr %acc, align 4
  %mul16 = mul i32 %23, %24
  %xor17 = xor i32 %22, %mul16
  store i32 %xor17, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %i, align 4
  %27 = load i32, ptr %acc, align 4
  %or18 = or i32 %26, %27
  %xor19 = xor i32 %or18, 7
  %28 = load i32, ptr %x.addr, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %mul20 = mul i32 %29, %30
  %or21 = or i32 %28, %mul20
  %mul22 = mul i32 %xor19, %or21
  %xor23 = xor i32 %25, %mul22
  store i32 %xor23, ptr %acc, align 4
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
  %xor24 = xor i32 %32, %33
  %and25 = and i32 %xor24, 16
  %cmp26 = icmp eq i32 %and25, 0
  br i1 %cmp26, label %if.then27, label %if.else34

if.then27:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %x.addr, align 4
  %add28 = add i32 %35, %36
  %37 = load i32, ptr %acc, align 4
  %shr = lshr i32 %37, 11
  %sub29 = sub i32 %add28, %shr
  %xor30 = xor i32 %34, %sub29
  store i32 %xor30, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %x.addr, align 4
  %sub31 = sub i32 15, %39
  %mul32 = mul i32 21, %sub31
  %xor33 = xor i32 %38, %mul32
  store i32 %xor33, ptr %acc, align 4
  br label %if.end37

if.else34:                                        ; preds = %for.end
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %x.addr, align 4
  %42 = load i32, ptr %acc, align 4
  %or35 = or i32 %41, %42
  %xor36 = xor i32 %40, %or35
  store i32 %xor36, ptr %acc, align 4
  br label %if.end37

if.end37:                                         ; preds = %if.else34, %if.then27
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
