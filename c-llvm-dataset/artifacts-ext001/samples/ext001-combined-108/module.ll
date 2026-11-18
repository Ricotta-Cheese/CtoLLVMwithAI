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
  %shr = lshr i32 %8, 21
  %9 = load i32, ptr %acc, align 4
  %shl = shl i32 %9, 16
  %xor = xor i32 %shr, %shl
  %10 = load i32, ptr %x.addr, align 4
  %shl3 = shl i32 %10, 10
  %add4 = add i32 %xor, %shl3
  %xor5 = xor i32 %7, %add4
  store i32 %xor5, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %i, align 4
  %13 = load i32, ptr %x.addr, align 4
  %and6 = and i32 %12, %13
  %14 = load i32, ptr %x.addr, align 4
  %mul = mul i32 %and6, %14
  %15 = load i32, ptr %acc, align 4
  %shl7 = shl i32 %15, 15
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %acc, align 4
  %mul8 = mul i32 %16, %17
  %mul9 = mul i32 %shl7, %mul8
  %or = or i32 %mul, %mul9
  %xor10 = xor i32 %11, %or
  store i32 %xor10, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %acc, align 4
  %shr11 = lshr i32 %19, 30
  %20 = load i32, ptr %x.addr, align 4
  %shl12 = shl i32 %20, 4
  %21 = load i32, ptr %acc, align 4
  %mul13 = mul i32 %21, 1
  %xor14 = xor i32 %shl12, %mul13
  %mul15 = mul i32 %shr11, %xor14
  %xor16 = xor i32 %18, %mul15
  store i32 %xor16, ptr %acc, align 4
  %22 = load i32, ptr %x.addr, align 4
  %23 = load i32, ptr %y.addr, align 4
  %xor17 = xor i32 %22, %23
  %24 = load i32, ptr %i, align 4
  %xor18 = xor i32 %xor17, %24
  %and19 = and i32 %xor18, 2097152
  %cmp20 = icmp eq i32 %and19, 0
  br i1 %cmp20, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %x.addr, align 4
  %xor21 = xor i32 %25, %26
  store i32 %xor21, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %y.addr, align 4
  %shr22 = lshr i32 %28, 11
  %xor23 = xor i32 %27, %shr22
  store i32 %xor23, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %29 = load i32, ptr %acc, align 4
  %xor24 = xor i32 %29, 49
  store i32 %xor24, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %i, align 4
  %xor25 = xor i32 %31, -1
  %32 = load i32, ptr %i, align 4
  %xor26 = xor i32 %32, 1
  %and27 = and i32 %xor25, %xor26
  %shl28 = shl i32 %and27, 16
  %xor29 = xor i32 %30, %shl28
  store i32 %xor29, ptr %acc, align 4
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
  %xor30 = xor i32 %34, %35
  %and31 = and i32 %xor30, 128
  %cmp32 = icmp eq i32 %and31, 0
  br i1 %cmp32, label %if.then33, label %if.else38

if.then33:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %acc, align 4
  %shl34 = shl i32 %37, 22
  %shr35 = lshr i32 %shl34, 10
  %xor36 = xor i32 %36, %shr35
  store i32 %xor36, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %xor37 = xor i32 %38, -1263671517
  store i32 %xor37, ptr %acc, align 4
  br label %if.end45

if.else38:                                        ; preds = %for.end
  %39 = load i32, ptr %acc, align 4
  %xor39 = xor i32 %39, 3
  store i32 %xor39, ptr %acc, align 4
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %x.addr, align 4
  %42 = load i32, ptr %y.addr, align 4
  %xor40 = xor i32 %41, %42
  %43 = load i32, ptr %acc, align 4
  %44 = load i32, ptr %y.addr, align 4
  %mul41 = mul i32 %43, %44
  %mul42 = mul i32 %xor40, %mul41
  %45 = load i32, ptr %x.addr, align 4
  %or43 = or i32 %mul42, %45
  %xor44 = xor i32 %40, %or43
  store i32 %xor44, ptr %acc, align 4
  br label %if.end45

if.end45:                                         ; preds = %if.else38, %if.then33
  %46 = load i32, ptr %acc, align 4
  ret i32 %46
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
