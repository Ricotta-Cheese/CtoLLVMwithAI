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
  %xor = xor i32 %7, 991230903
  store i32 %xor, ptr %acc, align 4
  %8 = load i32, ptr %acc, align 4
  %xor3 = xor i32 %8, 1073741824
  store i32 %xor3, ptr %acc, align 4
  %9 = load i32, ptr %x.addr, align 4
  %10 = load i32, ptr %y.addr, align 4
  %xor4 = xor i32 %9, %10
  %11 = load i32, ptr %i, align 4
  %xor5 = xor i32 %xor4, %11
  %and6 = and i32 %xor5, 8388608
  %cmp7 = icmp eq i32 %and6, 0
  br i1 %cmp7, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %x.addr, align 4
  %xor8 = xor i32 %12, %13
  store i32 %xor8, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %i, align 4
  %16 = load i32, ptr %y.addr, align 4
  %and9 = and i32 %15, %16
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %xor10 = xor i32 %17, %18
  %add11 = add i32 %and9, %xor10
  %19 = load i32, ptr %x.addr, align 4
  %20 = load i32, ptr %x.addr, align 4
  %sub = sub i32 %19, %20
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %i, align 4
  %xor12 = xor i32 %21, %22
  %mul = mul i32 %sub, %xor12
  %or = or i32 %add11, %mul
  %xor13 = xor i32 %14, %or
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %i, align 4
  %25 = load i32, ptr %acc, align 4
  %or14 = or i32 -743593182, %25
  %and15 = and i32 %24, %or14
  %xor16 = xor i32 %23, %and15
  store i32 %xor16, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %x.addr, align 4
  %shr = lshr i32 %27, 14
  %xor17 = xor i32 %26, %shr
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
  %and19 = and i32 %xor18, 16384
  %cmp20 = icmp eq i32 %and19, 0
  br i1 %cmp20, label %if.then21, label %if.else24

if.then21:                                        ; preds = %for.end
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %y.addr, align 4
  %or22 = or i32 -1, %32
  %xor23 = xor i32 %31, %or22
  store i32 %xor23, ptr %acc, align 4
  br label %if.end32

if.else24:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %and25 = and i32 15, %34
  %35 = load i32, ptr %acc, align 4
  %mul26 = mul i32 %and25, %35
  %36 = load i32, ptr %x.addr, align 4
  %37 = load i32, ptr %acc, align 4
  %xor27 = xor i32 %36, %37
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %acc, align 4
  %and28 = and i32 %38, %39
  %add29 = add i32 %xor27, %and28
  %or30 = or i32 %mul26, %add29
  %xor31 = xor i32 %33, %or30
  store i32 %xor31, ptr %acc, align 4
  br label %if.end32

if.end32:                                         ; preds = %if.else24, %if.then21
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
