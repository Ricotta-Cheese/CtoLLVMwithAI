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
  %xor = xor i32 %7, 944078527
  store i32 %xor, ptr %acc, align 4
  %8 = load i32, ptr %x.addr, align 4
  %9 = load i32, ptr %y.addr, align 4
  %xor2 = xor i32 %8, %9
  %10 = load i32, ptr %i, align 4
  %xor3 = xor i32 %xor2, %10
  %and4 = and i32 %xor3, 16
  %cmp5 = icmp eq i32 %and4, 0
  br i1 %cmp5, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %13 = load i32, ptr %i, align 4
  %mul = mul i32 %13, 15
  %sub6 = sub i32 %mul, 3
  %xor7 = xor i32 %12, %sub6
  %xor8 = xor i32 %11, %xor7
  store i32 %xor8, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %i, align 4
  %add9 = add i32 %15, 3
  %16 = load i32, ptr %i, align 4
  %shr = lshr i32 %16, 8
  %xor10 = xor i32 %add9, %shr
  %xor11 = xor i32 %14, %xor10
  store i32 %xor11, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %i, align 4
  %xor12 = xor i32 16, %18
  %xor13 = xor i32 %17, %xor12
  store i32 %xor13, ptr %acc, align 4
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %x.addr, align 4
  %21 = load i32, ptr %y.addr, align 4
  %or = or i32 %20, %21
  %xor14 = xor i32 %19, %or
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %22 = load i32, ptr %i, align 4
  %inc = add i32 %22, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %23 = load i32, ptr %x.addr, align 4
  %24 = load i32, ptr %y.addr, align 4
  %xor15 = xor i32 %23, %24
  %and16 = and i32 %xor15, 268435456
  %cmp17 = icmp eq i32 %and16, 0
  br i1 %cmp17, label %if.then18, label %if.else26

if.then18:                                        ; preds = %for.end
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %y.addr, align 4
  %27 = load i32, ptr %x.addr, align 4
  %28 = load i32, ptr %x.addr, align 4
  %xor19 = xor i32 %27, %28
  %add20 = add i32 %26, %xor19
  %29 = load i32, ptr %x.addr, align 4
  %30 = load i32, ptr %acc, align 4
  %or21 = or i32 %29, %30
  %31 = load i32, ptr %acc, align 4
  %add22 = add i32 %31, 31
  %add23 = add i32 %or21, %add22
  %and24 = and i32 %add20, %add23
  %xor25 = xor i32 %25, %and24
  store i32 %xor25, ptr %acc, align 4
  br label %if.end34

if.else26:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %y.addr, align 4
  %34 = load i32, ptr %acc, align 4
  %sub27 = sub i32 %33, %34
  %35 = load i32, ptr %x.addr, align 4
  %36 = load i32, ptr %y.addr, align 4
  %and28 = and i32 %35, %36
  %add29 = add i32 %sub27, %and28
  %37 = load i32, ptr %y.addr, align 4
  %38 = load i32, ptr %acc, align 4
  %and30 = and i32 0, %38
  %xor31 = xor i32 %37, %and30
  %and32 = and i32 %add29, %xor31
  %xor33 = xor i32 %32, %and32
  store i32 %xor33, ptr %acc, align 4
  br label %if.end34

if.end34:                                         ; preds = %if.else26, %if.then18
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
