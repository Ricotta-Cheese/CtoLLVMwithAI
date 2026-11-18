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
  %8 = load i32, ptr %y.addr, align 4
  %9 = load i32, ptr %acc, align 4
  %add2 = add i32 %8, %9
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %x.addr, align 4
  %and3 = and i32 %10, %11
  %sub4 = sub i32 %add2, %and3
  %xor = xor i32 %7, %sub4
  store i32 %xor, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %i, align 4
  %14 = load i32, ptr %x.addr, align 4
  %add5 = add i32 %13, %14
  %xor6 = xor i32 %12, %add5
  store i32 %xor6, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %x.addr, align 4
  %mul = mul i32 %16, %17
  %18 = load i32, ptr %i, align 4
  %19 = load i32, ptr %x.addr, align 4
  %mul7 = mul i32 %18, %19
  %xor8 = xor i32 %mul, %mul7
  %xor9 = xor i32 %15, %xor8
  store i32 %xor9, ptr %acc, align 4
  %20 = load i32, ptr %x.addr, align 4
  %21 = load i32, ptr %y.addr, align 4
  %xor10 = xor i32 %20, %21
  %22 = load i32, ptr %i, align 4
  %xor11 = xor i32 %xor10, %22
  %and12 = and i32 %xor11, 4
  %cmp13 = icmp eq i32 %and12, 0
  br i1 %cmp13, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %shl = shl i32 %24, 21
  %xor14 = xor i32 %23, %shl
  store i32 %xor14, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %add15 = add i32 0, %26
  %xor16 = xor i32 %25, %add15
  store i32 %xor16, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %y.addr, align 4
  %shr = lshr i32 %28, 19
  %xor17 = xor i32 %27, %shr
  store i32 %xor17, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %i, align 4
  %31 = load i32, ptr %i, align 4
  %add18 = add i32 %30, %31
  %xor19 = xor i32 %29, %add18
  store i32 %xor19, ptr %acc, align 4
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
  %xor20 = xor i32 %33, %34
  %and21 = and i32 %xor20, 131072
  %cmp22 = icmp eq i32 %and21, 0
  br i1 %cmp22, label %if.then23, label %if.else27

if.then23:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %y.addr, align 4
  %shr24 = lshr i32 %36, 26
  %or = or i32 251658240, %shr24
  %shl25 = shl i32 %or, 20
  %xor26 = xor i32 %35, %shl25
  store i32 %xor26, ptr %acc, align 4
  br label %if.end38

if.else27:                                        ; preds = %for.end
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %x.addr, align 4
  %shl28 = shl i32 %38, 20
  %39 = load i32, ptr %acc, align 4
  %mul29 = mul i32 %39, -1
  %xor30 = xor i32 %shl28, %mul29
  %xor31 = xor i32 %37, %xor30
  store i32 %xor31, ptr %acc, align 4
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %y.addr, align 4
  %42 = load i32, ptr %x.addr, align 4
  %sub32 = sub i32 %41, %42
  %shr33 = lshr i32 %sub32, 30
  %43 = load i32, ptr %y.addr, align 4
  %44 = load i32, ptr %acc, align 4
  %or34 = or i32 %43, %44
  %mul35 = mul i32 1, %or34
  %add36 = add i32 %shr33, %mul35
  %xor37 = xor i32 %40, %add36
  store i32 %xor37, ptr %acc, align 4
  br label %if.end38

if.end38:                                         ; preds = %if.else27, %if.then23
  %45 = load i32, ptr %acc, align 4
  ret i32 %45
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
