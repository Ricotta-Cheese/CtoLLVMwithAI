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
  %xor = xor i32 16, %8
  %and2 = and i32 1, %xor
  %shl = shl i32 %and2, 0
  %xor3 = xor i32 %7, %shl
  store i32 %xor3, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %xor4 = xor i32 %9, 0
  store i32 %xor4, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %11 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %10, %11
  %12 = load i32, ptr %i, align 4
  %xor6 = xor i32 %xor5, %12
  %and7 = and i32 %xor6, 1073741824
  %cmp8 = icmp eq i32 %and7, 0
  br i1 %cmp8, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %y.addr, align 4
  %shr = lshr i32 %14, 30
  %xor9 = xor i32 %13, %shr
  store i32 %xor9, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %acc, align 4
  %xor10 = xor i32 15, %17
  %sub11 = sub i32 %xor10, 31
  %18 = load i32, ptr %x.addr, align 4
  %shl12 = shl i32 %18, 9
  %sub13 = sub i32 %sub11, %shl12
  %xor14 = xor i32 %15, %sub13
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %x.addr, align 4
  %shr15 = lshr i32 %20, 25
  %xor16 = xor i32 %19, %shr15
  store i32 %xor16, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %i, align 4
  %23 = load i32, ptr %x.addr, align 4
  %add17 = add i32 %22, %23
  %24 = load i32, ptr %acc, align 4
  %sub18 = sub i32 %add17, %24
  %25 = load i32, ptr %x.addr, align 4
  %26 = load i32, ptr %x.addr, align 4
  %xor19 = xor i32 %25, %26
  %xor20 = xor i32 3, %xor19
  %xor21 = xor i32 %sub18, %xor20
  %xor22 = xor i32 %21, %xor21
  store i32 %xor22, ptr %acc, align 4
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
  %xor23 = xor i32 %28, %29
  %and24 = and i32 %xor23, 256
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else30

if.then26:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %xor27 = xor i32 %30, 15
  store i32 %xor27, ptr %acc, align 4
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %x.addr, align 4
  %33 = load i32, ptr %x.addr, align 4
  %mul = mul i32 %32, %33
  %xor28 = xor i32 %31, %mul
  store i32 %xor28, ptr %acc, align 4
  br label %if.end34

if.else30:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %shl29 = shl i32 %35, 3
  %xor31 = xor i32 %34, %shl29
  store i32 %xor31, ptr %acc, align 4
  br label %if.end34

if.end34:                                         ; preds = %if.else30, %if.then26
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
