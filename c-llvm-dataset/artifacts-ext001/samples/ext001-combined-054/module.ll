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
  %9 = load i32, ptr %i, align 4
  %or = or i32 %8, %9
  %xor = xor i32 %7, %or
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %xor2 = xor i32 %11, 3
  %xor3 = xor i32 %10, %xor2
  store i32 %xor3, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %x.addr, align 4
  %mul = mul i32 %13, 3
  %14 = load i32, ptr %i, align 4
  %15 = load i32, ptr %acc, align 4
  %mul4 = mul i32 %14, %15
  %sub5 = sub i32 %mul, %mul4
  %xor6 = xor i32 %12, %sub5
  store i32 %xor6, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %xor7 = xor i32 %16, %17
  %18 = load i32, ptr %i, align 4
  %xor8 = xor i32 %xor7, %18
  %and9 = and i32 %xor8, 128
  %cmp10 = icmp eq i32 %and9, 0
  br i1 %cmp10, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %i, align 4
  %or11 = or i32 %20, %21
  %xor12 = xor i32 %19, %or11
  store i32 %xor12, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %y.addr, align 4
  %24 = load i32, ptr %x.addr, align 4
  %mul13 = mul i32 %23, %24
  %xor14 = xor i32 %22, %mul13
  store i32 %xor14, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %x.addr, align 4
  %27 = load i32, ptr %i, align 4
  %sub15 = sub i32 %26, %27
  %sub16 = sub i32 0, %sub15
  %xor17 = xor i32 %25, %sub16
  store i32 %xor17, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %28 = load i32, ptr %i, align 4
  %inc = add i32 %28, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %29 = load i32, ptr %x.addr, align 4
  %30 = load i32, ptr %y.addr, align 4
  %xor18 = xor i32 %29, %30
  %and19 = and i32 %xor18, 128
  %cmp20 = icmp eq i32 %and19, 0
  br i1 %cmp20, label %if.then21, label %if.else32

if.then21:                                        ; preds = %for.end
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %acc, align 4
  %and22 = and i32 1, %32
  %33 = load i32, ptr %y.addr, align 4
  %or23 = or i32 %and22, %33
  %xor24 = xor i32 %31, %or23
  store i32 %xor24, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %sub25 = sub i32 %35, -1
  %36 = load i32, ptr %y.addr, align 4
  %and26 = and i32 %36, 845445268
  %xor27 = xor i32 %sub25, %and26
  %37 = load i32, ptr %y.addr, align 4
  %xor28 = xor i32 %37, 7
  %xor29 = xor i32 31, %xor28
  %or30 = or i32 %xor27, %xor29
  %xor31 = xor i32 %34, %or30
  store i32 %xor31, ptr %acc, align 4
  br label %if.end35

if.else32:                                        ; preds = %for.end
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %y.addr, align 4
  %40 = load i32, ptr %acc, align 4
  %xor33 = xor i32 %39, %40
  %shl = shl i32 %xor33, 7
  %xor34 = xor i32 %38, %shl
  store i32 %xor34, ptr %acc, align 4
  br label %if.end35

if.end35:                                         ; preds = %if.else32, %if.then21
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
