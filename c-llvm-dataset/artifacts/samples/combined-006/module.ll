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
  %8 = load i32, ptr %x.addr, align 4
  %sub = sub i32 16, %8
  %9 = load i32, ptr %x.addr, align 4
  %shr = lshr i32 %9, 14
  %sub3 = sub i32 %sub, %shr
  %shl = shl i32 %sub3, 0
  %xor = xor i32 %7, %shl
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %11 = load i32, ptr %y.addr, align 4
  %xor4 = xor i32 %10, %11
  %12 = load i32, ptr %i, align 4
  %xor5 = xor i32 %xor4, %12
  %and6 = and i32 %xor5, 536870912
  %cmp7 = icmp eq i32 %and6, 0
  br i1 %cmp7, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %i, align 4
  %15 = load i32, ptr %i, align 4
  %xor8 = xor i32 %14, %15
  %shl9 = shl i32 %xor8, 23
  %16 = load i32, ptr %i, align 4
  %xor10 = xor i32 7, %16
  %17 = load i32, ptr %i, align 4
  %shr11 = lshr i32 %17, 3
  %or = or i32 %xor10, %shr11
  %mul = mul i32 %shl9, %or
  %xor12 = xor i32 %13, %mul
  store i32 %xor12, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %y.addr, align 4
  %add13 = add i32 %19, %20
  %xor14 = xor i32 %18, %add13
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %21 = load i32, ptr %i, align 4
  %inc = add i32 %21, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %22 = load i32, ptr %x.addr, align 4
  %23 = load i32, ptr %y.addr, align 4
  %xor15 = xor i32 %22, %23
  %and16 = and i32 %xor15, 1
  %cmp17 = icmp eq i32 %and16, 0
  br i1 %cmp17, label %if.then18, label %if.else22

if.then18:                                        ; preds = %for.end
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %x.addr, align 4
  %or19 = or i32 7, %25
  %xor20 = xor i32 %24, %or19
  store i32 %xor20, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %xor21 = xor i32 %26, 3
  store i32 %xor21, ptr %acc, align 4
  br label %if.end25

if.else22:                                        ; preds = %for.end
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %y.addr, align 4
  %and23 = and i32 %28, %29
  %xor24 = xor i32 %27, %and23
  store i32 %xor24, ptr %acc, align 4
  br label %if.end25

if.end25:                                         ; preds = %if.else22, %if.then18
  %30 = load i32, ptr %acc, align 4
  ret i32 %30
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
