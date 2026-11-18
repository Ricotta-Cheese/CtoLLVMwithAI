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
  %9 = load i32, ptr %i, align 4
  %mul2 = mul i32 %8, %9
  %xor = xor i32 %7, %mul2
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %i, align 4
  %12 = load i32, ptr %y.addr, align 4
  %and3 = and i32 %11, %12
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %i, align 4
  %or = or i32 %13, %14
  %and4 = and i32 %and3, %or
  %15 = load i32, ptr %x.addr, align 4
  %16 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %15, %16
  %and6 = and i32 511, %xor5
  %mul7 = mul i32 %and4, %and6
  %xor8 = xor i32 %10, %mul7
  store i32 %xor8, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %xor9 = xor i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor10 = xor i32 %xor9, %19
  %and11 = and i32 %xor10, 4096
  %cmp12 = icmp eq i32 %and11, 0
  br i1 %cmp12, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %i, align 4
  %shr = lshr i32 %21, 1
  %and13 = and i32 134217728, %shr
  %xor14 = xor i32 %20, %and13
  store i32 %xor14, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %or15 = or i32 %23, %24
  %25 = load i32, ptr %y.addr, align 4
  %26 = load i32, ptr %i, align 4
  %mul16 = mul i32 %25, %26
  %add17 = add i32 %or15, %mul16
  %xor18 = xor i32 %22, %add17
  store i32 %xor18, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %y.addr, align 4
  %shr19 = lshr i32 %28, 19
  %29 = load i32, ptr %x.addr, align 4
  %add20 = add i32 %29, 15
  %add21 = add i32 %shr19, %add20
  %shr22 = lshr i32 %add21, 14
  %xor23 = xor i32 %27, %shr22
  store i32 %xor23, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %x.addr, align 4
  %32 = load i32, ptr %x.addr, align 4
  %and24 = and i32 %31, %32
  %xor25 = xor i32 %30, %and24
  store i32 %xor25, ptr %acc, align 4
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
  %xor26 = xor i32 %34, %35
  %and27 = and i32 %xor26, 1048576
  %cmp28 = icmp eq i32 %and27, 0
  br i1 %cmp28, label %if.then29, label %if.else33

if.then29:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %y.addr, align 4
  %mul30 = mul i32 %37, %38
  %shr31 = lshr i32 %mul30, 17
  %xor32 = xor i32 %36, %shr31
  store i32 %xor32, ptr %acc, align 4
  br label %if.end41

if.else33:                                        ; preds = %for.end
  %39 = load i32, ptr %acc, align 4
  %40 = load i32, ptr %x.addr, align 4
  %xor34 = xor i32 %39, %40
  store i32 %xor34, ptr %acc, align 4
  %41 = load i32, ptr %acc, align 4
  %42 = load i32, ptr %acc, align 4
  %43 = load i32, ptr %y.addr, align 4
  %add35 = add i32 %42, %43
  %44 = load i32, ptr %acc, align 4
  %xor36 = xor i32 %add35, %44
  %45 = load i32, ptr %y.addr, align 4
  %add37 = add i32 %45, 2
  %shr38 = lshr i32 %add37, 0
  %or39 = or i32 %xor36, %shr38
  %xor40 = xor i32 %41, %or39
  store i32 %xor40, ptr %acc, align 4
  br label %if.end41

if.end41:                                         ; preds = %if.else33, %if.then29
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
