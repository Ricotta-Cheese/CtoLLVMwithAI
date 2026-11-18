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
  %8 = load i32, ptr %x.addr, align 4
  %9 = load i32, ptr %i, align 4
  %add2 = add i32 %8, %9
  %10 = load i32, ptr %acc, align 4
  %sub = sub i32 %add2, %10
  %xor = xor i32 %7, %sub
  store i32 %xor, ptr %acc, align 4
  %11 = load i32, ptr %x.addr, align 4
  %12 = load i32, ptr %y.addr, align 4
  %xor3 = xor i32 %11, %12
  %13 = load i32, ptr %i, align 4
  %xor4 = xor i32 %xor3, %13
  %and5 = and i32 %xor4, 67108864
  %cmp6 = icmp eq i32 %and5, 0
  br i1 %cmp6, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %y.addr, align 4
  %shl = shl i32 %15, 13
  %16 = load i32, ptr %i, align 4
  %17 = load i32, ptr %y.addr, align 4
  %mul7 = mul i32 %16, %17
  %xor8 = xor i32 %shl, %mul7
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %acc, align 4
  %or = or i32 %18, %19
  %20 = load i32, ptr %x.addr, align 4
  %shl9 = shl i32 %20, 7
  %and10 = and i32 %or, %shl9
  %add11 = add i32 %xor8, %and10
  %xor12 = xor i32 %14, %add11
  store i32 %xor12, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %i, align 4
  %23 = load i32, ptr %acc, align 4
  %xor13 = xor i32 %22, %23
  %xor14 = xor i32 %21, %xor13
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %x.addr, align 4
  %xor15 = xor i32 %24, %25
  store i32 %xor15, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %sub16 = sub i32 %28, -1
  %or17 = or i32 %27, %sub16
  %29 = load i32, ptr %i, align 4
  %30 = load i32, ptr %i, align 4
  %sub18 = sub i32 %29, %30
  %31 = load i32, ptr %y.addr, align 4
  %or19 = or i32 -775049930, %31
  %sub20 = sub i32 %sub18, %or19
  %add21 = add i32 %or17, %sub20
  %xor22 = xor i32 %26, %add21
  store i32 %xor22, ptr %acc, align 4
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
  %xor23 = xor i32 %33, %34
  %and24 = and i32 %xor23, 512
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else33

if.then26:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %y.addr, align 4
  %xor27 = xor i32 %36, %37
  %xor28 = xor i32 %xor27, -831698109
  %38 = load i32, ptr %y.addr, align 4
  %39 = load i32, ptr %acc, align 4
  %and29 = and i32 %38, %39
  %shl30 = shl i32 %and29, 2
  %sub31 = sub i32 %xor28, %shl30
  %xor32 = xor i32 %35, %sub31
  store i32 %xor32, ptr %acc, align 4
  br label %if.end37

if.else33:                                        ; preds = %for.end
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %acc, align 4
  %42 = load i32, ptr %acc, align 4
  %mul34 = mul i32 %41, %42
  %mul35 = mul i32 0, %mul34
  %xor36 = xor i32 %40, %mul35
  store i32 %xor36, ptr %acc, align 4
  br label %if.end37

if.end37:                                         ; preds = %if.else33, %if.then26
  %43 = load i32, ptr %acc, align 4
  ret i32 %43
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
