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
  %8 = load i32, ptr %y.addr, align 4
  %9 = load i32, ptr %acc, align 4
  %or = or i32 %8, %9
  %mul2 = mul i32 %or, 15
  %10 = load i32, ptr %i, align 4
  %and3 = and i32 %10, 0
  %xor = xor i32 %and3, 0
  %or4 = or i32 %mul2, %xor
  %xor5 = xor i32 %7, %or4
  store i32 %xor5, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %i, align 4
  %13 = load i32, ptr %i, align 4
  %xor6 = xor i32 %12, %13
  %xor7 = xor i32 %11, %xor6
  store i32 %xor7, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor8 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor9 = xor i32 %xor8, %16
  %and10 = and i32 %xor9, 33554432
  %cmp11 = icmp eq i32 %and10, 0
  br i1 %cmp11, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %i, align 4
  %19 = load i32, ptr %y.addr, align 4
  %sub = sub i32 %18, %19
  %20 = load i32, ptr %x.addr, align 4
  %21 = load i32, ptr %acc, align 4
  %mul12 = mul i32 %20, %21
  %and13 = and i32 %sub, %mul12
  %xor14 = xor i32 %17, %and13
  store i32 %xor14, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %x.addr, align 4
  %24 = load i32, ptr %i, align 4
  %mul15 = mul i32 %23, %24
  %xor16 = xor i32 %22, %mul15
  store i32 %xor16, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %i, align 4
  %27 = load i32, ptr %x.addr, align 4
  %28 = load i32, ptr %y.addr, align 4
  %sub17 = sub i32 %27, %28
  %mul18 = mul i32 %26, %sub17
  %xor19 = xor i32 %25, %mul18
  store i32 %xor19, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %29 = load i32, ptr %i, align 4
  %inc = add i32 %29, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %30 = load i32, ptr %x.addr, align 4
  %31 = load i32, ptr %y.addr, align 4
  %xor20 = xor i32 %30, %31
  %and21 = and i32 %xor20, 16777216
  %cmp22 = icmp eq i32 %and21, 0
  br i1 %cmp22, label %if.then23, label %if.else27

if.then23:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %y.addr, align 4
  %shr = lshr i32 %33, 4
  %xor24 = xor i32 %32, %shr
  store i32 %xor24, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %mul25 = mul i32 %35, -1
  %xor26 = xor i32 %34, %mul25
  store i32 %xor26, ptr %acc, align 4
  br label %if.end31

if.else27:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %mul28 = mul i32 %37, %38
  %xor29 = xor i32 %36, %mul28
  store i32 %xor29, ptr %acc, align 4
  %39 = load i32, ptr %acc, align 4
  %xor30 = xor i32 %39, 1
  store i32 %xor30, ptr %acc, align 4
  br label %if.end31

if.end31:                                         ; preds = %if.else27, %if.then23
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
