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
  %and3 = and i32 2, %8
  %9 = load i32, ptr %x.addr, align 4
  %10 = load i32, ptr %x.addr, align 4
  %add4 = add i32 %9, %10
  %and5 = and i32 %and3, %add4
  %xor = xor i32 %7, %and5
  store i32 %xor, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %y.addr, align 4
  %13 = load i32, ptr %y.addr, align 4
  %sub = sub i32 %12, %13
  %and6 = and i32 -141165691, %sub
  %xor7 = xor i32 %11, %and6
  store i32 %xor7, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %x.addr, align 4
  %16 = load i32, ptr %acc, align 4
  %or = or i32 %15, %16
  %17 = load i32, ptr %y.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %mul = mul i32 %17, %18
  %sub8 = sub i32 %or, %mul
  %shl = shl i32 %sub8, 28
  %xor9 = xor i32 %14, %shl
  store i32 %xor9, ptr %acc, align 4
  %19 = load i32, ptr %x.addr, align 4
  %20 = load i32, ptr %y.addr, align 4
  %xor10 = xor i32 %19, %20
  %21 = load i32, ptr %i, align 4
  %xor11 = xor i32 %xor10, %21
  %and12 = and i32 %xor11, 524288
  %cmp13 = icmp eq i32 %and12, 0
  br i1 %cmp13, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %y.addr, align 4
  %24 = load i32, ptr %i, align 4
  %mul14 = mul i32 %23, %24
  %sub15 = sub i32 15, %mul14
  %xor16 = xor i32 %22, %sub15
  store i32 %xor16, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %x.addr, align 4
  %27 = load i32, ptr %x.addr, align 4
  %sub17 = sub i32 %26, %27
  %shl18 = shl i32 %sub17, 29
  %shl19 = shl i32 %shl18, 6
  %xor20 = xor i32 %25, %shl19
  store i32 %xor20, ptr %acc, align 4
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
  %xor21 = xor i32 %29, %30
  %and22 = and i32 %xor21, 131072
  %cmp23 = icmp eq i32 %and22, 0
  br i1 %cmp23, label %if.then24, label %if.else27

if.then24:                                        ; preds = %for.end
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %acc, align 4
  %shl25 = shl i32 %32, 17
  %xor26 = xor i32 %31, %shl25
  store i32 %xor26, ptr %acc, align 4
  br label %if.end34

if.else27:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %y.addr, align 4
  %xor28 = xor i32 %33, %34
  store i32 %xor28, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %acc, align 4
  %shr = lshr i32 %36, 17
  %shl29 = shl i32 %shr, 6
  %37 = load i32, ptr %acc, align 4
  %xor30 = xor i32 16, %37
  %shr31 = lshr i32 %xor30, 8
  %xor32 = xor i32 %shl29, %shr31
  %xor33 = xor i32 %35, %xor32
  store i32 %xor33, ptr %acc, align 4
  br label %if.end34

if.end34:                                         ; preds = %if.else27, %if.then24
  %38 = load i32, ptr %acc, align 4
  ret i32 %38
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
