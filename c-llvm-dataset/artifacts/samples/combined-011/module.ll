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
  %9 = load i32, ptr %acc, align 4
  %sub = sub i32 %8, %9
  %xor = xor i32 %7, %sub
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %i, align 4
  %xor2 = xor i32 %10, %11
  store i32 %xor2, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %x.addr, align 4
  %14 = load i32, ptr %i, align 4
  %15 = load i32, ptr %y.addr, align 4
  %sub3 = sub i32 %14, %15
  %or = or i32 %13, %sub3
  %16 = load i32, ptr %y.addr, align 4
  %xor4 = xor i32 %16, 1
  %sub5 = sub i32 %or, %xor4
  %xor6 = xor i32 %12, %sub5
  store i32 %xor6, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %xor7 = xor i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor8 = xor i32 %xor7, %19
  %and9 = and i32 %xor8, 4096
  %cmp10 = icmp eq i32 %and9, 0
  br i1 %cmp10, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %x.addr, align 4
  %22 = load i32, ptr %acc, align 4
  %sub11 = sub i32 %21, %22
  %23 = load i32, ptr %acc, align 4
  %shl = shl i32 %23, 4
  %and12 = and i32 %sub11, %shl
  %xor13 = xor i32 %20, %and12
  store i32 %xor13, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %i, align 4
  %shl14 = shl i32 %25, 14
  %26 = load i32, ptr %i, align 4
  %27 = load i32, ptr %y.addr, align 4
  %or15 = or i32 %26, %27
  %or16 = or i32 %shl14, %or15
  %xor17 = xor i32 %24, %or16
  store i32 %xor17, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %shl18 = shl i32 %29, 12
  %mul19 = mul i32 %shl18, 8192
  %30 = load i32, ptr %y.addr, align 4
  %31 = load i32, ptr %y.addr, align 4
  %xor20 = xor i32 %30, %31
  %sub21 = sub i32 980611275, %xor20
  %or22 = or i32 %mul19, %sub21
  %xor23 = xor i32 %28, %or22
  store i32 %xor23, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %32 = load i32, ptr %i, align 4
  %inc = add i32 %32, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %33 = load i32, ptr %x.addr, align 4
  %34 = load i32, ptr %y.addr, align 4
  %xor24 = xor i32 %33, %34
  %and25 = and i32 %xor24, 256
  %cmp26 = icmp eq i32 %and25, 0
  br i1 %cmp26, label %if.then27, label %if.else33

if.then27:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %x.addr, align 4
  %shl28 = shl i32 %36, 0
  %xor29 = xor i32 %35, %shl28
  store i32 %xor29, ptr %acc, align 4
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %and30 = and i32 %38, 337358672
  %add31 = add i32 %and30, 2
  %xor32 = xor i32 %37, %add31
  store i32 %xor32, ptr %acc, align 4
  br label %if.end35

if.else33:                                        ; preds = %for.end
  %39 = load i32, ptr %acc, align 4
  %40 = load i32, ptr %x.addr, align 4
  %xor34 = xor i32 %39, %40
  store i32 %xor34, ptr %acc, align 4
  br label %if.end35

if.end35:                                         ; preds = %if.else33, %if.then27
  %41 = load i32, ptr %acc, align 4
  ret i32 %41
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
