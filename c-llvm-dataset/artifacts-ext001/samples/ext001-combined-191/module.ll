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
  %8 = load i32, ptr %y.addr, align 4
  %9 = load i32, ptr %x.addr, align 4
  %mul = mul i32 %9, 2
  %and3 = and i32 %8, %mul
  %xor = xor i32 %7, %and3
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %mul4 = mul i32 %11, %12
  %13 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %13, 28
  %and5 = and i32 %mul4, %shl
  %xor6 = xor i32 %10, %and5
  store i32 %xor6, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor7 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor8 = xor i32 %xor7, %16
  %and9 = and i32 %xor8, 134217728
  %cmp10 = icmp eq i32 %and9, 0
  br i1 %cmp10, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %shr = lshr i32 %18, 2
  %sub = sub i32 -2077801678, %shr
  %19 = load i32, ptr %i, align 4
  %sub11 = sub i32 %19, 16
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %x.addr, align 4
  %sub12 = sub i32 %20, %21
  %and13 = and i32 %sub11, %sub12
  %or = or i32 %sub, %and13
  %xor14 = xor i32 %17, %or
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %x.addr, align 4
  %24 = load i32, ptr %acc, align 4
  %mul15 = mul i32 %23, %24
  %or16 = or i32 %mul15, 17
  %xor17 = xor i32 %22, %or16
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
  %and19 = and i32 %xor18, 8
  %cmp20 = icmp eq i32 %and19, 0
  br i1 %cmp20, label %if.then21, label %if.else27

if.then21:                                        ; preds = %for.end
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %x.addr, align 4
  %30 = load i32, ptr %y.addr, align 4
  %31 = load i32, ptr %acc, align 4
  %or22 = or i32 %30, %31
  %32 = load i32, ptr %y.addr, align 4
  %33 = load i32, ptr %x.addr, align 4
  %add23 = add i32 %32, %33
  %xor24 = xor i32 %or22, %add23
  %and25 = and i32 %29, %xor24
  %xor26 = xor i32 %28, %and25
  store i32 %xor26, ptr %acc, align 4
  br label %if.end32

if.else27:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %x.addr, align 4
  %36 = load i32, ptr %y.addr, align 4
  %sub28 = sub i32 %35, %36
  %37 = load i32, ptr %y.addr, align 4
  %38 = load i32, ptr %acc, align 4
  %or29 = or i32 %37, %38
  %mul30 = mul i32 %sub28, %or29
  %xor31 = xor i32 %34, %mul30
  store i32 %xor31, ptr %acc, align 4
  br label %if.end32

if.end32:                                         ; preds = %if.else27, %if.then21
  %39 = load i32, ptr %acc, align 4
  ret i32 %39
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
