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
  %shr = lshr i32 %8, 14
  %9 = load i32, ptr %i, align 4
  %10 = load i32, ptr %x.addr, align 4
  %and3 = and i32 %9, %10
  %xor = xor i32 %shr, %and3
  %xor4 = xor i32 %7, %xor
  store i32 %xor4, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %i, align 4
  %shl = shl i32 %12, 1
  %13 = load i32, ptr %x.addr, align 4
  %or = or i32 %shl, %13
  %xor5 = xor i32 %11, %or
  store i32 %xor5, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %16
  %and8 = and i32 %xor7, 128
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %y.addr, align 4
  %shl10 = shl i32 %18, 13
  %19 = load i32, ptr %x.addr, align 4
  %shl11 = shl i32 %19, 16
  %xor12 = xor i32 %shl10, %shl11
  %xor13 = xor i32 %17, %xor12
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %y.addr, align 4
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %acc, align 4
  %and14 = and i32 %22, %23
  %sub = sub i32 %21, %and14
  %24 = load i32, ptr %acc, align 4
  %add15 = add i32 0, %24
  %25 = load i32, ptr %i, align 4
  %add16 = add i32 %add15, %25
  %and17 = and i32 %sub, %add16
  %xor18 = xor i32 %20, %and17
  store i32 %xor18, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %and19 = and i32 %27, %28
  %shl20 = shl i32 %and19, 31
  %and21 = and i32 0, %shl20
  %xor22 = xor i32 %26, %and21
  store i32 %xor22, ptr %acc, align 4
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
  %xor23 = xor i32 %30, %31
  %and24 = and i32 %xor23, 4194304
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else29

if.then26:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %xor27 = xor i32 %32, 0
  store i32 %xor27, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %y.addr, align 4
  %xor28 = xor i32 %33, %34
  store i32 %xor28, ptr %acc, align 4
  br label %if.end35

if.else29:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %x.addr, align 4
  %37 = load i32, ptr %acc, align 4
  %and30 = and i32 %36, %37
  %shr31 = lshr i32 %and30, 30
  %xor32 = xor i32 %35, %shr31
  store i32 %xor32, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %y.addr, align 4
  %shl33 = shl i32 %39, 31
  %xor34 = xor i32 %38, %shl33
  store i32 %xor34, ptr %acc, align 4
  br label %if.end35

if.end35:                                         ; preds = %if.else29, %if.then26
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
