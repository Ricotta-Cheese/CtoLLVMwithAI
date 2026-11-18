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
  %shl = shl i32 %8, 6
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %sub = sub i32 %9, %10
  %mul = mul i32 %shl, %sub
  %xor = xor i32 %7, %mul
  store i32 %xor, ptr %acc, align 4
  %11 = load i32, ptr %x.addr, align 4
  %12 = load i32, ptr %y.addr, align 4
  %xor3 = xor i32 %11, %12
  %13 = load i32, ptr %i, align 4
  %xor4 = xor i32 %xor3, %13
  %and5 = and i32 %xor4, 4
  %cmp6 = icmp eq i32 %and5, 0
  br i1 %cmp6, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %y.addr, align 4
  %16 = load i32, ptr %x.addr, align 4
  %and7 = and i32 %15, %16
  %sub8 = sub i32 %and7, -1
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %x.addr, align 4
  %add9 = add i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %x.addr, align 4
  %sub10 = sub i32 %19, %20
  %or = or i32 %add9, %sub10
  %mul11 = mul i32 %sub8, %or
  %xor12 = xor i32 %14, %mul11
  store i32 %xor12, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %y.addr, align 4
  %shl13 = shl i32 %22, 19
  %xor14 = xor i32 %shl13, 0
  %23 = load i32, ptr %x.addr, align 4
  %shl15 = shl i32 %23, 28
  %shl16 = shl i32 %shl15, 30
  %mul17 = mul i32 %xor14, %shl16
  %xor18 = xor i32 %21, %mul17
  store i32 %xor18, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %x.addr, align 4
  %26 = load i32, ptr %acc, align 4
  %shr = lshr i32 %26, 15
  %xor19 = xor i32 %25, %shr
  %shr20 = lshr i32 %xor19, 14
  %xor21 = xor i32 %24, %shr20
  store i32 %xor21, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %27 = load i32, ptr %i, align 4
  %inc = add i32 %27, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %28 = load i32, ptr %x.addr, align 4
  %29 = load i32, ptr %y.addr, align 4
  %xor22 = xor i32 %28, %29
  %and23 = and i32 %xor22, 256
  %cmp24 = icmp eq i32 %and23, 0
  br i1 %cmp24, label %if.then25, label %if.else32

if.then25:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %x.addr, align 4
  %32 = load i32, ptr %y.addr, align 4
  %mul26 = mul i32 %31, %32
  %33 = load i32, ptr %x.addr, align 4
  %34 = load i32, ptr %y.addr, align 4
  %sub27 = sub i32 %33, %34
  %add28 = add i32 %mul26, %sub27
  %xor29 = xor i32 %30, %add28
  store i32 %xor29, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %y.addr, align 4
  %mul30 = mul i32 %36, %37
  %xor31 = xor i32 %35, %mul30
  store i32 %xor31, ptr %acc, align 4
  br label %if.end40

if.else32:                                        ; preds = %for.end
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %x.addr, align 4
  %and33 = and i32 %39, 0
  %shr34 = lshr i32 %and33, 30
  %xor35 = xor i32 %38, %shr34
  store i32 %xor35, ptr %acc, align 4
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %acc, align 4
  %42 = load i32, ptr %acc, align 4
  %and36 = and i32 %41, %42
  %43 = load i32, ptr %acc, align 4
  %44 = load i32, ptr %x.addr, align 4
  %and37 = and i32 %43, %44
  %add38 = add i32 %and36, %and37
  %xor39 = xor i32 %40, %add38
  store i32 %xor39, ptr %acc, align 4
  br label %if.end40

if.end40:                                         ; preds = %if.else32, %if.then25
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
