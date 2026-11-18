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
  %8 = load i32, ptr %i, align 4
  %9 = load i32, ptr %acc, align 4
  %add3 = add i32 %8, %9
  %10 = load i32, ptr %y.addr, align 4
  %11 = load i32, ptr %y.addr, align 4
  %or = or i32 %10, %11
  %sub = sub i32 %add3, %or
  %shr = lshr i32 %sub, 5
  %xor = xor i32 %7, %shr
  store i32 %xor, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %xor4 = xor i32 %12, %13
  store i32 %xor4, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor6 = xor i32 %xor5, %16
  %and7 = and i32 %xor6, 1048576
  %cmp8 = icmp eq i32 %and7, 0
  br i1 %cmp8, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %i, align 4
  %shr9 = lshr i32 %18, 22
  %mul = mul i32 15, %shr9
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %x.addr, align 4
  %add10 = add i32 %19, %20
  %add11 = add i32 %add10, 62
  %mul12 = mul i32 %mul, %add11
  %xor13 = xor i32 %17, %mul12
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %y.addr, align 4
  %xor14 = xor i32 %21, %22
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %23 = load i32, ptr %i, align 4
  %inc = add i32 %23, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %24 = load i32, ptr %x.addr, align 4
  %25 = load i32, ptr %y.addr, align 4
  %xor15 = xor i32 %24, %25
  %and16 = and i32 %xor15, 524288
  %cmp17 = icmp eq i32 %and16, 0
  br i1 %cmp17, label %if.then18, label %if.else20

if.then18:                                        ; preds = %for.end
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %27, 7
  %xor19 = xor i32 %26, %shl
  store i32 %xor19, ptr %acc, align 4
  br label %if.end23

if.else20:                                        ; preds = %for.end
  %28 = load i32, ptr %acc, align 4
  %xor21 = xor i32 %28, -536870912
  store i32 %xor21, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %x.addr, align 4
  %xor22 = xor i32 %29, %30
  store i32 %xor22, ptr %acc, align 4
  br label %if.end23

if.end23:                                         ; preds = %if.else20, %if.then18
  %31 = load i32, ptr %acc, align 4
  ret i32 %31
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
