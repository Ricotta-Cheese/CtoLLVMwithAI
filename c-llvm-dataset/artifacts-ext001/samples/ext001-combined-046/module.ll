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
  %or = or i32 -1, %8
  %shl = shl i32 %or, 23
  %xor = xor i32 %7, %shl
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %shr = lshr i32 %10, 29
  %xor3 = xor i32 %9, %shr
  store i32 %xor3, ptr %acc, align 4
  %11 = load i32, ptr %x.addr, align 4
  %12 = load i32, ptr %y.addr, align 4
  %xor4 = xor i32 %11, %12
  %13 = load i32, ptr %i, align 4
  %xor5 = xor i32 %xor4, %13
  %and6 = and i32 %xor5, 4096
  %cmp7 = icmp eq i32 %and6, 0
  br i1 %cmp7, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor8 = xor i32 %15, 3
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %and9 = and i32 %16, %17
  %or10 = or i32 %xor8, %and9
  %add11 = add i32 %or10, 0
  %xor12 = xor i32 %14, %add11
  store i32 %xor12, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %x.addr, align 4
  %or13 = or i32 %19, %20
  %21 = load i32, ptr %x.addr, align 4
  %22 = load i32, ptr %x.addr, align 4
  %and14 = and i32 %21, %22
  %add15 = add i32 %or13, %and14
  %xor16 = xor i32 %18, %add15
  store i32 %xor16, ptr %acc, align 4
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %x.addr, align 4
  %and17 = and i32 3, %24
  %25 = load i32, ptr %acc, align 4
  %or18 = or i32 %25, 158644098
  %26 = load i32, ptr %x.addr, align 4
  %add19 = add i32 31, %26
  %sub = sub i32 %or18, %add19
  %sub20 = sub i32 %and17, %sub
  %xor21 = xor i32 %23, %sub20
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
  %and23 = and i32 %xor22, 2
  %cmp24 = icmp eq i32 %and23, 0
  br i1 %cmp24, label %if.then25, label %if.else30

if.then25:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %x.addr, align 4
  %shr26 = lshr i32 %31, 20
  %32 = load i32, ptr %acc, align 4
  %and27 = and i32 %shr26, %32
  %xor28 = xor i32 %30, %and27
  store i32 %xor28, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %mul = mul i32 3, %34
  %xor29 = xor i32 %33, %mul
  store i32 %xor29, ptr %acc, align 4
  br label %if.end35

if.else30:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %x.addr, align 4
  %and31 = and i32 %37, 3
  %mul32 = mul i32 %and31, 3
  %xor33 = xor i32 %36, %mul32
  %xor34 = xor i32 %35, %xor33
  store i32 %xor34, ptr %acc, align 4
  br label %if.end35

if.end35:                                         ; preds = %if.else30, %if.then25
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
