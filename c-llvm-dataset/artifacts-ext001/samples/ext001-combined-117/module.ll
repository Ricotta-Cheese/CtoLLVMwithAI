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
  %shl = shl i32 %9, 10
  %sub = sub i32 3, %shl
  %and2 = and i32 %8, %sub
  %xor = xor i32 %7, %and2
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %11 = load i32, ptr %y.addr, align 4
  %xor3 = xor i32 %10, %11
  %12 = load i32, ptr %i, align 4
  %xor4 = xor i32 %xor3, %12
  %and5 = and i32 %xor4, 2048
  %cmp6 = icmp eq i32 %and5, 0
  br i1 %cmp6, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %i, align 4
  %xor7 = xor i32 %13, %14
  store i32 %xor7, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %y.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %add8 = add i32 %17, 15
  %18 = load i32, ptr %x.addr, align 4
  %19 = load i32, ptr %acc, align 4
  %sub9 = sub i32 %18, %19
  %add10 = add i32 %add8, %sub9
  %mul11 = mul i32 %16, %add10
  %xor12 = xor i32 %15, %mul11
  store i32 %xor12, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %y.addr, align 4
  %xor13 = xor i32 16, %21
  %22 = load i32, ptr %y.addr, align 4
  %23 = load i32, ptr %y.addr, align 4
  %and14 = and i32 %22, %23
  %add15 = add i32 %xor13, %and14
  %24 = load i32, ptr %i, align 4
  %shr = lshr i32 %24, 15
  %25 = load i32, ptr %i, align 4
  %26 = load i32, ptr %y.addr, align 4
  %or = or i32 %25, %26
  %and16 = and i32 %shr, %or
  %and17 = and i32 %add15, %and16
  %xor18 = xor i32 %20, %and17
  store i32 %xor18, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %i, align 4
  %add19 = add i32 3, %28
  %29 = load i32, ptr %y.addr, align 4
  %30 = load i32, ptr %acc, align 4
  %xor20 = xor i32 %29, %30
  %add21 = add i32 %add19, %xor20
  %xor22 = xor i32 %27, %add21
  store i32 %xor22, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %31 = load i32, ptr %i, align 4
  %inc = add i32 %31, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %32 = load i32, ptr %x.addr, align 4
  %33 = load i32, ptr %y.addr, align 4
  %xor23 = xor i32 %32, %33
  %and24 = and i32 %xor23, 1024
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else30

if.then26:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %shl27 = shl i32 %35, 1
  %shl28 = shl i32 %shl27, 19
  %xor29 = xor i32 %34, %shl28
  store i32 %xor29, ptr %acc, align 4
  br label %if.end40

if.else30:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %x.addr, align 4
  %and31 = and i32 %37, %38
  %xor32 = xor i32 %36, %and31
  store i32 %xor32, ptr %acc, align 4
  %39 = load i32, ptr %acc, align 4
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %x.addr, align 4
  %mul33 = mul i32 %40, %41
  %shr34 = lshr i32 %mul33, 0
  %42 = load i32, ptr %acc, align 4
  %43 = load i32, ptr %y.addr, align 4
  %or35 = or i32 %42, %43
  %44 = load i32, ptr %x.addr, align 4
  %45 = load i32, ptr %acc, align 4
  %sub36 = sub i32 %44, %45
  %sub37 = sub i32 %or35, %sub36
  %and38 = and i32 %shr34, %sub37
  %xor39 = xor i32 %39, %and38
  store i32 %xor39, ptr %acc, align 4
  br label %if.end40

if.end40:                                         ; preds = %if.else30, %if.then26
  %46 = load i32, ptr %acc, align 4
  ret i32 %46
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
